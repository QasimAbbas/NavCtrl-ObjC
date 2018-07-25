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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(itemEdit)];
    _webView.navigationDelegate = self;
    
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];
    // Do any additional setup after loading the view.
}

-(void)itemEdit{
    
     NSLog(@"COMPANY BEFORE WEB %@", self.company.name);
    
    self.insertProductVC = [[[InsertProductVC alloc] init] autorelease];
    self.insertProductVC.company = self.company;
    self.insertProductVC.title = self.company.name;
    self.insertProductVC.product = self.product;
    self.insertProductVC.edit = [NSNumber numberWithBool:false];
    
    [self.navigationController pushViewController:self.insertProductVC animated:true];
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
    [_urlString release];
    [_company release];
    [_product release];
    [_insertProductVC release];
    
    [super dealloc];
}
@end
