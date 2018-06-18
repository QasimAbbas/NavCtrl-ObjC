//
//  Company.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Company : NSObject

@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *image;

@property (nonatomic, retain)NSMutableArray<Product *> *products;


- (instancetype)initWithName: (NSString *)name image:(NSString *)image;


@end
