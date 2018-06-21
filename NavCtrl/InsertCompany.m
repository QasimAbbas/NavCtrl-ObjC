//
//  InsertCompany.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/20/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "InsertCompany.h"
#import "Company.h"
#import "DataAccessObject.h"

@interface InsertCompany ()

@end

@implementation InsertCompany

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"View Loaded");
    // Do any additional setup after loading the view.
    
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButton)];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    self.navigationItem.rightBarButtonItem = save;
    self.navigationItem.leftBarButtonItem = cancel;
    
    
}

-(void)save{
    
    if([_lblCompanyName.text isEqualToString:@""]){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Company Name" message:@"Please Enter a Company Name" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
         
         [self presentViewController:alert animated:true completion:nil];
         
    }else if(![UIImage imageNamed:_lblCompanyImage.text]){
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Image" message:@"Image Does Not Exist" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
        
    }else{
        Company *newCompany = [[Company alloc] init];
        newCompany.name = _lblCompanyName.text;
        newCompany.image = _lblCompanyImage.text;
        
        NSLog(@"Company: %@ Image: %@", newCompany.name, newCompany.image);
        [DataAccessObject.sharedDataAccessObject.companyList addObject:newCompany];
        
        [self.navigationController popViewControllerAnimated:true];
    }
    

    
}

-(void)cancelButton{

    [self.navigationController popViewControllerAnimated:true];
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

- (void)dealloc {
    [_lblCompanyName release];
    [_lblCompanyImage release];
    [super dealloc];
}
@end
