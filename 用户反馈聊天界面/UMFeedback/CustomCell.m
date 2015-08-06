//
//  CustomCell.m
//  UMFeedback
//
//  Created by 郭达 on 15/5/7.
//  Copyright (c) 2015年 guoda. All rights reserved.
//

#import "CustomCell.h"
#import "UIView+GDQuickcontrol.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


#define LeftHeadImageViewFrame CGRectMake(5,5,44,44)
#define LeftMessageImageViewFrame CGRectMake(50,5,[UIScreen mainScreen].bounds.size.width-65-54,44)
#define LeftMessageLabelFrame CGRectMake(22,5,[UIScreen mainScreen].bounds.size.width-65-54-38,30)


#define RightHeadImageViewFrame CGRectMake([UIScreen mainScreen].bounds.size.width-50,5,44,44)
#define RightMessageImageViewFrame CGRectMake(65,5,[UIScreen mainScreen].bounds.size.width-65-54,44)
#define RightMessageLabelFrame CGRectMake(12,5,[UIScreen mainScreen].bounds.size.width-65-54-38,30)

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createCellView];
    }
    return self;
}
-(void)createCellView
{
    _contentLabel = [self.contentView addLabelWithFrame:LeftMessageLabelFrame text:nil];
    _headImageView = [[UIImageView alloc] initWithFrame:LeftHeadImageViewFrame];
    _headImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_headImageView];
    
    _MessageImageView = [[UIImageView alloc] initWithFrame:LeftMessageImageViewFrame];
    [self.contentView addSubview:_MessageImageView];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;

    [_MessageImageView addSubview:_contentLabel];


    _audioImg = [self.contentView addImageViewWithFrame:CGRectMake(10, 10, 150, 30) image:nil];
//    _created_atLabel = [self.contentView addLabelWithFrame:CGRectMake(10, 40, 100, 20) text:nil];
    
    
}
//根据消息的类型（from，to）让cell适应文本内容
-(void)adjustSizeWithType:(NSString *)type
{
    //根据文本内容计算label的高度
    //计算文本占据的高度
    CGRect contentRect = [_contentLabel.text boundingRectWithSize:CGSizeMake(165, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    //根据type修改图片，label的位置
    if ([type isEqualToString:@"user_reply"]) {//自己发的
        _headImageView.frame = RightHeadImageViewFrame;
        [_headImageView setImage:[UIImage imageNamed:@"icon01.png"]];
        _MessageImageView.frame = RightMessageImageViewFrame;
        _MessageImageView.image = [[UIImage imageNamed:@"chatto_bg_normal.png"]stretchableImageWithLeftCapWidth:30 topCapHeight:50];
        _contentLabel.frame = RightMessageLabelFrame;
    }
    else if([type isEqualToString:@"dev_reply"])//别人发的
    {
        _headImageView.frame = LeftHeadImageViewFrame;
        [_headImageView setImage:[UIImage imageNamed:@"icon02.png"]];

        _MessageImageView.frame = LeftMessageImageViewFrame;
        _MessageImageView.image = [[UIImage imageNamed:@"chatfrom_bg_normal.png"]stretchableImageWithLeftCapWidth:30 topCapHeight:50];
        _contentLabel.frame = LeftMessageLabelFrame;
    }
    
    //设置label高度
    CGRect frame;
    frame = _contentLabel.frame;
    frame.size.height = contentRect.size.height;
    _contentLabel.frame = frame;
    
    //设置背景图的高度
    frame = _MessageImageView.frame;
    frame.size.height = 5 + contentRect.size.height + 12;
    _MessageImageView.frame = frame;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
