//
//  AddFriengViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-10-8.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "arryCell.h"
#import "SUserDB.h"
@protocol LinkManViewDelegate <NSObject>

- (void)LinkManViewMessage:(id)message;

@end
@interface AddFriengViewController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{

    NSObject<LinkManViewDelegate>*delegate;
    SUserDB *db;

}
@property(nonatomic,assign)NSObject<LinkManViewDelegate>*delegate;
@property(nonatomic,retain)arryCell *dict;
@property(nonatomic,retain) NSMutableData*data;
@property(nonatomic,retain)NSString *strUID;
@end
