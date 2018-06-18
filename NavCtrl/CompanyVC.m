//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"
#import "Company.h"

@interface CompanyVC ()

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    self.companyList = [self companies];
    
    
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



-(NSMutableArray<Company *> * )companies{
    NSMutableArray<Company *> * companyList = [[NSMutableArray<Company *> alloc] init];
    Company *company = [[Company alloc] initWithName:@"Apple mobile devices" image:@"img-companyLogo_0"];
    
    [company.products addObject:[[Product alloc] initWithName:@"iPad" image:@"iPad" productURL:@"https://www.apple.com/ipad/"]];
     [company.products addObject:[[Product alloc] initWithName:@"iPod Touch" image:@"iPod Touch" productURL:@"https://www.apple.com/ipod-touch/"]];
     [company.products addObject:[[Product alloc] initWithName:@"iPhone" image:@"iPhone" productURL:@"https://www.apple.com/iphone/"]];
    
    
    
    Company *company1 = [[Company alloc] initWithName:@"Samsung mobile devices" image: @"img-companyLogo_1"];
    [company1.products addObject:[[Product alloc] initWithName:@"Galaxy S4" image:@"Galaxy S4" productURL:@"https://www.samsung.com/uk/smartphones/galaxy-s4-i9505/GT-I9505ZWABTU/"]];
    [company1.products addObject:[[Product alloc] initWithName:@"Galaxy Note" image:@"Galaxy Note" productURL:@"https://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb/"]];
    [company1.products addObject:[[Product alloc] initWithName:@"Galaxy Tab" image:@"Galaxy Tab" productURL:@"https://www.samsung.com/us/mobile/tablets/"]];
    
    
    Company *company2 = [[Company alloc] initWithName:@"Motorola mobile devices" image: @"img-companyLogo_2"];
    
    [company2.products addObject:[[Product alloc] initWithName:@"Droid" image:@"Droid" productURL:@"https://www.motorola.com/us/home"]];
    [company2.products addObject:[[Product alloc] initWithName:@"Droid 2" image:@"Droid 2" productURL:@"https://www.motorola.com/us/home"]];
    [company2.products addObject:[[Product alloc] initWithName:@"Droid X" image:@"Droid X" productURL:@"https://www.motorola.com/us/home"]];
    

    Company *company3 = [[Company alloc] initWithName:@"Nokia mobile devices" image: @"img-companyLogo_3"];
    
    [company3.products addObject:[[Product alloc] initWithName:@"Nokia 6" image:@"Nokia 6" productURL:@"https://www.nokia.com/en_int/phones/nokia-6"]];
    [company3.products addObject:[[Product alloc] initWithName:@"Nokia Lumia 635" image:@"Nokia Lumia 635" productURL:@"https://www.microsoft.com/en-us/mobile/phone/lumia635"]];
    [company3.products addObject:[[Product alloc] initWithName:@"Nokia Lumia 2520" image:@"Nokia Lumia 2520" productURL:@"https://www.verizonwireless.com/support/knowledge-base-84166/"]];
    
    
    
    Company *company4 = [[Company alloc] initWithName:@"Huwawei mobile devices" image: @"img-companyLogo_4"];
    
    [company4.products addObject:[[Product alloc] initWithName:@"HUAWEI Mate 10 Pro" image:@"HUAWEI Mate 10 Pro" productURL:@"https://consumer.huawei.com/en/phones/mate10-pro/"]];
    [company4.products addObject:[[Product alloc] initWithName:@"HUAWEI Mate SE" image:@"HUAWEI Mate SE" productURL:@"https://consumer.huawei.com/us/phones/mate-se/"]];
    [company4.products addObject:[[Product alloc] initWithName:@"PORSCHE DESIGN HUAWEI Mate 10" image:@"PORSCHE DESIGN HUAWEI Mate 10" productURL:@"https://consumer.huawei.com/us/phones/porsche-design-mate10/"]];
    
    [companyList addObject:company];
    [companyList addObject:company1];
    [companyList addObject:company2];
    [companyList addObject:company3];
    [companyList addObject:company4];
    
    return companyList;
    
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
    
    Company *company = [self.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = company.name;
    
    UIImage *img = [UIImage imageNamed: company.image];
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


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
     [self.companyList removeObjectAtIndex:[indexPath row]];

     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
    [super dealloc];
}
@end
