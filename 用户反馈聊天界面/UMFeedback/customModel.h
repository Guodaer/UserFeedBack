//
//  customModel.h
//  UMFeedback
//
//  Created by 郭达 on 15/5/7.
//  Copyright (c) 2015年 guoda. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface customModel : NSObject
@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSString *audio;  //声音反馈
@property (copy,nonatomic) NSString *content;//评论反馈

@property (copy,nonatomic) NSString *is_failed;
@property (copy,nonatomic) NSString *reply_id;
@property (copy,nonatomic) NSString *audio_length;
@property (copy,nonatomic) NSString *created_at;

@end