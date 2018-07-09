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
}

-(void)removeCompany:(Company *)company{
    CompanyMO *getCompany = [self getCompanyFromCoreData:company];
    [self.managedObjectContext deleteObject:getCompany];
    
    [self saveContext];
}

-(void)removeAllCompanies{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSBatchDeleteRequest * deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:fetchRequest];
    
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
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", company.name]];
    NSError *error = nil;
    return [self.managedObjectContext executeFetchRequest:fetch error:&error].firstObject;
}


-(NSArray<Company*> *)fetchCompanyList{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSError *error = nil;
    NSArray *companies = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:true];
    companies = [companies sortedArrayUsingDescriptors:@[sort]];
    
    NSMutableArray<Company*> *companyArray = [[NSMutableArray<Company*> alloc] init];
    for(CompanyMO *companyMO in companies){
        Company *company = [[Company alloc] initWithName:companyMO.name image:companyMO.image symbol:companyMO.tickerSymbol];
        [company setPrice:[NSNumber numberWithFloat:companyMO.price]];
        
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
    
    [companyMO setProducts:[companyMO.products setByAddingObject:productMO]];
}

-(void)removeProduct:(Product *) product inCompany:(Company *)company{
    ProductMO *productToRemove = [self getProduct:product fromCompany:company];
    [self.managedObjectContext deleteObject:productToRemove];
    
}

-(ProductMO *)getProduct:(Product *)product fromCompany:(Company *)company{
    CompanyMO *fetchCompany = [self getCompanyFromCoreData:company];
    NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"SELF.name == %@", product.name];
    
    ProductMO *fetchProduct = [fetchCompany.products filteredSetUsingPredicate:myPredicate].anyObject;
    return fetchProduct;
}

-(NSArray *)fetchProductListFromCompany:(Company *)company{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", company.name]];
    NSError *error = nil;
    CompanyMO *companyMO = [self.managedObjectContext executeFetchRequest:fetch error:&error].firstObject;
    
    NSArray *productsArray = [companyMO.products allObjects];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:true];
    productsArray = [productsArray sortedArrayUsingDescriptors:@[sort]];
    return productsArray;
}



@end

