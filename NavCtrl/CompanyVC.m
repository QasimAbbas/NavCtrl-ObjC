//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"

@interface CompanyVC ()

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    
    self.companyList = @[@"Apple mobile devices",@"Samsung mobile devices", @"Motorola mobile devices", @"Nokia mobile devices", @"Huwawei mobile devices"];
    self.title = @"Mobile device makers";
    // Do any additional setup after loading the view from its nib.
}

- (void)toggleEditMode {
    
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Edit";
    } else {
        [self.tableView setEditing:YES animated:NO];
        self.navigationItem.rightBarButtonItem.title = @"Done";
    }
    
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
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.companyList objectAtIndex:[indexPath row]];
    
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"img-companyLogo_%li", [indexPath row]]];
    img = [self imageWithImage:img scaledToSize: CGSizeMake(cell.frame.size.height* 0.85, cell.frame.size.height * 0.85)];
    
    cell.imageView.image = img;
    return cell;
    
    
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.productViewController = [[ProductVC alloc]init];
    if (indexPath.row == 0){
        self.productViewController.title = @"Apple mobile devices";
    } else if(indexPath.row == 1){
        self.productViewController.title = @"Samsung mobile devices";
    }else if(indexPath.row == 2){
        self.productViewController.title = @"Motorola mobile devices";
    }else if(indexPath.row == 3){
        self.productViewController.title = @"Nokia mobile devices";
    }else if(indexPath.row == 4){
        self.productViewController.title = @"Huwawei mobile devices";
    }
    
    [self.navigationController
     pushViewController:self.productViewController
     animated:YES];
    
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
    [_tableView release];
    [_companyList release];
    [super dealloc];
}
@end
