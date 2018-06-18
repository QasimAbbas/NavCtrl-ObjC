//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"

@interface DataAccessObject : NSObject

@property(nonatomic, retain)NSMutableArray<Company *> *companyList;

+(DataAccessObject *)sharedDataAccessObject;

@end
