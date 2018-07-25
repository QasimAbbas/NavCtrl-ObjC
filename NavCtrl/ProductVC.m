//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"
#import "ProductWebViewController.h"
#import "InsertProductVC.h"
#import "DAO.h"
#import "NoProducts.h"
#import "ImageFetcher.h"

@interface ProductVC (){
    NoProducts *noProducts;
}

@property(nonatomic, retain)ImageFetcher* imageFetcher;

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageFetcher = [[ImageFetcher alloc] init];
    self.imageFetcher.delegate = self;
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    
    [self.tableView setAllowsSelectionDuringEditing:true];
    noProducts = [[NoProducts alloc] init];
    [noProducts setCompany:self.company];
    // Do any additional setup after loading the view from its nib.
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [self.txtCompanyName setText:[NSString stringWithFormat:@"%@ (%@)", self.company.name, self.company.tickerSymbol]];
    
   
    NSLog(@"%lu", (unsigned long)self.products.count);
    self.products = [[NSMutableArray alloc] initWithArray:[DAO.sharedDAO fetchProductListFromCompany:self.company]];
    if(self.products.count){
     
        [self.imageFetcher fetchImageFromImageURL:[[DAO.sharedDAO fetchProductListFromCompany:self.company] valueForKeyPath:@"imageURL"]];
    }
    
    [self.imgLogo setImage:[UIImage imageWithData:[DAO.sharedDAO.companyImages objectForKey:self.company.image]]];
    self.imgLogo.contentMode = UIViewContentModeScaleAspectFit;
    
    NSLog(@"%@" ,self.company.name);
    
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Image Fetcher
-(void)getImageFromURL:(NSDictionary<NSString *, NSData *> *)imageURL{
    
    [DAO.sharedDAO.productImages removeAllObjects];
    [DAO.sharedDAO.productImages addEntriesFromDictionary:imageURL];
    NSLog(@"%@", imageURL.allKeys);
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if(!self.products.count){
        
        noProducts.view.frame = self.view.bounds;
        self.tableView.backgroundView = noProducts.view;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    }else{
        self.tableView.backgroundView = [[UIView alloc] initWithFrame:self.tableView.bounds];
        self.tableView.separatorStyle = UITableViewCellSelectionStyleDefault;
    }
    
    
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    // Configure the cell...
    
    Product *product = [self.products objectAtIndex:[indexPath row]];
    NSLog(@"PRODUCT NAME: %@", product.name);
    
    UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, cell.bounds.size.height, cell.bounds.size.height)];
    
    UIImage *img = [UIImage imageWithData:[DAO.sharedDAO.productImages objectForKey:product.imageURL]];
    view.image = img;
    view.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width * 1.5, 0, cell.bounds.size.width, cell.bounds.size.height)];
    cellLabel.backgroundColor = UIColor.clearColor;
    
    [cellLabel setText:product.name];

    view.tag = 0;
    cellLabel.tag = 1;
    [cell.contentView addSubview:view];
    [cell.contentView addSubview:cellLabel];
    
    return cell;
}


- (void)setEditing:(BOOL)editing
          animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing];
    
    if(editing){
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
        
    }else{
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    }
    
    
}

-(void)addItem{
    
    NSLog(@"Adding new item");
    self.insertProductVC = [[InsertProductVC alloc] init];
    self.insertProductVC.company = self.company;
    self.insertProductVC.title = self.company.name;
    self.insertProductVC.edit = [NSNumber numberWithBool:false];
    
    [self.navigationController pushViewController:self.insertProductVC animated:true];
    
}



 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         // Delete the row from the data source
         [DAO.sharedDAO removeProduct:[self.company.products objectAtIndex:[indexPath row]] inCompany:self.company];
         [self.products removeObjectAtIndex:[indexPath row]];
         
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         
         if(self.products.count == 0){
             NSLog(@"LAST ONE");
             [self.tableView reloadData];
         }
         
     }else if (editingStyle == UITableViewCellEditingStyleInsert) {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     
 }
 


 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
     Product* movedObject = [self.company.products objectAtIndex:[fromIndexPath row]];
     [self.company.products removeObjectAtIndex:[fromIndexPath row]];
     [self.company.products insertObject:movedObject atIndex:[toIndexPath row]];
     
 }
 


 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 


 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here, for example:
 // Create the next view controller.
     if([tableView isEditing]){
         
         Product *editProduct = [self.company.products objectAtIndex:[indexPath row]];
         self.insertProductVC = [[InsertProductVC alloc] init];
         self.insertProductVC.product = editProduct;
         self.insertProductVC.company = self.company;
         [self.navigationController pushViewController:self.insertProductVC animated:true];
         
         
         
     }else{
         self.webViewController = [[ProductWebViewController alloc] init];
         self.webViewController.title = [self.company.products objectAtIndex:[indexPath row]].name;
         self.webViewController.urlString = [self.company.products objectAtIndex:[indexPath row]].productURL;
         self.webViewController.product = [self.company.products objectAtIndex:[indexPath row]];
         self.webViewController.company = self.company;
         
         // Push the view controller.
         [self.navigationController pushViewController:_webViewController animated:YES];
     }
 // Pass the selected object to the new view controller.
     
 }
 
 


- (void)dealloc {
    [_products release];
    [_tableView release];
    [_webViewController release];
    [_insertProductVC release];
    [_company release];
    [noProducts release];
    [_imgLogo release];
    [_txtCompanyName release];
    [_imageFetcher release];
    [super dealloc];
}
@end
