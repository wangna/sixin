//
//  Chat1ViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-9-26.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "JSMessagesViewController.h"
#import "SRWebSocket.h"

@interface Chat1ViewController : JSMessagesViewController <JSMessagesViewDelegate, JSMessagesViewDataSource,SRWebSocketDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *_data;

    NSDictionary *dictUIDMessage;
    int index;
    NSURLConnection *  conn;
    NSURLConnection *  conn1;

}
@property (retain, nonatomic) NSMutableArray *messages;
@property (retain, nonatomic) NSMutableArray *timestamps;
@property(nonatomic,retain)SRWebSocket *webSocket;
@property(nonatomic,retain) NSString *strUsid;
@property(nonatomic,retain) NSString *strfUsid;
@property(nonatomic,retain) NSString *strfPic;
@property(nonatomic,retain) NSString *strfname;
@property(nonatomic,retain) NSArray *array;
@property(nonatomic,retain) NSMutableArray *arrayMessage;
@property(nonatomic,retain) NSMutableDictionary *dictMessage;
@end
