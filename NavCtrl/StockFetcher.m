//
//  StockFetcher.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/25/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "StockFetcher.h"

@implementation StockFetcher


-(void)fetchStockPriceFromSymbol:(NSString *)symbol{
    if([self.delegate respondsToSelector:@selector(stockFetchDidStart)]){
        [self.delegate stockFetchDidStart];
    }
    
    if([self.delegate respondsToSelector:@selector(stockFetchDidFinishDownloading:)]){
        [self.delegate stockFetchDidFinishDownloading:false];
    }
    
    NSString *urlString = [NSString stringWithFormat:(@"https://api.iextrading.com/1.0/stock/market/batch?symbols=%@&types=price"), symbol];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *session = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if(error){
            
            NSLog(@"Stock error %@", [error localizedDescription]);
//            if([self.delegate respondsToSelector:@selector(stockFetchDidFailWithError:)]){
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.delegate stockFetchDidFailWithError:error];
//                    if([self.delegate respondsToSelector:@selector(stockFetchDidFinishDownloading:)]){
//                        [self.delegate stockFetchDidFinishDownloading:true];
//                    }
//
//                });
//            }
        }else{
            if([self.delegate respondsToSelector:@selector(getStockPrice:)]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                   // NSDictionary *symbolAndPrice = [[NSDictionary alloc] init];
                    NSMutableDictionary<NSString *, NSNumber *> *symbolPrice = [[NSMutableDictionary alloc] init];
                    //NSLog([object valueForKey:@"price"]);
                    
                    for(NSString *key in jsonObject.allKeys){
                        NSNumber *num = [[jsonObject objectForKey:key] valueForKey:@"price"];
                        [symbolPrice setObject:num forKey:key];
                    }
                    
                    NSDictionary<NSString *, NSNumber *> * dict = symbolPrice;
                    [self.delegate getStockPrice:dict];
                    
                    [symbolPrice release];
//                    if([self.delegate respondsToSelector:@selector(stockFetchDidFinishDownloading:)]){
//                        [self.delegate stockFetchDidFinishDownloading:true];
//                    }
                    
                });
            }
            
        }
        
    }];
    
    [session resume];
                                     
    
    
}

@end
