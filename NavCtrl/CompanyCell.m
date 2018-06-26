//
//  CompanyCell.m
//  NavCtrl
//
//  Created by Qasim Abbas on 6/26/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "CompanyCell.h"

@implementation CompanyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization co
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(10, 0, self.frame.size.height, self.frame.size.height);
    self.textLabel.frame = CGRectMake(self.imageView.frame.size.width + 20, 0, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(self.imageView.frame.size.width + 20, self.detailTextLabel.frame.origin.y, self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height);
}

@end
