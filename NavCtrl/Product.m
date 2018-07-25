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
        [self setName:name];
        [self setImageURL:imageURL];
        [self setProductURL:productURL];
    }
    
    return self;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.imageURL = @"";
        self.productURL = @"";
    }
    return self;
}

-(void)dealloc{
    [_name release];
    [_imageURL release];
    [_productURL release];
    [super dealloc];
}
@end
