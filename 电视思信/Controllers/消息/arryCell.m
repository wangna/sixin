//
//  arryCell.m
//  电视微信
//
//  Created by 陈 琨 on 13-10-12.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "arryCell.h"

@implementation arryCell
- (id) init {
    self = [super init];
    if (self) {
        //========== 首先查看有没有建立message的数据库，如果未建立，则建立数据库=========
        self.uid=nil;
        self.Time1=nil;
//        self.Type=nil;
        self.TypeUser=nil;
        self.Midea=nil;
        self.mixPic=nil;
        self.Message=nil;
        self.Pic=nil;
        self.userImage=nil;
//        self.userId=nil;
        self.f_userImage=nil;
//        self.f_userId=nil;
        self.description=nil;
        
        
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
//    tmpModel.fuid = [rs stringForColumn:@"f_UserId"] ;
//    tmpModel.Message = [rs stringForColumn:@"Message"] ;
//    tmpModel.Pic = [rs stringForColumn:@"TypeUser"] ;
//    tmpModel.description = [rs  stringForColumn:@"description"] ;
//    tmpModel.Time1 = [rs stringForColumn:@"Time1"];
//    tmpModel.Midea=[rs stringForColumn:@"TypeSize"] ;
//    [_uid release];
    _uid=nil;
//    [_Time1 release];
    _Time1=nil;
//    [_fuid release];
    _fuid=nil;
//    _Type=nil;
  _TypeUser=nil;
//    [_Midea release];
       _Midea=nil;
    _mixPic=nil;
//    [_Message release];
   _Message=nil;
//    [_Pic release];
    _Pic=nil;
  _userImage=nil;
//_userId=nil;
_f_userImage=nil;
////    self.f_userId=nil;
//    [_description release];
    _description=nil;
}
@end
