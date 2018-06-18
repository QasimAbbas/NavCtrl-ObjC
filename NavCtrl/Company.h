//
//  Company.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSMutableArray*products;
- (instancetype)initWithName: (NSString *)name;

+(Company *)defaultCompanyList;

@end
