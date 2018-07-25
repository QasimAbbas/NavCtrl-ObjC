//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"
#import "Company.h"
#import "DAO.h"
#import "StockFetcher.h"
#import "CompanyCell.h"
#import "NoCompanies.h"
#import "ImageFetcher.h"


@interface CompanyVC (){
    UIView *backgroundView;
    NoCompanies *emptyView;
}

@property(nonatomic, retain)StockFetcher *fetcher;
@property(nonatomic, retain)ImageFetcher *imgFetcher;

@end

@implementation CompanyVC

#pragma mark -  LoadVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if(DAO.sharedDAO.fetchCompanyList.count){
        [self.fetcher fetchStockPriceFromSymbol:[[[DAO.sharedDAO fetchCompanyList] valueForKeyPath:@"tickerSymbol"] componentsJoinedByString:@","]];
        
        [self.imgFetcher fetchImageFromImageURL:[[DAO.sharedDAO fetchCompanyList] valueForKeyPath:@"image"]];
        
        }
    [self loadCompanies];
    
 }


-(void) loadCompanies {
    //  NSLog(@"%i", [DAO.sharedDAO.managedObjectContext undoManager].canRedo);
    
    self.companyList = [[[NSMutableArray alloc] initWithArray:DAO.sharedDAO.fetchCompanyList] autorelease];
    
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    emptyView = [[NoCompanies alloc] init];
    self.fetcher = [[[StockFetcher alloc]init] autorelease];
    self.fetcher.delegate = self;
    
    self.imgFetcher = [[[ImageFetcher alloc] init] autorelease];
    self.imgFetcher.delegate = self;
    
    [self.tableView setAllowsSelectionDuringEditing:true];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem *editButton = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.leftBarButtonItem = editButton;
    
    
    
    self.title = @"Mobile device makers";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//MARK: Set Navigation Bar Items

-(void)addItem{
    
    self.insertCompanyViewController = [[[InsertCompany alloc] init] autorelease];
    self.insertCompanyViewController.edit = [NSNumber numberWithBool:true];
    [self.navigationController pushViewController:_insertCompanyViewController animated:YES];

}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    if(editing){
        
        [self.btnUndoOutlet setHidden:false];
        [self.btnRedoOutlet setHidden:false];
    }else{

        [self.btnUndoOutlet setHidden:true];
        [self.btnRedoOutlet setHidden:true];
    }
    
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing];
    
}

- (IBAction)btnUndoAction:(id)sender {
    //NSLog(@"UNDO");
    [DAO.sharedDAO.managedObjectContext.undoManager undo];
   // [DAO.sharedDAO.managedObjectContext.undoManager undo];
    [DAO.sharedDAO saveContext];
    [self loadCompanies];
}

- (IBAction)btnRedoAction:(id)sender {
    NSLog(@"REDO");
    
    [DAO.sharedDAO.managedObjectContext redo];
     [self loadCompanies];
}

#pragma mark - Stock Fetcher

- (void)getStockPrice:(NSDictionary<NSString *, NSNumber *> *)price {
    
    for(NSString *key in price.allKeys){
        
        Company *company = self.companyList[[self.companyList indexOfObject:[[self.companyList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.tickerSymbol == %@", key]] objectAtIndex:0]]];
        //
        CompanyMO *setPrice = [DAO.sharedDAO getCompanyFromCoreData:company];
        [setPrice setPrice:[price valueForKey:key].floatValue];
        
    }
    
    self.companyList = [[[NSMutableArray alloc] initWithArray:DAO.sharedDAO.fetchCompanyList] autorelease];
    
    [self.tableView reloadData];
}

-(void)stockFetchDidFinishDownloading:(BOOL) status{
    
}

#pragma mark - Image Fetcher

- (void)getImageFromURL:(NSDictionary<NSString *,NSData *> *)imageURL {
    
    [DAO.sharedDAO.companyImages removeAllObjects];
    [DAO.sharedDAO.companyImages addEntriesFromDictionary:imageURL];
    
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
    
    if(self.companyList.count != 0){
        //NSLog(@"In Here");
        self.tableView.backgroundView = [[[UIView alloc] initWithFrame:self.tableView.frame] autorelease];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [backgroundView release];
        return [self.companyList count];
        
    }else{

          tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
        emptyView.view.frame = self.view.bounds;
       // [self.view addSubview:emptyView.view];
        tableView.backgroundView = emptyView.view;
        self.view.backgroundColor = UIColor.redColor;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    Company *company = [self.companyList objectAtIndex:[indexPath row]];
    
    UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, cell.bounds.size.height, cell.bounds.size.height)];
    UIImage *img = [UIImage imageWithData:[DAO.sharedDAO.companyImages objectForKey:company.image]];
    
    view.image = img;
    view.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *cellLabel = [[[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width * 1.5, 0, cell.bounds.size.width, cell.bounds.size.height)] autorelease];
    
    UILabel *detailCellLabel = [[[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width * 0.5 - 20, 0, cell.bounds.size.width - 10, cell.bounds.size.height)] autorelease];
    
    detailCellLabel.textAlignment = NSTextAlignmentRight;
    detailCellLabel.text = [NSString stringWithFormat:@"%.2f", company.price.floatValue];
    cellLabel.text = company.name;
    cellLabel.backgroundColor = UIColor.clearColor;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", company.name, company.tickerSymbol]; //company.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", company.price.floatValue];
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
    [DAO.sharedDAO removeCompany:[self.companyList objectAtIndex:[indexPath row]]];
     [self.companyList removeObjectAtIndex:[indexPath row]];
    
    
     
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     
     if(self.companyList.count == 0){
         NSLog(@"LAST ONE");
         [self.tableView reloadData];
     }
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
     [DAO.sharedDAO moveCompany:movedObject toIndex:[toIndexPath row]];
     
     
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
    if([self.tableView isEditing]){
        self.insertCompanyViewController = [[[InsertCompany alloc] init] autorelease];
        
        self.insertCompanyViewController.company = [self.companyList objectAtIndex:[indexPath row]];
        
        [self.navigationController pushViewController:self.insertCompanyViewController animated:YES];
        
        
    }else{
        
        self.productViewController = [[[ProductVC alloc]init] autorelease];
        self.productViewController.title = [self.companyList objectAtIndex:[indexPath row]].name;
        self.productViewController.company = [self.companyList objectAtIndex:[indexPath row]];
        
       // NSLog(@"Sending Company: %@, with products %@", self.productViewController.title, [self.productViewController.company.products valueForKey:@"name"]);
        
        [self.navigationController
         pushViewController:self.productViewController
         animated:YES];
    }
    
   
    
}



- (void)dealloc {
    [_tableView release];
    [_companyList release];
    [_insertCompanyViewController release];
    [_productViewController release];
    [_btnUndoOutlet release];
    [_btnRedoOutlet release];
    [emptyView release];
    [_fetcher release];
    [_imgFetcher release];

    [super dealloc];
}





@end
