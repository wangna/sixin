//
//  addTreamViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-10-24.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageViewController.h"
@protocol addTreamViewDelegate <NSObject>

- (void)addTreamViewMessage:(id)message;

@end
@interface addTreamViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *_data;
    UITextField *lable;
    NSObject<addTreamViewDelegate>*delegate;
    
}
@property(retain,nonatomic)NSString *strUid;
@property(assign,nonatomic)NSObject<addTreamViewDelegate>*delegate;
@end
