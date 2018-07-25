//
//  DAO.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import <CoreData/CoreData.h>
#import "CompanyMO+CoreDataClass.h"

@interface DAO : NSObject

@property(nonatomic, retain)NSMutableArray<Company *> *companyList;
@property (nonatomic, retain) NSPersistentContainer *persistentContainer;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
-(void)saveContext;
+(DAO *)sharedDAO;

//Company
-(void)insertCompany:(Company *)company;
-(void)removeCompany:(Company *)company;
-(void)removeAllCompanies;
-(void)setCompanyPrice:(Company *)company;
-(void)moveCompany:(Company *)company toIndex:(NSInteger)index;
-(CompanyMO *)getCompanyFromCoreData:(Company *)company;
-(NSArray<Company*> *)fetchCompanyList;


//Product
-(void)insertProduct:(Product *) product inCompany:(Company *)company;
-(void)removeProduct:(Product *) product inCompany:(Company *)company;
-(ProductMO *)getProduct:(Product *)product fromCompany:(Company *)company;
-(NSArray *)fetchProductListFromCompany:(Company *)company;

//Image
@property(nonatomic, retain)NSMutableDictionary<NSString *, NSData *> *companyImages;
@property(nonatomic, retain)NSMutableDictionary<NSString *, NSData *> *productImages;

@end
