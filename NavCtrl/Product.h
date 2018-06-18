//
//  Product.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *imageURL;
@property (nonatomic, retain)NSString *productURL;

- (instancetype)initWithName: (NSString *)name image:(NSString *)imageURL productURL:(NSString *)productURL;

@end
