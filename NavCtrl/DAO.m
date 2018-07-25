//
//  DAO.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "Defaults.h"
#import "CompanyMO+CoreDataClass.h"
#import "ProductMO+CoreDataClass.h"

@implementation DAO


- (instancetype)init
{
    self = [super init];
    if (self) {
      
        self.companyImages = [[[NSMutableDictionary<NSString *, NSData *> alloc] init] autorelease];
        self.productImages = [[[NSMutableDictionary<NSString *, NSData *> alloc] init] autorelease];
        [self loadPersistanceContainer];
       
    }
    return self;
}

+(DAO *)sharedDAO{
    static DAO *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DAO alloc] init];

    });
    
    return sharedInstance;
}

-(void)loadPersistanceContainer{
    
    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"NavCtrl"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *description, NSError *error) {
        if (error != nil) {
            NSLog(@"Failed to load Core Data stack: %@", error);
            abort();
        }
    }];
    
    self.persistentContainer.viewContext.undoManager = [[NSUndoManager alloc] init];
    self.managedObjectContext = self.persistentContainer.viewContext;
}


-(void)saveContext{
    
    NSError *error = nil;
    if ([[self managedObjectContext] save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

//MARK: Company

-(void)insertCompany:(Company *)company{
    
    short count = 0;
    if([self fetchCompanyList].count){
        count = [self fetchCompanyList].count;
    }
    
    CompanyMO *companyMO = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:[self managedObjectContext]];
    [companyMO setName:company.name];
    [companyMO setImage:company.image];
    [companyMO setPrice:company.price.floatValue];
    [companyMO setTickerSymbol:company.tickerSymbol];
    [companyMO setIndex:count];
    for(Product *product in company.products){
        
        [self insertProduct:product inCompany:company];
    }
    
    [self saveContext];
}

-(void)removeCompany:(Company *)company{
    CompanyMO *getCompany = [self getCompanyFromCoreData:company];
    [self.managedObjectContext deleteObject:getCompany];
    
    [self saveContext];
}

-(void)removeAllCompanies{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSBatchDeleteRequest * deleteRequest = [[[NSBatchDeleteRequest alloc] autorelease] initWithFetchRequest:fetchRequest];
    
    NSError *error = nil;
    [self.managedObjectContext executeRequest:deleteRequest error:&error];
    
}

-(void)setCompanyPrice:(Company *)company{
    CompanyMO *companyMO = [self getCompanyFromCoreData:company];
    [companyMO setPrice:company.price.floatValue];
    [self saveContext];
}

-(void)moveCompany:(Company *)company toIndex:(NSInteger)index{
    NSMutableArray<CompanyMO *> * companyList = [[NSMutableArray alloc] initWithArray:[self fetchCompanyList]];
    CompanyMO *companyMO = [self getCompanyFromCoreData:company];
    [companyList removeObject:companyMO];
    [companyList insertObject:companyMO atIndex:index];
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSError *error = nil;
    NSArray<CompanyMO *> *companies = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    
    short count = 0;
    for(CompanyMO *ref in companyList){
        CompanyMO * company = [companies filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", ref.name]].firstObject;
        [company setIndex:count];
        count++;
    }
    [self saveContext];
}

-(CompanyMO *)getCompanyFromCoreData:(Company *)company{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"name == %@", company.name]];
    NSError *error = nil;
    
    return (CompanyMO *)[self.managedObjectContext executeFetchRequest:fetch error:&error].firstObject;
    
}


-(NSArray<Company*> *)fetchCompanyList{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSError *error = nil;
    NSArray *companies = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:true];
    companies = [companies sortedArrayUsingDescriptors:@[sort]];
    
    NSMutableArray<Company*> *companyArray = [[[NSMutableArray<Company*> alloc] init] autorelease];
    for(CompanyMO *companyMO in companies){
        Company *company = [[Company alloc] initWithName:companyMO.name image:companyMO.image symbol:companyMO.tickerSymbol];
        [company setPrice:[NSNumber numberWithFloat:companyMO.price]];
        
        NSArray *sortCompanyProducts = [companyMO.products allObjects];
        sortCompanyProducts = [sortCompanyProducts sortedArrayUsingDescriptors:@[sort]];
        
        for(ProductMO *productMO in sortCompanyProducts){
            Product *product = [[Product alloc] initWithName:productMO.name image:productMO.image productURL:productMO.url];
            [company.products addObject:product];
        }
        
        
        
        [companyArray addObject:company];
    }
 
    return companyArray;

}


//MARK: Product

-(void)insertProduct:(Product *) product inCompany:(Company *)company{
    NSArray *products = [self fetchProductListFromCompany:company];
    CompanyMO *companyMO = [self getCompanyFromCoreData:company];
    
    short count = 0;
    if(products){
        count = products.count;
    }
    
    ProductMO *productMO =[NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:[self managedObjectContext]];
    
    [productMO setName:product.name];
    [productMO setImage:product.imageURL];
    [productMO setUrl:product.productURL];
    [productMO setIndex:count];
    
    NSLog(@"Inserting %@, %i",productMO.name, productMO.index);
    
    [companyMO setProducts:[companyMO.products setByAddingObject:productMO]];
    
    [self saveContext];
}

-(void)removeProduct:(Product *) product inCompany:(Company *)company{
    ProductMO *productToRemove = [self getProduct:product fromCompany:company];
    [self.managedObjectContext deleteObject:productToRemove];
    
    [self saveContext];
    
}

-(ProductMO *)getProduct:(Product *)product fromCompany:(Company *)company{
    CompanyMO *fetchCompany = [self getCompanyFromCoreData:company];
    NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"SELF.name == %@", product.name];
    
    ProductMO *fetchProduct = [fetchCompany.products filteredSetUsingPredicate:myPredicate].anyObject;
    return fetchProduct;
}

-(NSArray *)fetchProductListFromCompany:(Company *)company{

    CompanyMO *companyMO = [self getCompanyFromCoreData:company];
//    NSLog(@"Entering Fetch Call");
    
    NSArray *productsArrayMO = [companyMO.products allObjects];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:true];
    productsArrayMO = [productsArrayMO sortedArrayUsingDescriptors:@[sort]];
    
    NSMutableArray<Product*> *productsArray = [[NSMutableArray<Product*> alloc] init];
    
//    NSArray *sortCompanyProducts = [companyMO.products allObjects];
//    sortCompanyProducts = [sortCompanyProducts sortedArrayUsingDescriptors:@[sort]];
    for(ProductMO *productMO in productsArrayMO){
        Product *product = [[Product alloc] initWithName:productMO.name image:productMO.image productURL:productMO.url];
        
        [productsArray addObject:product];
    }
    
    return productsArray;
}

-(void)dealloc{
    [_companyList release];
    [super dealloc];
}


@end

