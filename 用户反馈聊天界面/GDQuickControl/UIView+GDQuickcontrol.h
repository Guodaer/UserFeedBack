//
//  UIView+GDQuickcontrol.h
//  GDQuickControl
//
//  Created by qianfeng on 15-3-11.
//  Copyright (c) 2015年 郭达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GDQuickcontrol)
//添加标签
-(UILabel *)addLabelWithFrame:(CGRect)frame
                         text:(NSString *)text;
//添加系统按钮
-(UIButton *)addSystemButtonWithFrame:(CGRect)frame
                                title:(NSString *)title
                               action:(void (^)(UIButton *button))action;
//添加图片按钮
-(UIButton *)addImageButtonWithFrame:(CGRect)frame
                               title:(NSString *)title
                           backgroud:(NSString *)backgroud
                              action:(void (^)(UIButton *button))action;
//添加图片视图
-(UIImageView *)addImageViewWithFrame:(CGRect)frame
                                image:(NSString *)image;
//添加输入框
-(UITextField *)addTextFieldWithFrame:(CGRect)frame;


@end
