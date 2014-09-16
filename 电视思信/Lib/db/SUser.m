//
//  SUser.m
//  SDatabase
//
//  Created by SunJiangting on 12-10-20.
//  Copyright (c) 2012年 sun. All rights reserved.
//

#import "SUser.h"

@implementation SUser
- (id) init {
    self = [super init];
    if (self) {
        //========== 首先查看有没有建立message的数据库，如果未建立，则建立数据库=========
        self.uid=nil;
        self.Time1=nil;
        self.Type=nil;
        self.TypeUser=nil;
        self.Midea=nil;
        self.mixPic=nil;
        self.Message=nil;
        self.Pic=nil;
        self.userImage=nil;
        self.userId=nil;
        self.f_userImage=nil;
        self.f_userId=nil;
        self.description=nil;
       
        
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    _description=nil;
    _uid=nil;
    _f_userId=nil;
    _f_userImage=nil;
    _Time1=nil;
    _Type=nil;
    _TypeUser=nil;
    _Message=nil;
    _Midea=nil;
    _Pic=nil;
    _mixPic=nil;
    _userImage=nil;
    _userId=nil;

}
@end
