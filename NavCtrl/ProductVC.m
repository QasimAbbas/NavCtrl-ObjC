//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"
#import "ProductWebViewController.h"
@interface ProductVC ()

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.company.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    Product *product = [self.company.products objectAtIndex:[indexPath row]];
    
    UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, cell.bounds.size.height, cell.bounds.size.height)];
    UIImage *img = [UIImage imageNamed: product.imageURL];
    view.image = img;
    view.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width * 1.5, 0, cell.bounds.size.width, cell.bounds.size.height)];
    cellLabel.text = product.name;
    cellLabel.backgroundColor = UIColor.clearColor;

    
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
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
     
     [self.company.products removeObjectAtIndex:[indexPath row]];
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
     self.webViewController = [[ProductWebViewController alloc] init];
     self.webViewController.title = [self.company.products objectAtIndex:[indexPath row]].name;
     self.webViewController.urlString = [self.company.products objectAtIndex:[indexPath row]].productURL;
 // Pass the selected object to the new view controller.
     
    
 
 // Push the view controller.
 [self.navigationController pushViewController:_webViewController animated:YES];
 }
 
 


- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
