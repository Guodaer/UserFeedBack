//
//  CustomCell.h
//  UMFeedback
//
//  Created by 郭达 on 15/5/7.
//  Copyright (c) 2015年 guoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (retain,nonatomic) UIImageView *headImageView;
@property (retain,nonatomic) UIImageView *MessageImageView;

@property (retain,nonatomic) UILabel *contentLabel;
@property (retain,nonatomic) UILabel *created_atLabel;
@property (retain,nonatomic) UIImageView *audioImg;

//根据消息的类型（from，to）让cell适应文本内容
-(void)adjustSizeWithType:(NSString *)type;

@end
