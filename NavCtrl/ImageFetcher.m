//
//  ImageFetcher.m
//  NavCtrl
//
//  Created by Qasim Abbas on 7/13/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "ImageFetcher.h"

@implementation ImageFetcher

-(void)fetchImageFromImageURL:(NSArray<NSString *> *)imageURLs{
    NSMutableDictionary<NSString *, NSData *> *imgDataDict = [[NSMutableDictionary alloc] init];
    
    dispatch_group_t group = dispatch_group_create();

    
    for(NSString *imageURL in imageURLs){
        dispatch_group_enter(group);
        NSURL *url = [NSURL URLWithString:imageURL];
    
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(data){
             
                [imgDataDict setObject:data forKey:imageURL];
            }
           
            
            dispatch_group_leave(group);
        }] resume];

    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"Done Fetching Images");
          if([self.delegate respondsToSelector:@selector(getImageFromURL:)]){
              [self.delegate getImageFromURL:imgDataDict];
          }
    });
    

}

-(void)dealloc{
    [_delegate release];
    [super dealloc];
}
@end
