//
//  ProductWebViewController.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/1/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "InsertProductVC.h"
#import "Company.h"
#import "Product.h"

@interface ProductWebViewController : UIViewController <WKNavigationDelegate>
@property (retain, nonatomic) IBOutlet WKWebView *webView;
@property (nonatomic, retain)NSString* urlString;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic)InsertProductVC * insertProductVC;
@property (retain, nonatomic)Company *company;
@property (retain, nonatomic)Product *product;

@end
