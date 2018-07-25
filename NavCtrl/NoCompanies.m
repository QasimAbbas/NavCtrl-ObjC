//
//  NoCompanies.m
//  NavCtrl
//
//  Created by Qasim Abbas on 7/10/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "NoCompanies.h"
#import "InsertCompany.h"
#import "CompanyVC.h"
#import "NavControllerAppDelegate.h"

@interface NoCompanies (){
    NavControllerAppDelegate *navController;
}

@end

@implementation NoCompanies

- (void)viewDidLoad {
    [super viewDidLoad];
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


- (IBAction)addCompany:(id)sender {
    navController = (NavControllerAppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSLog(@"SELECTED ADD");
    InsertCompany *insert = [[[InsertCompany alloc] init] autorelease];
    [navController.navigationController pushViewController:insert animated:true];
    
    
}
-(void)dealloc{
    
    [navController release];
    [super dealloc];
}
@end
