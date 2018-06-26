//
//  StockFetcherDelegate.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/25/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StockFetcherDelegate <NSObject>

@required
-(void)getStockPrice:(NSDictionary<NSString *, NSNumber *> *)price;

@optional
-(void)stockFetchDidFailWithError: (NSError*) error;
-(void)stockFetchDidStart;
-(void)stockFetchDidFinishDownloading:(BOOL) status;


@end
