//
//  UpdataFriengViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-10-28.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UpdataFriengViewDelegate <NSObject>

- (void)UpdataFriengViewMessage:(id)message;

@end
@interface UpdataFriengViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{

    
    UITableView * listTable;

    NSObject<UpdataFriengViewDelegate>*delegate;

}
@property(nonatomic,retain) NSMutableData*data;
@property(nonatomic,assign)int index;
@property(nonatomic,assign)int index1;
@property(nonatomic,retain)NSString * Strindex;

@property(nonatomic,retain)NSString *strUID;
@property(nonatomic,retain)NSString *strfUID;
@property(nonatomic,retain)NSArray *Message1;
@property(nonatomic,retain)NSArray *Message2;

@property(nonatomic,retain)NSDictionary *Message;
@property(nonatomic,retain)NSObject<UpdataFriengViewDelegate>*delegate;
@end
