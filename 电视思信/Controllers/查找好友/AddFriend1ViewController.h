//
//  AddFriend1ViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-9-27.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriend1ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    UITableView * listTable;
    UIView *viewAdd;
    UITextField *lable;
    UILabel *lableMessage;
}
@property(retain,nonatomic )NSDictionary *FriendArray;

@end
