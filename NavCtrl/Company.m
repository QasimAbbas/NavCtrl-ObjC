//
//  Company.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company


- (instancetype)initWithName: (NSString *)name image:(NSString *)image symbol:(NSString *)symbol
{
    [self init];
    self = [super init];
    if (self) {
        [self setName:name];
        _products = [[NSMutableArray alloc] init];
        [self setImage:image];
        [self setTickerSymbol:symbol];
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
        _tickerSymbol = @"";
        _price = [[NSNumber alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [_image release];
    [_tickerSymbol release];
    [_price release];
    [_products release];
    [super dealloc];
}


@end
