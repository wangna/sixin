//
//  XiuGaiViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-10-25.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XiuGaiViewDelegate <NSObject>

- (void)XiuGaiViewMessage:(id)message;

@end
@interface XiuGaiViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

  UITextField *lable;
    UITextField *lable1;
    UITextField *lable2;

    NSObject<XiuGaiViewDelegate>*delegate;

}
@property(nonatomic,retain) NSMutableData*data;
@property(nonatomic,assign)int index;
@property(nonatomic,retain)NSString *strUID;
@property(nonatomic,retain)NSString *strMima;

@property(nonatomic,retain)NSArray *Message;
@property(nonatomic,retain)NSObject<XiuGaiViewDelegate>*delegate;


@end
