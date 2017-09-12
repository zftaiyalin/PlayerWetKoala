//
//  HongTableViewCell.m
//  RedEnvelopes
//
//  Created by 安风 on 2017/5/30.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import "HongTableViewCell.h"
#import "Masonry.h"
#import "YYCategories.h"


@implementation HongTableViewCell{

    UILabel *titleLabel;/*打乱代码结构*/
    UILabel *timeLabel;/*打乱代码结构*/
    UILabel *sizeLabel;/*打乱代码结构*/
    UILabel *kanLabel;/*打乱代码结构*/
}

- (void)awakeFromNib {
    [super awakeFromNib];/*打乱代码结构*/
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];/*打乱代码结构*/

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];/*打乱代码结构*/
    if (self) {
        
        
        
        titleLabel = [[UILabel alloc]init];/*打乱代码结构*/
        titleLabel.font = [UIFont systemFontOfSize:15];/*打乱代码结构*/
        titleLabel.textColor = [UIColor colorWithHexString:@"#63B8FF"];/*打乱代码结构*/
        [self.contentView addSubview:titleLabel];/*打乱代码结构*/
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(13);/*打乱代码结构*/
            make.left.equalTo(self.contentView).offset(23);/*打乱代码结构*/
            make.height.mas_equalTo(20);/*打乱代码结构*/
        }];/*打乱代码结构*/
        
        timeLabel = [[UILabel alloc]init];/*打乱代码结构*/
        timeLabel.textColor = [UIColor colorWithHexString:@"#63B8FF"];/*打乱代码结构*/
        timeLabel.font = [UIFont systemFontOfSize:13];/*打乱代码结构*/
        [self.contentView addSubview:timeLabel];/*打乱代码结构*/
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);/*打乱代码结构*/
            make.left.equalTo(titleLabel);/*打乱代码结构*/
            make.height.mas_equalTo(15);/*打乱代码结构*/
        }];/*打乱代码结构*/
        
        
        sizeLabel = [[UILabel alloc]init];/*打乱代码结构*/
        sizeLabel.textColor = [UIColor colorWithHexString:@"#63B8FF"];/*打乱代码结构*/
        sizeLabel.font = [UIFont systemFontOfSize:13];/*打乱代码结构*/
        [self.contentView addSubview:sizeLabel];/*打乱代码结构*/
        
        [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);/*打乱代码结构*/
            make.left.equalTo(timeLabel.mas_right).offset(13);/*打乱代码结构*/
            make.height.mas_equalTo(15);/*打乱代码结构*/
        }];/*打乱代码结构*/
        
        UILabel *zeLabel = [[UILabel alloc]init];/*打乱代码结构*/
        zeLabel.textColor = [UIColor colorWithHexString:@"#63B8FF"];/*打乱代码结构*/
        zeLabel.font = [UIFont systemFontOfSize:13];/*打乱代码结构*/
        zeLabel.text = @"源1";/*打乱代码结构*/
        [self.contentView addSubview:zeLabel];/*打乱代码结构*/
        
        [zeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);/*打乱代码结构*/
            make.left.equalTo(sizeLabel.mas_right).offset(13);/*打乱代码结构*/
            make.height.mas_equalTo(15);/*打乱代码结构*/
        }];/*打乱代码结构*/
        
        kanLabel = [[UILabel alloc]init];/*打乱代码结构*/
        kanLabel.textColor = [UIColor colorWithHexString:@"#FF4040"];/*打乱代码结构*/
        kanLabel.font = [UIFont systemFontOfSize:13];/*打乱代码结构*/
        kanLabel.text = @"[免费试看]";/*打乱代码结构*/
        [self.contentView addSubview:kanLabel];/*打乱代码结构*/
        
        [kanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);/*打乱代码结构*/
            make.left.equalTo(zeLabel.mas_right).offset(13);/*打乱代码结构*/
            make.height.mas_equalTo(15);/*打乱代码结构*/
        }];/*打乱代码结构*/
        

    }
    return self;/*打乱代码结构*/
}

-(void)setData:(VideoPlayModel *)model{
    NSString *time = [NSString stringWithFormat:@"时长:%@",model.videotime];/*打乱代码结构*/
    NSString *size = [NSString stringWithFormat:@"大小:%@",model.videoSize];/*打乱代码结构*/
    titleLabel.text = model.videoTitle;/*打乱代码结构*/
    timeLabel.text = time;/*打乱代码结构*/
    sizeLabel.text = size;/*打乱代码结构*/
    kanLabel.hidden = model.videoUrl.length > 0 ? NO:YES;/*打乱代码结构*/
    
    
}
@end
