//
//  TVMessageCell.h
//  EmojiKeyboard
//
//  Created by 陈 琨 on 13-10-11.
//  Copyright (c) 2013年 wangjianle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "FaceButton.h"
//头像大小
#define HEAD_SIZE 40.0f
#define TEXT_MAX_HEIGHT 500.0f
//间距
#define INSETS 8.0f
#define INSETSUSER 50.0f

@interface TVMessageCell : UITableViewCell
{



}
@property(nonatomic,retain)UIView *messageConent;
@property(nonatomic,retain)UILabel *timeConent;
@property(nonatomic,retain)UIImageView *userHead;
@property(nonatomic,retain)UIImageView *bubbleBg;
@property(nonatomic,retain)UIImageView *headMask;
@property(nonatomic,retain)UIImageView *midiaPic;

@property(nonatomic,retain)UIImageView *chatImage;
@property(nonatomic,retain)AsyncImageView *chatImage1;
@property(nonatomic,assign)int msgStyle;
@property(nonatomic,assign)int mideStyle;
@property(nonatomic,retain)NSDictionary *faceMap;
@property(nonatomic,retain)NSDictionary *faceMessage;
@property(nonatomic,retain)NSArray *array;
@property(nonatomic,retain)FaceButton *selectButton;
//-(void)setMessageObject:(NSString*)aMessage;
//-(void)setHeadImage:(UIImage*)headImage;
//-(void)setChatImage:(UIImage *)chatImage;
-(void)assembleMessageAtIndex:(NSArray *)arr;
@end
