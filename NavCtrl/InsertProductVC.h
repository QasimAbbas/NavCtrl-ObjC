//
//  InsertProductVC.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/21/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@interface InsertProductVC : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *txtProductName;
@property (retain, nonatomic) IBOutlet UITextField *txtProductImage;
@property (retain, nonatomic) IBOutlet UITextField *txtProductURL;
@property (retain, nonatomic) NSNumber *edit;
@property (nonatomic, retain) Product *product;
@property (retain, nonatomic) IBOutlet UIButton *btnDelete;
- (IBAction)btnDeleting:(id)sender;

@property (retain, nonatomic) Company *company;

@end
