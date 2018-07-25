//
//  NoProducts.h
//  NavCtrl
//
//  Created by Qasim Abbas on 7/12/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "InsertProductVC.h"

@interface NoProducts : UIViewController
- (IBAction)btnAddProduct:(id)sender;
@property(nonatomic, retain)InsertProductVC *addProduct;
@property(nonatomic, retain)Company *company;

@end
