//
//  MessageViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-9-22.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import "SRWebSocket.h"
#import "SUserDB.h"
#import "addTreamViewController.h"
@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate,SRWebSocketDelegate,UISearchBarDelegate,UISearchDisplayDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>{
    UISearchBar * mySearchBar;
    NSMutableArray *muableArray;
    UISearchDisplayController * searchDC;
    UITableView* _tableView;
    NSInteger _currentSection;
    NSInteger _currentRow;
    SRWebSocket *_webSocket;
    SUserDB *db;
    NSMutableData *_data;


}
@property(nonatomic,retain)NSMutableArray *searchArray;

@property(nonatomic, retain) NSMutableArray* headViewArray;
//@property(nonatomic, retain) UITableView* tableView;
@property(nonatomic,retain)NSString *strUid;
@property(nonatomic,assign)int rows;
@property(nonatomic,assign)int sections;
@property(retain,nonatomic)NSArray *array;
@property(retain,nonatomic)NSArray *array22;
@property(retain,nonatomic)NSArray *arrayZu1;
@property(retain,nonatomic)NSArray *arrayZu2;
@property(retain,nonatomic)NSMutableDictionary *dictZu;
@property(retain,nonatomic)NSMutableDictionary *dictMessage;
-(void)LinkManViewMessage;
@end
