//
//  Company.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (instancetype)initWithName: (NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        _products = [[NSMutableArray alloc] init];
    }
    return self;
    
}

- (void)dealloc
{
    [_products release];
    [super dealloc];
}

@end
