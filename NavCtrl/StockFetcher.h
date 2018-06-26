//
//  StockFetcher.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/25/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockFetcherDelegate.h"

@interface StockFetcher : NSObject

@property(nonatomic, retain)id<StockFetcherDelegate> delegate;
-(void)fetchStockPriceFromSymbol:(NSString *)symbol;


@end
