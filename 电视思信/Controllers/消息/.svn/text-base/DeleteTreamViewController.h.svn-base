//
//  DeleteTreamViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-11-11.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DeleteTreamViewDelegate <NSObject>

- (void)DeleteTreamViewMessage:(id)message;

@end
@interface DeleteTreamViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *_data;
    UITextField *lable;
    int  indexDelete;
    NSObject<DeleteTreamViewDelegate>*delegate;

}
@property(retain,nonatomic)NSString *strUid;
@property(retain,nonatomic)NSString *TreamName;
@property(assign,nonatomic)int index;
@property(assign,nonatomic)NSObject<DeleteTreamViewDelegate>*delegate;

@end
