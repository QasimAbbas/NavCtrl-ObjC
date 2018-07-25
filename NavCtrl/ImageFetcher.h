//
//  ImageFetcher.h
//  NavCtrl
//
//  Created by Qasim Abbas on 7/13/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageFetcherDelegate.h"

@interface ImageFetcher : NSObject

@property(nonatomic, retain)id<ImageFetcherDelegate> delegate;
-(void)fetchImageFromImageURL:(NSArray<NSString *> *)imageURLs;
@end
