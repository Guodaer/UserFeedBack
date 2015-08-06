//
//  UIView+GDQuickcontrol.m
//  GDQuickControl
//
//  Created by qianfeng on 15-3-11.
//  Copyright (c) 2015年 郭达. All rights reserved.
//

#import "UIView+GDQuickcontrol.h"
#import "GDButton.h"
@implementation UIView (GDQuickcontrol)
//添加标签
-(UILabel *)addLabelWithFrame:(CGRect)frame
                         text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    [self addSubview:label];
    return label;
}
//添加系统按钮
-(UIButton *)addSystemButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                               action:(void (^)(UIButton *button))action
{
    GDButton *button = [GDButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.action = action;
    [self addSubview:button];
    return button;
}
//添加图片按钮
-(UIButton *)addImageButtonWithFrame:(CGRect)frame
                               title:(NSString *)title
                           backgroud:(NSString *)backgroud
                              action:(void (^)(UIButton *button))action
{
    GDButton *button = [GDButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backgroud] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.action = action;
    [self addSubview:button];
    return button;
}
//添加图片视图
-(UIImageView *)addImageViewWithFrame:(CGRect)frame
                                image:(NSString *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:image];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    return imageView;
}
//添加输入框
-(UITextField *)addTextFieldWithFrame:(CGRect)frame
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:textField];
    return textField;
}


@end
