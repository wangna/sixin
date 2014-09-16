//
//  SUser.h
//  SDatabase
//
//  Created by SunJiangting on 12-10-20.
//  Copyright (c) 2012年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUser : NSObject

@property (nonatomic, assign) NSString *  uid;
@property (nonatomic, assign) NSString * userId;
@property (nonatomic, assign) NSString * f_userId;
@property (nonatomic, assign) NSString * Type;
@property (nonatomic, assign) NSString * Time1;
@property (nonatomic, assign) NSString * TypeUser;
@property (nonatomic, copy) NSString * Message;
@property (nonatomic, copy) NSString * Pic;
@property (nonatomic, copy) NSString * mixPic;
@property (nonatomic, copy) NSString * Midea;
@property (nonatomic, copy) NSString * description;
@property (nonatomic, assign) NSString * userImage;
@property (nonatomic, assign) NSString * f_userImage;

@end
