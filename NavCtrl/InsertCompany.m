//
//  InsertCompany.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/20/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "InsertCompany.h"
#import "Company.h"
#import "DAO.h"

@interface InsertCompany ()

@end

@implementation InsertCompany

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"View Loaded");
    // Do any additional setup after loading the view
    self.lblCompanyName.delegate = self;
    self.lblCompanyImage.delegate = self;
    
    if(self.company){
        self.lblCompanyName.text = self.company.name;
        self.lblCompanyImage.text = self.company.image;
        
    }
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButton)];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    self.navigationItem.rightBarButtonItem = save;
    self.navigationItem.leftBarButtonItem = cancel;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)keyboardDidShow:(NSNotification *)notification{
    NSLog(@"Keyboard did show");
    
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    CGRect frame = CGRectInset(self.view.frame, 0, -CGRectGetHeight(keyboardEndFrame));
    
    
    if(self.lblCompanyName.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  
                                  self.lblCompanyName.frame = frame;
                                  [self.lblCompanyImage setHidden:true];
                              } completion:nil];
        
        NSLog(@"Moving Company Name");
        
    }else if(self.lblCompanyImage.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  self.lblCompanyName.frame = frame;
                                  [self.lblCompanyName setHidden:true];
                                  
                              } completion:nil];
        
        NSLog(@"Moving Company Image");
    }
    
  
}

-(void)keyboardWillHide:(NSNotification *)notification{
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = CGRectInset(_lblCompanyName.frame, 0, +CGRectGetHeight(keyboardEndFrame));
    
    if(self.lblCompanyName.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  self.lblCompanyName.frame = frame;
                                  [self.lblCompanyImage setHidden:false];
                              } completion:nil];
        
    }else if(self.lblCompanyImage.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  self.lblCompanyImage.frame = frame;
                                  [self.lblCompanyName setHidden:false];
                              } completion:nil];
    }
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
        
        if([DAO.sharedDAO.companyList containsObject:newCompany]){
            
            [DAO.sharedDAO.companyList replaceObjectAtIndex:[DAO.sharedDAO.companyList indexOfObject:newCompany] withObject:newCompany];
            
        }else{
             [DAO.sharedDAO.companyList addObject:newCompany];
        }
        
       
        
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
