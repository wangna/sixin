//
//  ImageViewController.h
//  电视微信
//
//  Created by 陈 琨 on 13-10-17.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "ASIFormDataRequest.h"
#import "AsyncSocket.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SUser.h"
#import "SUserDB.h"
#import "arryCell.h"
//@protocol ImageViewControllerDelegate <NSObject>
//-(void)sendTextMessage:(SUser *)ser;
//
//@end
@interface ImageViewController : UIViewController<ASIHTTPRequestDelegate,AsyncSocketDelegate>
{
//   NSObject <ImageViewControllerDelegate> *delegate;
    SUserDB *db;
    NSString* CCpath;
    UILabel *lable;
}
@property(nonatomic,retain)NSData *dataInfo;
@property(nonatomic,retain)NSDictionary *mideaInfo;
@property(nonatomic,retain)NSString *strUid;
@property(nonatomic,retain)NSArray *arr;
@property(nonatomic,retain)NSString *strfUsid;
@property(nonatomic,retain)NSString *strPic;
//@property (nonatomic,assign) NSObject<ImageViewControllerDelegate> *delegate;
@property(nonatomic,retain)NSString *imageFile;
@property(nonatomic,retain)NSString *strName;
@property(nonatomic,retain)UIImage  *imagePic;
@property(nonatomic,retain)NSString *imageFilePic;
@property(nonatomic,assign)int index;
@property(nonatomic,retain)UIImage *image;
@end
