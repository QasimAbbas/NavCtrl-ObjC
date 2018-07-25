//
//  InsertProductVC.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/21/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "InsertProductVC.h"
#import "Product.h"
#import "DAO.h"
#import "ProductMO+CoreDataClass.h"

@interface InsertProductVC (){
}

@end

@implementation InsertProductVC


-(void)viewWillAppear:(BOOL)animated{

    NSLog(@"DELETE BUTTON IS HIDDEN: %i", _edit.boolValue);
    [self.btnDelete setHidden:_edit.boolValue];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtProductURL.delegate = self;
    self.txtProductName.delegate = self;
    self.txtProductImage.delegate = self;
    
    
    if(self.product){
        
        self.txtProductName.text = self.product.name;
        self.txtProductImage.text = self.product.imageURL;
        self.txtProductURL.text = self.product.productURL;
        
    }
    
    [self txtBorders:self.txtProductName];
    [self txtBorders:self.txtProductImage];
    [self txtBorders: self.txtProductURL];
    
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action: @selector(cancel)];
    
   
    
    
}

-(void)txtBorders:(UITextField *)field{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, field.frame.size.height - 1, field.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [field.layer addSublayer:bottomBorder];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    CGRect keyboard = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    //    _lblCompanyName.frame = CGRectInset(_lblCompanyName.frame, 0, 0);
    
    float newVerticalPosition = -keyboard.size.height / 2;
    [self.btnDelete setHidden:true];
    [self moveFrameToVerticalPosition:newVerticalPosition forDuration:0.3f];
    
}


- (void)moveFrameToVerticalPosition:(float)position forDuration:(float)duration {
    CGRect frame = self.view.frame;
    frame.origin.y = position;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    [self moveFrameToVerticalPosition:0.0f forDuration:0.3f];
    [self.btnDelete setHidden:false];
}

-(void)save{
    
    
    if([_txtProductName.text isEqualToString:@""]){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Company Name" message:@"Please Enter a Company Name" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
        
    }else if([_txtProductImage.text isEqualToString:@""]){

        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Image Name" message:@"Please Enter an Image Name" preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];

        [self presentViewController:alert animated:true completion:nil];

    }else{
        

        if(self.product){
            
            ProductMO *productMO = [DAO.sharedDAO getProduct:self.product fromCompany:self.company];
            [productMO setName:self.product.name];
            [productMO setImage: self.product.imageURL];
            [productMO setUrl:self.product.productURL];
            
            [DAO.sharedDAO saveContext];
            
            [self.navigationController popViewControllerAnimated:true];
        }else{
            
            Product *product = [[[Product alloc] init] autorelease];
            
            product.name = _txtProductName.text;
            product.imageURL = _txtProductImage.text;
            product.productURL = _txtProductURL.text;
            
            [DAO.sharedDAO insertProduct:product inCompany:self.company];
            
            [self.navigationController popViewControllerAnimated:true];
           
        }
        
        
      
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(void)cancel{
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (IBAction)btnDeleting:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure you want to delete this Product?" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [DAO.sharedDAO removeProduct:self.product inCompany:self.company];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
    
    
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
    [_btnDelete release];
    [super dealloc];
}

@end
