//
//  InsertCompany.h
//  NavCtrl
//
//  Created by Qasim Abbas on 6/20/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@interface InsertCompany : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *lblCompanyName;
@property (retain, nonatomic) IBOutlet UITextField *lblCompanyImage;
@property (retain, nonatomic) Company *company;

@end
