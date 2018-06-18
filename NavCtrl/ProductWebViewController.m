//
//  ProductWebViewController.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/1/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "ProductWebViewController.h"


@interface ProductWebViewController ()

@end

@implementation ProductWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.navigationDelegate = self;
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [_activityIndicator stopAnimating];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_webView release];
    [_activityIndicator release];
    [super dealloc];
}
@end
