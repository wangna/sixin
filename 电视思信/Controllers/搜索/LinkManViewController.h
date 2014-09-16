//
//  LinkManViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-9-22.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRWebSocket.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "SUserDB.h"
#import "AddFriengViewController.h"
#import "FriengList.h"
@interface LinkManViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SRWebSocketDelegate,ASICacheDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate,UISearchBarDelegate,UISearchDisplayDelegate,LinkManViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{

    UITableView* _tableView;
    SRWebSocket *_webSocket;
    NSMutableData *_data;

    SUserDB * db;
    int index;
    UISearchBar * mySearchBar;
    UISearchDisplayController * searchDC;
    FriengList *friend;
}
@property(nonatomic,retain)NSMutableArray *searchArray;
@property(nonatomic,retain)NSDictionary *faceMap;
@property(nonatomic,retain)NSDictionary *faceMessage;
@property(nonatomic,retain)NSDictionary *array;
@property(nonatomic,retain)NSMutableArray * dictMessage;
@property(nonatomic,retain)NSString *strUID;

@end
