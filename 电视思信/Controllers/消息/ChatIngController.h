//
//  ChatIngController.h
//  电视微信
//
//  Created by 陈 琨 on 13-10-12.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceToolBar.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "ASIFormDataRequest.h"
#import "AsyncSocket.h"
#import "SUserDB.h"
@interface ChatIngController : UIViewController<FaceToolBarDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ASIHTTPRequestDelegate,AsyncSocketDelegate>
{
    UITapGestureRecognizer *tap;
    NSMutableData *_data;
    SUserDB * db;
    int index;
    int h;
    int connect;
    NSMutableArray *array;
    FaceToolBar* bar;
    NSURLConnection *  conn;
}
@property(nonatomic,retain) NSMutableDictionary *dictMessage;

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *messageArray;
@property(nonatomic,retain)NSArray *personArray;
@property(nonatomic,retain)NSDictionary *faceMap;
@property(nonatomic,retain)NSDictionary *faceMessage;
@property(nonatomic,retain) NSString *strUsid;
@property(nonatomic,retain) NSString *strfUsid;
@property(nonatomic,retain) NSString *strfPic;
@property(nonatomic,retain) NSString *strfPic1;

@property(nonatomic,retain) NSString *strfname;

@end
