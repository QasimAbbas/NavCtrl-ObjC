//
//  ProductVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductWebViewController.h"
#import "Company.h"
#import "InsertProductVC.h"
#import "ImageFetcherDelegate.h"

@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource, ImageFetcherDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) ProductWebViewController * webViewController;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) InsertProductVC *insertProductVC;
@property (retain, nonatomic) IBOutlet UIImageView *imgLogo;
@property (retain, nonatomic) IBOutlet UILabel *txtCompanyName;


@end
