//
//  Company.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company


- (instancetype)initWithName: (NSString *)name image:(NSString *)image
{
    [self init];
    self = [super init];
    if (self) {
        _name = name;
        _products = [[NSMutableArray alloc] init];
        _image = image;
    }
    return self;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"";
        _products = [[NSMutableArray alloc] init];
        _image = @"iPhone";
    }
    return self;
}

- (void)dealloc
{
    [_products release];
    [super dealloc];
}


@end
