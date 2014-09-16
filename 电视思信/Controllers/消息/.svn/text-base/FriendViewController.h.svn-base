//
//  FriendViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-10-26.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdataFriengViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "SUserDB.h"

@interface FriendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,UpdataFriengViewDelegate,UIActionSheetDelegate>
{
    UITableView * listTable;
    NSMutableData *_data;
    SUserDB *db;


}
@property(nonatomic,retain)NSString *strUid;

@property(nonatomic,retain)NSString *strZu;
@property(nonatomic,retain)NSString *strName;

@property(nonatomic,retain)NSString *strFuid;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)NSDictionary *array1;

@property(nonatomic,retain)NSDictionary *dict;

@end
