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


@end
