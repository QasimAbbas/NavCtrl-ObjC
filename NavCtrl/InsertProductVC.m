//
//  InsertProductVC.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/21/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "InsertProductVC.h"
#import "Product.h"
#import "DataAccessObject.h"

@interface InsertProductVC ()

@end

@implementation InsertProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _txtProductURL.delegate = self;
    _txtProductName.delegate = self;
    _txtProductImage.delegate = self;
    
    
    if(self.product){
        self.txtProductName.text = self.product.name;
        self.txtProductImage.text = self.product.imageURL;
        self.txtProductURL.text = self.product.productURL;
        
    }
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action: @selector(cancel)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

-(void)keyboardWillShow:(NSNotification *)notification{
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = CGRectInset(self.view.frame, 0, -CGRectGetHeight(keyboardEndFrame));
    
    
    if(self.txtProductName.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  
                                  self.txtProductName.frame = frame;
                                  [self.txtProductImage setHidden:true];
                                  [self.txtProductURL setHidden:true];
                              } completion:nil];
        
    }else if(self.txtProductImage.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  self.txtProductImage.frame = frame;
                                  [self.txtProductName setHidden:true];
                                  [self.txtProductURL setHidden:true];
                                  
                              } completion:nil];
    
    }else if(self.txtProductURL.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  self.txtProductURL.frame = frame;
                                  [self.txtProductImage setHidden:true];
                                  [self.txtProductURL setHidden:true];
                                  
                              } completion:nil];
    }
}

-(void)keyboardWillHide:(NSNotification *)notification{
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = CGRectInset(self.view.frame, 0, +CGRectGetHeight(keyboardEndFrame));
    
    
    if(self.txtProductName.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  
                                  self.txtProductName.frame = frame;
                                  [self.txtProductImage setHidden:false];
                                  [self.txtProductURL setHidden:false];
                              } completion:nil];
        
    }else if(self.txtProductImage.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  self.txtProductImage.frame = frame;
                                  [self.txtProductName setHidden:false];
                                  [self.txtProductURL setHidden:false];
                                  
                              } completion:nil];
        
    }else if(self.txtProductURL.isFirstResponder){
        [UIView animateWithDuration:duration
                              delay:0.0 options:options animations:^{
                                  self.txtProductURL.frame = frame;
                                  [self.txtProductImage setHidden:false];
                                  [self.txtProductURL setHidden:false];
                                  
                              } completion:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)save{
    
    
    if([_txtProductName.text isEqualToString:@""]){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Company Name" message:@"Please Enter a Company Name" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
        
    }else if(![UIImage imageNamed:_txtProductImage.text]){
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Image" message:@"Image Does Not Exist" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
        
    }else{
        
        Product *product = [[Product alloc] init];
        
        product.name = _txtProductName.text;
        product.imageURL = _txtProductImage.text;
        product.productURL = _txtProductURL.text;
        
        if([self.company.products containsObject:self.product]){
            
            [self.company.products replaceObjectAtIndex:[self.company.products indexOfObject:self.product] withObject:product];
            
        }else{
            [self.company.products addObject:product];
        }
        
        [self.navigationController popViewControllerAnimated:true];
        
    }
    
    
    
    
}

-(void)cancel{
    
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
    [_txtProductName release];
    [_txtProductImage release];
    [_txtProductURL release];
    [_product release];
    [super dealloc];
}
@end
