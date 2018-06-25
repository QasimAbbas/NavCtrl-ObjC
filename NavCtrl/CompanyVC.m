//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"
#import "Company.h"
#import "DataAccessObject.h"

@interface CompanyVC ()

@end

@implementation CompanyVC

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    
    self.navigationItem.leftBarButtonItem = addButton;
    self.navigationItem.rightBarButtonItem = editButton;
    
    self.companyList = [DataAccessObject sharedDataAccessObject].companyList;
    
    self.title = @"Mobile device makers";
    // Do any additional setup after loading the view from its nib.
}



-(void)addItem{
    

    self.insertCompanyViewController = [[InsertCompany alloc] init];
    [self.navigationController pushViewController:_insertCompanyViewController animated:YES];

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
/*
 if ([self.title isEqualToString:@"Apple mobile devices"]) {
 self.products = @[@"iPad", @"iPod Touch",@"iPhone"];
 } else if([self.title isEqualToString:@"Samsung mobile devices"]){
 self.products = @[@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab"];
 }else if([self.title isEqualToString:@"Motorola mobile devices"]){
 self.products = @[@"Droid", @"Droid 2", @"Droid X"];
 }else if([self.title isEqualToString:@"Nokia mobile devices"]){
 self.products = @[@"Nokia 6", @"Nokia Lumia 635", @"Nokia Lumia 2520"];
 }else if([self.title isEqualToString:@"Huwawei mobile devices"]){
 self.products = @[@"HUAWEI Mate 10 Pro", @"HUAWEI Mate SE", @"PORSCHE DESIGN HUAWEI Mate 10"];
 }
*/





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
    
    Company *company = [self.companyList objectAtIndex:[indexPath row]];
    
    UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, cell.bounds.size.height, cell.bounds.size.height)];
    UIImage *img = [UIImage imageNamed: company.image];
    view.image = img;
    view.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width * 1.5, 0, cell.bounds.size.width, cell.bounds.size.height)];

    cellLabel.text = company.name;
    cellLabel.backgroundColor = UIColor.clearColor;
    
    [cell.contentView addSubview:view];
    [cell.contentView addSubview:cellLabel];
    
    
    
    return cell;
    
    
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
     [self.companyList removeObjectAtIndex:[indexPath row]];

     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
     
     NSLog(@"Insert Mode");
     
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     
    }
 }
 


 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
     Company *movedObject = [self.companyList objectAtIndex:[fromIndexPath row]];
     [self.companyList removeObjectAtIndex:[fromIndexPath row]];
     [self.companyList insertObject:movedObject atIndex:[toIndexPath row]];
     
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
    
    self.productViewController = [[ProductVC alloc]init];
    
    self.productViewController.title = [self.companyList objectAtIndex:[indexPath row]].name;
    self.productViewController.company = [self.companyList objectAtIndex:[indexPath row]];
    
    
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
    [_insertCompanyViewController release];
    [_productViewController release];
    [super dealloc];
}
@end
