//
//  Product.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product


- (instancetype)initWithName: (NSString *)name image:(NSString *)imageURL productURL:(NSString *)productURL
{
    self = [self init];
    if(self){
        _name = name;
        _imageURL = imageURL;
        _productURL = productURL;
    }
    
    return self;
    
}

@end
