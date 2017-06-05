//
//  MyAttentionViewCell.m
//  ecshop
//
//  Created by Jin on 15/12/31.
//  Copyright © 2015年 jsyh. All rights reserved.
//

#import "MyAttentionViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MyAttentionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(GoodsModel *)model{
    
    self.labName.text = model.goods_name;
    self.labName.font = [UIFont systemFontOfSize:15];
//    self.labPrice.text = model.goodsPrice;
    self.labPrice.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    self.labPrice.textColor = [UIColor redColor];
    self.labPrice.font = [UIFont systemFontOfSize:15];
    if ([model.goods_img isEqualToString:@"nil"]) {
        [self.imgView setImage:[UIImage imageNamed:@"180.png"]];
    }else{
        [self.imgView setImageWithURL:[NSURL URLWithString:model.goods_img]];
    }
}
@end
