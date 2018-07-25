//
//  Defaults.m
//  NavCtrl
//
//  Created by Qasim Abbas on 7/2/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Defaults.h"
#import "Company.h"
#import "CompanyMO+CoreDataClass.h"
#import "DAO.h"

@implementation Defaults

+(void)createDefaultCompanyList{
    NSMutableArray<Company *> * companyList = [[NSMutableArray<Company *> alloc] init];
    Company *company = [[[Company alloc] initWithName:@"Apple mobile devices" image:@"img-companyLogo_0" symbol:@"AAPL"] autorelease];
    
    
    [company.products addObject:[[[Product alloc] initWithName:@"iPad" image:@"iPad" productURL:@"https://www.apple.com/ipad/"] autorelease]];
    [company.products addObject:[[[Product alloc] initWithName:@"iPod Touch" image:@"iPod Touch" productURL:@"https://www.apple.com/ipod-touch/"]autorelease]];
    [company.products addObject:[[[Product alloc] initWithName:@"iPhone" image:@"iPhone" productURL:@"https://www.apple.com/iphone/"]autorelease]];
    
    
    
    Company *company1 = [[[Company alloc] initWithName:@"Samsung mobile devices" image: @"img-companyLogo_1" symbol:@""] autorelease];
    [company1.products addObject:[[[Product alloc] initWithName:@"Galaxy S4" image:@"Galaxy S4" productURL:@"https://www.samsung.com/uk/smartphones/galaxy-s4-i9505/GT-I9505ZWABTU/"]autorelease]];
    [company1.products addObject:[[[Product alloc] initWithName:@"Galaxy Note" image:@"Galaxy Note" productURL:@"https://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb/"]autorelease]];
    [company1.products addObject:[[[Product alloc] initWithName:@"Galaxy Tab" image:@"Galaxy Tab" productURL:@"https://www.samsung.com/us/mobile/tablets/"]autorelease]];
    
    
    Company *company2 = [[[Company alloc] initWithName:@"Motorola mobile devices" image: @"img-companyLogo_2" symbol:@"MSI"]autorelease];
    
    [company2.products addObject:[[[Product alloc] initWithName:@"Droid" image:@"Droid" productURL:@"https://www.motorola.com/us/home"]autorelease]];
    [company2.products addObject:[[[Product alloc] initWithName:@"Droid 2" image:@"Droid 2" productURL:@"https://www.motorola.com/us/home"]autorelease]];
    [company2.products addObject:[[[Product alloc] initWithName:@"Droid X" image:@"Droid X" productURL:@"https://www.motorola.com/us/home"]autorelease]];
    
    
    Company *company3 = [[[Company alloc] initWithName:@"Nokia mobile devices" image: @"img-companyLogo_3" symbol:@"NOK"]autorelease ];
    
    [company3.products addObject:[[[Product alloc] initWithName:@"Nokia 6" image:@"Nokia 6" productURL:@"https://www.nokia.com/en_int/phones/nokia-6"]autorelease]];
    [company3.products addObject:[[[Product alloc] initWithName:@"Nokia Lumia 635" image:@"Nokia Lumia 635" productURL:@"https://www.microsoft.com/en-us/mobile/phone/lumia635"]autorelease]];
    [company3.products addObject:[[[Product alloc] initWithName:@"Nokia Lumia 2520" image:@"Nokia Lumia 2520" productURL:@"https://www.verizonwireless.com/support/knowledge-base-84166/"]autorelease]];
    
    
    
    Company *company4 = [[[Company alloc] initWithName:@"Huwawei mobile devices" image: @"img-companyLogo_4" symbol:@""]autorelease];
    
    [company4.products addObject:[[[Product alloc] initWithName:@"HUAWEI Mate 10 Pro" image:@"HUAWEI Mate 10 Pro" productURL:@"https://consumer.huawei.com/en/phones/mate10-pro/"]autorelease]];
    [company4.products addObject:[[[Product alloc] initWithName:@"HUAWEI Mate SE" image:@"HUAWEI Mate SE" productURL:@"https://consumer.huawei.com/us/phones/mate-se/"]autorelease]];
    [company4.products addObject:[[[Product alloc] initWithName:@"PORSCHE DESIGN HUAWEI Mate 10" image:@"PORSCHE DESIGN HUAWEI Mate 10" productURL:@"https://consumer.huawei.com/us/phones/porsche-design-mate10/"]autorelease]];
    
    [companyList addObject:company];
    [companyList addObject:company1];
    [companyList addObject:company2];
    [companyList addObject:company3];
    [companyList addObject:company4];
    
    for(Company* companyLocal in companyList){
        [DAO.sharedDAO insertCompany:companyLocal];
    }
    
    [companyList release];
    
}
-(void)dealloc{
    
    [super dealloc];
}
     

@end
