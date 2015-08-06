//
//  GDButton.h
//  GDQuickControl
//
//  Created by qianfeng on 15-3-11.
//  Copyright (c) 2015年 郭达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDButton : UIButton
@property (nonatomic,copy) void (^action)(UIButton *button);


@end
