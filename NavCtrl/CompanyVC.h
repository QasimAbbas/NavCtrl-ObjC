//
//  CompanyVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductVC.h"
#import "Company.h"
#import "InsertCompany.h"
#import "StockFetcherDelegate.h"

@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource, StockFetcherDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray<Company *> *companyList;
@property (nonatomic, retain) ProductVC *productViewController;
-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@property (nonatomic, retain) InsertCompany *insertCompanyViewController;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] 

@end
