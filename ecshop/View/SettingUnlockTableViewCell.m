//
//  SettingUnlockTableViewCell.m
//  ecshop
//
//  Created by 吴狄 on 2017/3/15.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import "SettingUnlockTableViewCell.h"

@implementation SettingUnlockTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_mySwitch addTarget:self action:@selector(mySwitch_Action:
                                               ) forControlEvents:UIControlEventValueChanged];
    
}

-(void)mySwitch_Action:(UISwitch * )mySwitch{
    
    if (_delegate && [_delegate respondsToSelector:@selector(SettingUnlockTableViewCell:switchValueChanged:)]) {
        
        [_delegate SettingUnlockTableViewCell:self switchValueChanged:mySwitch.selected];
        
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
