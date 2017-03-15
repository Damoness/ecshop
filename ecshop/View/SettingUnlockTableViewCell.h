//
//  SettingUnlockTableViewCell.h
//  ecshop
//
//  Created by 吴狄 on 2017/3/15.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingUnlockTableViewCell;
@protocol SettingUnlockTableViewCellDelegate <NSObject>

-(void)SettingUnlockTableViewCell:(SettingUnlockTableViewCell *)cell switchValueChanged:(BOOL)on;

@end


@interface SettingUnlockTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

@property (nonatomic,weak)id<SettingUnlockTableViewCellDelegate>delegate;

@end
