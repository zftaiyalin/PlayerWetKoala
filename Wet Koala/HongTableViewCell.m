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

    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *sizeLabel;
    UILabel *kanLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorWithHexString:@"#63B8FF"];
        [self.contentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(13);
            make.left.equalTo(self.contentView).offset(23);
            make.height.mas_equalTo(20);
        }];
        
        timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = [UIColor colorWithHexString:@"#63B8FF"];
        timeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeLabel];
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.left.equalTo(titleLabel);
            make.height.mas_equalTo(15);
        }];
        
        
        sizeLabel = [[UILabel alloc]init];
        sizeLabel.textColor = [UIColor colorWithHexString:@"#63B8FF"];
        sizeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:sizeLabel];
        
        [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.left.equalTo(timeLabel.mas_right).offset(13);
            make.height.mas_equalTo(15);
        }];
        
        UILabel *zeLabel = [[UILabel alloc]init];
        zeLabel.textColor = [UIColor colorWithHexString:@"#63B8FF"];
        zeLabel.font = [UIFont systemFontOfSize:13];
        zeLabel.text = @"源1";
        [self.contentView addSubview:zeLabel];
        
        [zeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.left.equalTo(sizeLabel.mas_right).offset(13);
            make.height.mas_equalTo(15);
        }];
        
        kanLabel = [[UILabel alloc]init];
        kanLabel.textColor = [UIColor colorWithHexString:@"#FF4040"];
        kanLabel.font = [UIFont systemFontOfSize:13];
        kanLabel.text = @"[免费试看]";
        [self.contentView addSubview:kanLabel];
        
        [kanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.left.equalTo(zeLabel.mas_right).offset(13);
            make.height.mas_equalTo(15);
        }];
        

    }
    return self;
}

-(void)setData:(VideoPlayModel *)model{
    NSString *time = [NSString stringWithFormat:@"时长:%@",model.videotime];
    NSString *size = [NSString stringWithFormat:@"大小:%@",model.videoSize];
    titleLabel.text = model.videoTitle;
    timeLabel.text = time;
    sizeLabel.text = size;
    kanLabel.hidden = model.videoUrl.length > 0 ? NO:YES;
    
    
}
@end
