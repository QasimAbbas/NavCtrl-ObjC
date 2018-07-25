//
//  NoProducts.m
//  NavCtrl
//
//  Created by Qasim Abbas on 7/12/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "NoProducts.h"
#import "NavControllerAppDelegate.h"
#import "ProductVC.h"

@interface NoProducts ()

@end

@implementation NoProducts

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _addProduct = [[InsertProductVC alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnAddProduct:(id)sender {
    
    NavControllerAppDelegate *navController = (NavControllerAppDelegate *)[UIApplication sharedApplication].delegate;
    [self.addProduct setCompany:self.company];
    [navController.navigationController pushViewController:self.addProduct animated:true];
}

-(void)dealloc{
   
    [_addProduct release];
    [_company release];
    
    [super dealloc];
}
@end
