//
//  ImageFetcher.h
//  NavCtrl
//
//  Created by Qasim Abbas on 7/13/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageFetcherDelegate <NSObject>

@required 
-(void)getImageFromURL:(NSDictionary<NSString *, NSData *> *)imageURL;

@end
