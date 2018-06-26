//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/18/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"


@implementation DataAccessObject


- (instancetype)init
{
    self = [super init];
    if (self) {
        _companyList = self.createDefaultCompanyList;
    }
    return self;
}


+(DataAccessObject *)sharedDataAccessObject{
    static DataAccessObject *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataAccessObject alloc] init];
    });
    
    return sharedInstance;
}



-(NSMutableArray<Company *> * )createDefaultCompanyList{
    NSMutableArray<Company *> * companyList = [[NSMutableArray<Company *> alloc] init];
    Company *company = [[Company alloc] initWithName:@"Apple mobile devices" image:@"img-companyLogo_0" symbol:@"AAPL"];

    
    [company.products addObject:[[Product alloc] initWithName:@"iPad" image:@"iPad" productURL:@"https://www.apple.com/ipad/"]];
    [company.products addObject:[[Product alloc] initWithName:@"iPod Touch" image:@"iPod Touch" productURL:@"https://www.apple.com/ipod-touch/"]];
    [company.products addObject:[[Product alloc] initWithName:@"iPhone" image:@"iPhone" productURL:@"https://www.apple.com/iphone/"]];
    
    
    
    Company *company1 = [[Company alloc] initWithName:@"Samsung mobile devices" image: @"img-companyLogo_1" symbol:@""];
    [company1.products addObject:[[Product alloc] initWithName:@"Galaxy S4" image:@"Galaxy S4" productURL:@"https://www.samsung.com/uk/smartphones/galaxy-s4-i9505/GT-I9505ZWABTU/"]];
    [company1.products addObject:[[Product alloc] initWithName:@"Galaxy Note" image:@"Galaxy Note" productURL:@"https://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb/"]];
    [company1.products addObject:[[Product alloc] initWithName:@"Galaxy Tab" image:@"Galaxy Tab" productURL:@"https://www.samsung.com/us/mobile/tablets/"]];
    
    
    Company *company2 = [[Company alloc] initWithName:@"Motorola mobile devices" image: @"img-companyLogo_2" symbol:@"MSI"];
    
    [company2.products addObject:[[Product alloc] initWithName:@"Droid" image:@"Droid" productURL:@"https://www.motorola.com/us/home"]];
    [company2.products addObject:[[Product alloc] initWithName:@"Droid 2" image:@"Droid 2" productURL:@"https://www.motorola.com/us/home"]];
    [company2.products addObject:[[Product alloc] initWithName:@"Droid X" image:@"Droid X" productURL:@"https://www.motorola.com/us/home"]];
    
    
    Company *company3 = [[Company alloc] initWithName:@"Nokia mobile devices" image: @"img-companyLogo_3" symbol:@"NOK"];
    
    [company3.products addObject:[[Product alloc] initWithName:@"Nokia 6" image:@"Nokia 6" productURL:@"https://www.nokia.com/en_int/phones/nokia-6"]];
    [company3.products addObject:[[Product alloc] initWithName:@"Nokia Lumia 635" image:@"Nokia Lumia 635" productURL:@"https://www.microsoft.com/en-us/mobile/phone/lumia635"]];
    [company3.products addObject:[[Product alloc] initWithName:@"Nokia Lumia 2520" image:@"Nokia Lumia 2520" productURL:@"https://www.verizonwireless.com/support/knowledge-base-84166/"]];
    
    
    
    Company *company4 = [[Company alloc] initWithName:@"Huwawei mobile devices" image: @"img-companyLogo_4" symbol:@""];
    
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


@end
