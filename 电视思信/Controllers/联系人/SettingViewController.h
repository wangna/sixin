//
//  SettingViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-9-22.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiuGaiViewController.h"
@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,XiuGaiViewDelegate,UIAlertViewDelegate>
{
    
    UITableView * listTable;
    NSMutableData *_data;
    UIView *view11;
    UIImage *imageHead;
}
@property(nonatomic,retain)NSString * strUid;
@property(nonatomic,retain)NSMutableArray *array;
@end
