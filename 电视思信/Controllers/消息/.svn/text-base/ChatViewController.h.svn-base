//
//  ChatViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-9-24.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRWebSocket.h"
#import "FaceToolBar.h"
@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SRWebSocketDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,FaceToolBarDelegate>
{
    NSMutableData *_data;
    UIView *viewl;
    UITextField * textFild;
    NSDictionary *dictUIDMessage;
}
@property(nonatomic,retain)SRWebSocket *webSocket;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain) NSString *strUsid;
@property(nonatomic,retain) NSString *strfUsid;
@property(nonatomic,retain) NSString *strfPic;
@property(nonatomic,retain) NSString *strfname;
@property(nonatomic,retain) NSArray *array;
@property(nonatomic,retain) NSMutableArray *arrayMessage;
@property(nonatomic,retain) NSMutableDictionary *dictMessage;

@end
