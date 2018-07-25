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


-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.btnDelete setHidden:_edit.boolValue];
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"View Loaded");
    // Do any additional setup after loading the view
    self.lblCompanyName.delegate = self;
    self.lblCompanyImage.delegate = self;
    self.lblStockSymbol.delegate = self;
    [self.btnDelete setHidden:true];
    
    if(self.company){
        self.lblCompanyName.text = self.company.name;
        self.lblCompanyImage.text = self.company.image;
        self.lblStockSymbol.text = self.company.tickerSymbol;
        
        [self.btnDelete setHidden:false];
    }
    
    [self txtBorders:self.lblCompanyName];
    [self txtBorders:self.lblCompanyImage];
    [self txtBorders:self.lblStockSymbol];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButton)];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    self.navigationItem.rightBarButtonItem = save;
    self.navigationItem.leftBarButtonItem = cancel;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
    [self.btnDelete setHidden:false];
    [self moveFrameToVerticalPosition:0.0f forDuration:0.3f];
}

-(void)txtBorders:(UITextField *)field{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, field.frame.size.height - 1, field.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [field.layer addSublayer:bottomBorder];
}

-(void)save{
    
    if([_lblCompanyName.text isEqualToString:@""]){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Company Name" message:@"Please Enter a Company Name" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
         
         [self presentViewController:alert animated:true completion:nil];
        
        
    }else{
        Company *newCompany = [[Company alloc] init];
        newCompany.name = _lblCompanyName.text;
        newCompany.image = _lblCompanyImage.text;
        newCompany.tickerSymbol = _lblStockSymbol.text;
        
        if(self.company){
            CompanyMO *companyMO = [DAO.sharedDAO getCompanyFromCoreData:self.company];
            [companyMO setName:newCompany.name];
            [companyMO setImage:newCompany.image];
            [companyMO setTickerSymbol:newCompany.tickerSymbol];
            
            [DAO.sharedDAO saveContext];
        }else{
            [DAO.sharedDAO.companyList addObject:newCompany];
            [DAO.sharedDAO insertCompany:newCompany];
        }
        
        [newCompany release];
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
    [_company release];
    [_lblStockSymbol release];
    [_btnDelete release];
    [super dealloc];
}
- (IBAction)btnDeleting:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure you want to delete this Company?" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [DAO.sharedDAO removeCompany:self.company];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
    
}
@end
