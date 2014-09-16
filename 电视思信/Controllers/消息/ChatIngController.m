//
//  ChatIngController.m
//  电视微信
//
//  Created by 陈 琨 on 13-10-12.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "ChatIngController.h"
#import "TVMessageCell.h"
#import "SUserDB.h"
#import "AsyncImageView.h"
#import "SUserDB.h"
#import "ImageViewController.h"
#import "ShowMideaViewController.h"
#import "FriendViewController.h"
#import "SVProgressHUD.h"
#import "Header.h"
#import "DianSHiViewController.h"
@interface ChatIngController ()

@end

@implementation ChatIngController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window viewWithTag:123].hidden=YES;
    [UIApplication sharedApplication].statusBarHidden=NO;
    [self.navigationController setNavigationBarHidden:NO];

    [self.navigationItem setTitle:self.strfname];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *sssss=[userDefaults stringForKey:@"ChageName"];
    if ([sssss length]!=0) {
        [self.navigationItem setTitle:sssss];
        [userDefaults setObject:nil forKey:@"ChageName"];
        [CATransaction begin];
        [UIView animateWithDuration:0.3f animations:^{
            [_tableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-45)];
            
        } completion:^(BOOL finished) {
            
        }];
        [CATransaction commit];
        [bar dismissKeyBoard];
        tap.enabled=NO;
    }
    self.navigationController.navigationBar.hidden=NO;


    }
-(void)newMsgCome1:(NSNotification *)notifacation
{
    
//    NSLog(@"wwwww=%@",notifacation.object);
    //[WCMessageObject save:notifacation.object];
    NSString *str11=(NSString *)notifacation.object;
    
    if ([str11 length]>60) {
        
        NSArray *arr123=[str11 componentsSeparatedByString:@"["];
        arr123=[[arr123 objectAtIndex:3] componentsSeparatedByString:@"]"];
        arr123=[[arr123 objectAtIndex:0] componentsSeparatedByString:@"}"];
        for (int i=0; i<[arr123 count]-1; i++) {
            
            
            [self.dictMessage setObject:[[[[arr123 objectAtIndex:i] componentsSeparatedByString:@"\""] objectAtIndex:6] stringByReplacingOccurrencesOfString:@":" withString:@""] forKey: [[[arr123 objectAtIndex:i] componentsSeparatedByString:@"\""] objectAtIndex:3]];
        }
    }
    
    if ([[self.dictMessage allKeys] containsObject:self.strfUsid]) {
        NSString *post = [NSString stringWithFormat:@"UID=%@&f_UID=%@",self.strUsid,self.strfUsid];
        //将post数据转换为 NSASCIIStringEncoding 编码格式
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init]autorelease];
        //要post的地址/
//        [request setURL:[NSURL URLWithString:@"http://119.44.220.4/mobilegetnewmessage"]];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *url = [user objectForKey:@"url"];
        
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilegetnewmessage?",url]]];

        //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
        
        //post类型
        [request setHTTPMethod:@"POST"];
        
        
        
        //设置post数据
        [request setHTTPBody:postData];
        //创建链接
        conn = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease] ;
        
        
    }
    
    
    
    
}
- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    
    if(rows > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:animated];
    }
}
-(void)inputKeyboardWillShow:(NSNotification *)notification{
    //    [delegate  Viewappere1];
    
    //键盘显示，设置toolbar的frame跟随键盘的frame
    CGFloat animationTime = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
    [UIView animateWithDuration:animationTime animations:^{
        CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        NSLog(@"键盘即将出现111：%@", NSStringFromCGRect(keyBoardFrame));
        tap.enabled=YES;
        [CATransaction begin];
        [UIView animateWithDuration:0.3f animations:^{
            [_tableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-keyBoardFrame.size.height-45)];
            
        } completion:^(BOOL finished) {
            
        }];
        [CATransaction commit];
        [self scrollToBottomAnimated:YES];

        
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    connect=0;


     db = [[SUserDB alloc] init];

    _dictMessage=[[NSMutableDictionary alloc]init];

    _faceMap = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_en" ofType:@"plist"]]retain];
    _faceMessage = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_ch" ofType:@"plist"]]retain];
    _data=[[NSMutableData alloc]init];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,320,self.view.frame.size.height-85) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor blackColor];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.allowsSelection=NO;
    [self.view addSubview:_tableView];

    if (tap==nil) {
        tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];

    }
    tap.enabled=NO;
    [_tableView addGestureRecognizer:tap];
    [tap release];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome1:) name:@"Message" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgSer:) name:@"serMessage" object:nil];
//    ImageFile
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newImageFlie:) name:@"ImageFile" object:nil];

    bar=[[FaceToolBar alloc]initWithFrame:CGRectMake(0.0f,self.view.frame.size.height ,self.view.frame.size.width,toolBarHeight) superView:self.view];
    bar.delegate=self;
    h=0;
    [self.view addSubview:bar];
    index=0;
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _personArray= [userDefaults arrayForKey:@"person"];
    self.strUsid=[[_personArray objectAtIndex:0] objectForKey:@"UId"];
//    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:[UIImage imageNamed:@"Speak@2x.png"],@"UserImage",[UIImage imageNamed:@"ReceiverTextNodeBkg@2x.png"],@"OtherImage",@"你好坏",@"Name",[UIImage imageNamed:@"IMG_0155.PNG"],@"Bug", nil];
//    _messageArray=[[NSMutableArray alloc]initWithObjects:dict,dict,dict,dict,dict, nil];
     _messageArray=[[NSMutableArray alloc]init];
    [db createDataBase];
    [self.messageArray addObjectsFromArray:[db findAll:self.strfUsid UserId:self.strUsid]];
    array=[[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(inputKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

//    [bar release];
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"查看详情" style:UIBarButtonItemStylePlain target:self action:@selector(addTream)];
    
	backItem.tag = 90;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];
    [db createDataBase1];
    arryCell *arrC=[db findUserId:self.strfUsid UserId:self.strUsid];
    if ([arrC.description intValue]>0) {
        NSString *post = [NSString stringWithFormat:@"UID=%@&f_UID=%@",self.strUsid,self.strfUsid];
        //将post数据转换为 NSASCIIStringEncoding 编码格式
//        NSLog(@"%@",post);
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        //要post的地址/
//        [request setURL:[NSURL URLWithString:@"http://119.44.220.4/mobilegetnewmessage"]];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *url = [user objectForKey:@"url"];
         
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilegetnewmessage?",url]]];

        //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
        
        //post类型
        [request setHTTPMethod:@"POST"];
        
        
        
        //设置post数据
        [request setHTTPBody:postData];
        //创建链接
        conn = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease] ;
        
        
    }
    
    //    [UIApplication sharedApplication].statusBarHidden=YES;
    //    [[UIApplication  sharedApplication] setApplicationIconBadgeNumber:0];//    NSLog(@"____________");
    //    NSLog(@"%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    //    [self.navigationController.navigationBar setFrame:CGRectMake(0,0, 320, 44)];
    [_tableView reloadData];
    [self scrollToBottomAnimated:YES];


}
-(void)addTream
{ 
    NSLog(@"%@",self.strfUsid);
    if ([self.strfUsid intValue]==18224) {
        DianSHiViewController *friend=[[DianSHiViewController alloc]init];
        [friend setHidesBottomBarWhenPushed:(BOOL)(1)];
        friend.strFuid=self.strfUsid;
        [self.navigationController pushViewController:friend animated:YES];
        [friend release];
    }else{
    FriendViewController *friend=[[FriendViewController alloc]init];
    [friend setHidesBottomBarWhenPushed:(BOOL)(1)];
    friend.strFuid=self.strfUsid;
    [self.navigationController pushViewController:friend animated:YES];
    [friend release];
    }


}
-(void)newImageFlie:(NSNotification *)notifacation
{

    ShowMideaViewController *show=[[ShowMideaViewController alloc]init];
    [show setHidesBottomBarWhenPushed:(BOOL)(1)];
    show.strFile=notifacation.object;
    [self.navigationController pushViewController:show animated:YES];
    [show release];


}
-(void)newMsgSer:(NSNotification *)notifacation
{
    SUser *sss=notifacation.object;
    arryCell *arrCell=[[arryCell alloc]init];
    
    arrCell.uid=self.strUsid;
    arrCell.fuid=self.strfUsid;
    arrCell.Pic=self.strfPic;
    arrCell.Time1=[sss.Time1 retain];
    arrCell.description=@"0";
    if (sss.Midea==nil) {
        arrCell.Message=@"[图片]";

    }else{
    
        arrCell.Message=@"[视频]";

    
    }
    arrCell.Midea=nil;
    [db updateOperationInfoQuestionID:arrCell];
    [arrCell release];

    [_messageArray addObject:notifacation.object];
    [_tableView reloadData];
    [self scrollToBottomAnimated:YES];


}
#pragma mark   ---------tableView协议----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier=@"friendCell";
    TVMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[[TVMessageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]autorelease];
    }
//    cell.delegate=self;
    //    if (indexPath.row%2==0) {
    SUser *aCell1=[_messageArray objectAtIndex:indexPath.row];
    if ([aCell1.TypeUser intValue]==0) {
    cell.msgStyle=[aCell1.TypeUser intValue];
    AsyncImageView * contentPic = [[[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 33, 33)] autorelease];
        contentPic.chatImage=0;
    contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,self.strfPic];;
//        NSLog(@"cccccc111=%@",aCell1.Message);

//        NSLog(@"cccccc=%@",[self buMessage:aCell1.Message]);
    [cell.userHead setImage: contentPic.image];
    cell.array=[self buMessage:aCell1.Message];
        [cell.timeConent setText: aCell1.Time1];

    }
    if ([aCell1.TypeUser intValue]==1) {
//        NSLog(@"cccccc2222=%@",aCell1.Message);

//        NSLog(@"cccccc=%@",[self jiequ:aCell1.Message]);

        cell.msgStyle=[aCell1.TypeUser intValue];
        AsyncImageView * contentPic = [[[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 33, 33)] autorelease];
        contentPic.chatImage=0;
        contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,self.strfPic1];;
        [cell.userHead setImage: contentPic.image];
        cell.array=[self jiequ:aCell1.Message];
        [cell.timeConent  setText:aCell1.Time1];
    }
    if ([aCell1.TypeUser intValue]==2) {

        cell.msgStyle=[aCell1.TypeUser intValue];
        AsyncImageView * contentPic = [[[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 33, 33)] autorelease];
        contentPic.chatImage=0;
        contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,self.strfPic];;
        [cell.userHead setImage: contentPic.image];
        if (aCell1.Midea!=nil) {
            cell.mideStyle=1;
            cell.chatImage1.MessageStr=[NSString stringWithFormat:@"%@*%@*1%@",aCell1.mixPic,aCell1.Midea,aCell1.TypeUser];

        }else{
            cell.mideStyle=0;
            cell.chatImage1.MessageStr=[NSString stringWithFormat:@"%@*%@*0%@",aCell1.mixPic,aCell1.Pic,aCell1.TypeUser];

        }
        
        [cell.chatImage1 setUrlString:aCell1.mixPic];

        [cell.timeConent setText: aCell1.Time1];

        
    }

    if ([aCell1.TypeUser intValue]==3) {

        cell.msgStyle=[aCell1.TypeUser intValue];
        AsyncImageView * contentPic = [[[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 33, 33)] autorelease];
        contentPic.chatImage=0;
        contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,self.strfPic1];;
        [cell.userHead setImage: contentPic.image];
        NSData *data=[[[NSData alloc]initWithContentsOfFile:aCell1.mixPic] autorelease];
        if (aCell1.Midea!=nil) {
            cell.mideStyle=1;
            cell.chatImage1.MessageStr=[NSString stringWithFormat:@"%@*%@*1%@",aCell1.mixPic,aCell1.Midea,aCell1.TypeUser];
            
        }else{
            cell.mideStyle=0;
            cell.chatImage1.MessageStr=[NSString stringWithFormat:@"%@*%@*0%@",aCell1.mixPic,aCell1.Pic,aCell1.TypeUser];
            
        
        }
        [cell.chatImage1 setImage:[UIImage imageWithData:data]];
        [cell.timeConent setText: aCell1.Time1];

    }

    //    cell.messageConent.text=[[_messageArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
    
    //    }
    //    if (indexPath.row%2==1) {
    //        cell.msgStyle=3;
    //        [cell.userHead setImage: [[_messageArray objectAtIndex:indexPath.row] objectForKey:@"OtherImage"]];
    //        [cell.chatImage setImage: [[_messageArray objectAtIndex:indexPath.row] objectForKey:@"Bug"]];
    //
    //
    //    }
    return cell;
}

-(void)Viewappere:(CGRect)rect{
//    NSLog(@"heheheh");
    tap.enabled=YES;
    [CATransaction begin];
    [UIView animateWithDuration:0.3f animations:^{
        [_tableView setFrame:CGRectMake(0,-rect.origin.y, 320, _tableView.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
    [_tableView setFrame:CGRectMake(0,0, 320,  rect.origin.y)];

    [CATransaction commit];
    [self scrollToBottomAnimated:YES];

}

-(void)Viewappere1:(CGRect)rect{
    tap.enabled=YES;
    [CATransaction begin];
    [UIView animateWithDuration:0.3f animations:^{
        [_tableView setFrame:CGRectMake(0, -rect.origin.y, 320, _tableView.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
    [_tableView setFrame:CGRectMake(0,0, 320,  rect.origin.y)];

    [CATransaction commit];
    [self scrollToBottomAnimated:YES];

    
}
-(void)Viewappere2:(CGRect)rect{
//    NSLog(@"wwdf");

    tap.enabled=YES;

    [CATransaction begin];
    [UIView animateWithDuration:0.3f animations:^{
        [_tableView setFrame:CGRectMake(0, 0, 320, rect.origin.y)];
            
    } completion:^(BOOL finished) {
        
    }];
    [CATransaction commit];
    [self scrollToBottomAnimated:YES];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SUser *aaa=[_messageArray objectAtIndex:indexPath.row];
    if (aaa.mixPic!=NULL) {
        return 125+40;
    }else{
        if ([aaa.TypeUser intValue]==0) {
            UIView *retionview=[self assembleMessageAtIndex:[self buMessage:aaa.Message]];
//            NSLog(@"retionview.frame.size.height=%f",retionview.frame.size.height);
            if (retionview.frame.size.height==20) {
                return 60+20;
            }else{
            return retionview.frame.size.height+30+30;
            }
        }
        if ([aaa.TypeUser intValue]==1) {
            UIView *retionview=[self assembleMessageAtIndex:[self jiequ:aaa.Message]];
//            NSLog(@"retionview.frame.size.height=%f",retionview.frame.size.height);

            if (retionview.frame.size.height==20) {
                return 60+20;
            }else{
                return retionview.frame.size.height+30+30;
            }
        }
    
    
    }
    return 0;
}

-(UIView *)assembleMessageAtIndex:(NSArray *)arr
{
    
    UIView *returnView = [[[UIView alloc] init] autorelease];
    
    NSArray *data = [[[NSArray alloc]initWithArray:arr] autorelease];
    UIFont *fon= [UIFont systemFontOfSize:16];
	CGFloat upX=0;
    CGFloat upY=0;
	if (data) {
		for (int i=0;i<[data count];i++) {
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"]&&[self bubbleBg:str])
            {
                if (upX > 206)
                {
                    upY = upY + 17+3;
                    upX = 0;
                }
				NSString *yaoxi=[str substringWithRange:NSMakeRange(0, str.length)];
                NSString * imageName=[self bubbleBgName:yaoxi];
				UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString  stringWithFormat:@"%@.png",imageName]]];
                img.frame = CGRectMake(upX, upY, 19, 20);
                [returnView addSubview:img];
                [img release];
				upX=17+upX+3;
                
			}else
            {
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > 206)
                    {
                        upY = upY + 17+3;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(206, 20)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    la.backgroundColor=[UIColor clearColor];
                    la.font = fon;
                    la.text = temp;
                    [returnView addSubview:la];
                    [la release];
                    upX=upX+size.width;
                }
			}
        }
	}
    if (upY>0) {
        [returnView setFrame:CGRectMake(0, 0, 206, upY+17+3)];
        
    }else{
        [returnView setFrame:CGRectMake(0, 0, upX, upY+17+3)];
    }
    return returnView;
}
-(BOOL)kongge:(NSString *)str
{
    
    for (int i=0; i<[str length]; i++) {
        NSString *str1=[str substringWithRange:NSMakeRange(i, 1)];
        if ([str1 isEqualToString:@" "]) {
            
        }else{
            
            return YES;
            
        }
    }
    return NO;
}
-(void)sendTextAction:(NSString *)inputText{
  
    if (![self kongge:inputText]) {
        [SVProgressHUD showAbnormalThenDismiss:@"发送信息不能全为空格"];
        return;
    }
    NSMutableString *strMessage1=[[[NSMutableString alloc]init] autorelease];
    for (int i=0; i<[[self jiequ:inputText] count]; i++) {
        NSString *str=[[self jiequ:inputText] objectAtIndex:i];
      if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"]&&[self bubbleBg:str])
      {
      
          NSString *strimage=[NSString stringWithFormat:@"/%@",[self bubbleBgName:str]];
          [strMessage1 appendString:strimage];
      
      
      }else{
      
          [strMessage1 appendString:str];
      
      
      
      }
    }
    NSString *post = [NSString stringWithFormat:@"UID=%@&message=%@&f_UID=%@",self.strUsid,strMessage1,self.strfUsid];
    //将post数据转换为 NSASCIIStringEncoding 编码格式
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //要post的地址/
//    [request setURL:[NSURL URLWithString:@"http://119.44.220.4/mobilesendmessage"]];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = [user objectForKey:@"url"]; 
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilesendmessage?",url]]];

    //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
    
    //post类型
    [request setHTTPMethod:@"POST"];
    
    
    
    //设置post数据
    [request setHTTPBody:postData];
    //创建链接
   NSURLConnection * conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease] ;
    [request release];
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    //    [dateformatter setDateFormat:@"HH:mm"];
    //    NSString * locationString=[dateformatter stringFromDate:senddate];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString * morelocationString=[[dateformatter stringFromDate:senddate] retain];
    SUser *ser=[[SUser alloc]init];
    ser.userId=self.strUsid;
    ser.Time1=morelocationString;
    ser.f_userId=self.strfUsid;
    ser.Message=inputText;
    ser.userImage=[[self.personArray objectAtIndex:0]objectForKey:@"m_avatar"];
    ser.TypeUser=[[NSString stringWithFormat:@"1"] retain];
    [_messageArray addObject:ser];
    [db createDataBase];
    
    [db saveUser:ser];
    [db createDataBase1];
    arryCell *arrCell=[[arryCell alloc]init];
    
    arrCell.uid=self.strUsid;
    arrCell.fuid=self.strfUsid;
    arrCell.Time1=morelocationString;
    arrCell.Pic=self.strfPic;
    arrCell.description=[NSString stringWithFormat:@"0"];
    arrCell.Message=inputText;
    arrCell.Midea=nil;

    [db updateOperationInfoQuestionID:arrCell];
    [arrCell release];
    [ser release];
    [dateformatter release];

    [_tableView reloadData];

    [self scrollToBottomAnimated:YES];
       //    [self assembleMessageAtIndex:array];
}

-(BOOL)bubbleBg:(NSString *)bubbleStr
{
    for (int i=0; i<[[_faceMessage allKeys] count]; i++) {
        if ([[_faceMessage objectForKey:[[_faceMap allKeys] objectAtIndex:i] ] isEqualToString:bubbleStr]) {
            return YES;
            
        }
    }
    
    return NO;
    
    
    
}
-(NSString *)bubbleBgName:(NSString *)bubbleStr
{
    for (int i=0; i<[[_faceMessage allKeys] count]; i++) {
        if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i] ] isEqualToString:bubbleStr]) {
           return [[_faceMessage allKeys] objectAtIndex:i] ;
            
        }
    }
    
    return NO;
    
    
    
}
-(NSMutableArray *)jiequ:(NSString *)inputText
{
    int jiequTndex=0;
    NSMutableArray *array1=[[[NSMutableArray alloc]init] autorelease];
    for (int i=0; i<[inputText length]; i++) {
        
        if (index==0) {
            jiequTndex=i;
            index=1;
        }
        NSString *temp = [inputText substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"["]&&[self buOtherName:inputText Index:i]) {
            ;
            if (jiequTndex!=i) {
                [array1 addObject:[inputText substringWithRange:NSMakeRange(jiequTndex, i-jiequTndex)]];
                
            }
        [array1 addObject:[self buOtherName1:inputText Index:i]];
        i=i+[[self buOtherName1:inputText Index:i] length]-1;
        index=0;
        
                  }else {
                if (i==inputText.length-1) {
                    [array1 addObject:[inputText substringWithRange:NSMakeRange(jiequTndex, i-jiequTndex+1)]];
                }
        }
    }
    return array1;

}
#pragma mark -connect
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
//    NSLog(@"hhh=%@",data);
    [_data appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
       NSError *error;
//    if ([connection isEqual:conn]) {
           NSArray *arrjson= [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&error ];
    NSLog(@"%@",arrjson);
        for (int i=0; i<[arrjson  count]; i++) {
            if ([[[arrjson objectAtIndex:i] objectForKey:@"mtype"] intValue]==1) {
                NSString * morelocationString=[[[arrjson objectAtIndex:i] objectForKey:@"senddate"] retain];;
                SUser *ser=[[SUser alloc]init];
                ser.Time1=morelocationString;
                ser.f_userId=self.strfUsid;
                ser.userId=self.strUsid;
                ser.mixPic=[[NSString stringWithFormat:@"%@/SendPic/%@/zoom_%@",HTTPHEADPIC,[[[arrjson objectAtIndex:i] objectForKey:@"content"] substringWithRange:NSMakeRange(0, 4)], [[arrjson objectAtIndex:i] objectForKey:@"content"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                ser.Pic=[[NSString stringWithFormat:@"%@/SendPic/%@/%@",HTTPHEADPIC,[[[arrjson objectAtIndex:i] objectForKey:@"content"] substringWithRange:NSMakeRange(0, 4)],[[arrjson objectAtIndex:i] objectForKey:@"content"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                ser.userImage=self.strfPic;
                ser.TypeUser=[[NSString stringWithFormat:@"2"] retain];
                [_messageArray addObject:ser];
                [db createDataBase];
                
                [db saveUser:ser];
                
                arryCell *arrCell=[[arryCell alloc]init];
                arrCell.Pic=self.strfPic;
                arrCell.uid=self.strUsid;
                arrCell.fuid=self.strfUsid;
                arrCell.Time1=morelocationString;
                arrCell.description=[NSString stringWithFormat:@"0"];
                arrCell.Message=[[NSString alloc]initWithFormat:@"[图片]"];
                arrCell.Midea=nil;

                [db updateOperationInfoQuestionID:arrCell];
                
                [arrCell release];
                
                
                
                [ser release];
            }
            if ([[[arrjson objectAtIndex:i] objectForKey:@"mtype"] intValue]==0) {

            NSString * morelocationString=[[[arrjson objectAtIndex:i] objectForKey:@"senddate"] retain];;
            SUser *ser=[[SUser alloc]init];
                ser.f_userId=self.strfUsid;
                ser.userId=self.strUsid;
            ser.Time1=morelocationString;
            ser.Message=[[arrjson objectAtIndex:i] objectForKey:@"content"];
            ser.userImage=self.strfPic;
            ser.TypeUser=[[NSString stringWithFormat:@"0"] retain];
            [_messageArray addObject:ser];
            [db createDataBase];
            
            [db saveUser:ser];
                
                arryCell *arrCell=[[arryCell alloc]init];
                
                arrCell.uid=self.strUsid;
                arrCell.fuid=self.strfUsid;
                arrCell.Pic=self.strfPic;
                arrCell.Time1=morelocationString;
                arrCell.description=[NSString stringWithFormat:@"0"];
                arrCell.Message=[[self buMessage:[[arrjson objectAtIndex:i] objectForKey:@"content"] ]componentsJoinedByString:@""];
//                NSLog(@"arrCell.Message=%@",arrCell.Message);
                arrCell.Midea=nil;

                [db updateOperationInfoQuestionID:arrCell];
                [arrCell release];
                
                
                
                
            [ser release];
            }
            if ([[[arrjson objectAtIndex:i] objectForKey:@"mtype"] intValue]==2) {
                
                NSString * morelocationString=[[[arrjson objectAtIndex:i] objectForKey:@"senddate"] retain];;
                SUser *ser=[[SUser alloc]init];
                ser.Time1=morelocationString;
          NSRange  rang=NSMakeRange([[[arrjson objectAtIndex:i] objectForKey:@"content"] length]-4,4);
//                ser.Message=[[arrjson objectAtIndex:i] objectForKey:@"content"];
                ser.mixPic=[[NSString stringWithFormat:@"%@/SendVideo/%@/%@",HTTPHEADPIC,[[[arrjson objectAtIndex:i] objectForKey:@"content"] substringWithRange:NSMakeRange(0, 4)],[[[arrjson objectAtIndex:i] objectForKey:@"content"] stringByReplacingCharactersInRange:rang withString:@".jpg"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
//                NSLog(@"ser.mixPic=%@",ser.mixPic);
                ser.Midea=[[NSString stringWithFormat:@"%@/SendVideo/%@/%@",HTTPHEADPIC,[[[arrjson objectAtIndex:i] objectForKey:@"content"] substringWithRange:NSMakeRange(0, 4)],[[arrjson objectAtIndex:i] objectForKey:@"content"] ] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                ser.userImage=self.strfPic;
                ser.f_userId=self.strfUsid;
                ser.userId=self.strUsid;

                ser.TypeUser=[[NSString stringWithFormat:@"2"] retain];
                [_messageArray addObject:ser];
                [db createDataBase];
                
                [db saveUser:ser];
                
                arryCell *arrCell=[[arryCell alloc]init];
                
                arrCell.uid=self.strUsid;
                arrCell.fuid=self.strfUsid;
                arrCell.Pic=self.strfPic;
                arrCell.Time1=morelocationString;
                arrCell.description=[NSString stringWithFormat:@"0"];
                arrCell.Message=[[NSString alloc]initWithFormat:@"[视频]"];

//                arrCell.Message=[NSString stringWithFormat:@"视频"];;
                arrCell.Midea=nil;

                [db updateOperationInfoQuestionID:arrCell];
                [arrCell release];
                
                
                
                [ser release];
            }
        }
        [_tableView reloadData];
        [self scrollToBottomAnimated:YES];


        
//    }else{
//        NSString *arrjson= [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];;
//        NSLog(@"arrjsonheheheh=%@",arrjson);
//    }
// 

    
    
}
-(BOOL)JudgePng:(NSString *)str
{
    int indexLength=[str length];
    if ([[str substringWithRange:NSMakeRange(indexLength-4, 4)] caseInsensitiveCompare:@".png"]==NSOrderedSame) {
        return YES;
    }
    if ([[str substringWithRange:NSMakeRange(indexLength-4, 4)] caseInsensitiveCompare:@".jpg"]==NSOrderedSame) {
        return YES;
    }
    if ([[str substringWithRange:NSMakeRange(indexLength-4, 4)] caseInsensitiveCompare:@".gif"]==NSOrderedSame) {
        return YES;
    }
    if ([[str substringWithRange:NSMakeRange(indexLength-4, 4)] caseInsensitiveCompare:@".pcd"]==NSOrderedSame) {
        return YES;
    }
    if ([[str substringWithRange:NSMakeRange(indexLength-4, 4)] caseInsensitiveCompare:@".bmp"]==NSOrderedSame) {
        return YES;
    }
    if ([[str substringWithRange:NSMakeRange(indexLength-4, 4)] caseInsensitiveCompare:@".pcx"]==NSOrderedSame) {
        return YES;
    }
    if ([[str substringWithRange:NSMakeRange(indexLength-4, 4)] caseInsensitiveCompare:@".tga"]==NSOrderedSame) {
        return YES;
    }
    if ([[str substringWithRange:NSMakeRange(indexLength-4, 4)] caseInsensitiveCompare:@".fpx"]==NSOrderedSame) {
        return YES;
    }
    if ([[str substringWithRange:NSMakeRange(indexLength-4, 4)] caseInsensitiveCompare:@".psd"]==NSOrderedSame) {
        return YES;
    }
    return NO;
//bmp,jpg,tiff,gif,pcx,tga,exif,fpx,svg,psd,cdr,pcd,dxf,ufo,eps,ai,raw
}
-(NSMutableArray *)buMessage:(NSString *)str
{
    int jishu=0;
    int k=0;
    NSMutableArray *array1=[[[NSMutableArray alloc]init] autorelease];
    for (int i=0; i<[str length]; i++) {
        if (jishu==0) {
            k=i;
            jishu=1;
            
        }

        NSString *temp = [str substringWithRange:NSMakeRange(i, 1)];
        if ([str length]-i>1) {
            if ([temp isEqualToString:@"/"]&&[self bugName:[str substringWithRange:NSMakeRange(i+1, 2)]]) {
            ;
            
            if (k!=i) {
                [array1 addObject:[str substringWithRange:NSMakeRange(k, i-k)]];
            }
                [array1 addObject:[NSString stringWithFormat:@"%@",[_faceMessage objectForKey:[str substringWithRange:NSMakeRange(i+1, 2)]]]];
            i=i+2;
            k=i+1;
            }else{
            
            
            }
        }else {

            if (jishu==0) {
                k=i;
                jishu=1;
                
            }

                       if (i==([str length]-1)) {
                           [array1 addObject:[str substringWithRange:NSMakeRange(k, i-k+1)]];
                       }
                       
                       
            
                    }
        
        
        
    }
    return array1;
    
    
}

-(BOOL)bugName:(NSString *)str
{
    if ([[_faceMap allKeys] containsObject:str]) {
        return YES;
    }
    return NO;


}

-(BOOL)buOtherName:(NSString *)str Index :(int)indexType
{
    for (int i=0; i<[_faceMessage count]; i++) {
        if ([str length]-indexType>2) {
        
        if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 3)]]) {
            return YES;
        }
               }
        if ([str length]-indexType>3) {
            
       
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 4)]]) {
                return YES;
            }
                  }
        if ([str length]-indexType>4) {
            
        
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 5)]]) {
                return YES;
            }
        }
    }

    return NO;

}
-(NSString *)buOtherName1:(NSString *)str Index :(int)indexType
{
    for (int i=0; i<[_faceMessage count]; i++) {
        if ([str length]-indexType>2) {
            
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 3)]]) {
                return [str substringWithRange:NSMakeRange(indexType, 3)];
            }
        }
        if ([str length]-indexType>3) {
            
            
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 4)]]) {
                return [str substringWithRange:NSMakeRange(indexType, 4)];
            }
        }
        if ([str length]-indexType>4) {
            
            
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 5)]]) {
                return [str substringWithRange:NSMakeRange(indexType, 5)];
            }
        }
    }
    
    return nil;
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}
-(void)diaoyongLoadphoto
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = NO;
    [self.navigationController presentViewController:pickerImage animated:YES completion:nil];
    [pickerImage release];


}
-(void)diaoyongphoto
{

    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.mediaTypes = temp_MediaTypes;
        picker.delegate = self;
    
//        picker.allowsImageEditing = YES;
    }
    [UIApplication sharedApplication].statusBarHidden=YES;
//    self.navigationController.navigationBar.hidden=YES;
//    [picker.view setFrame:CGRectMake(0, -50, 320, self.view.frame.size.height+50)];
//    [self.view addSubview:picker.view];
    [self.navigationController presentViewController:picker animated:YES completion:^{
    }];
    [picker release];




//phonoViewController *phone=[[phonoViewController alloc]init];
//[self presentViewController:phone animated:YES completion:nil];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ImageViewController *imagePicVIew=[[ImageViewController alloc]init];
    imagePicVIew.mideaInfo=info;
    imagePicVIew.strfUsid=self.strfUsid;
    imagePicVIew.strUid=self.strUsid;
    imagePicVIew.strPic=[[self.personArray objectAtIndex:0]objectForKey:@"m_avatar"];
    [picker pushViewController:imagePicVIew animated:YES];
    [imagePicVIew release];
    /*
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        UIImage *image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *image=[self jietu:image1];
              NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
       NSMutableArray *arrww = (NSMutableArray *)[userDefaults objectForKey:@"imageName"];
        if (arrww ==NULL) {
            arrww=[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"0"], nil];
            [userDefaults setObject:arrww forKey:@"imageName"];
        }

        NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.png",self.strfUsid,[[arrww objectAtIndex:([arrww count]-1)] intValue ]+1]];
        NSMutableArray *muArray=[[NSMutableArray alloc]initWithArray:arrww];
     
   
         [muArray addObject:[NSString stringWithFormat:@"%d",([[arrww objectAtIndex:([arrww count]-1)]intValue ]+1)]];
//            NSLog(@"111");
//
//  
        [userDefaults setObject:muArray forKey:@"imageName"];
        [muArray release];
        success = [fileManager fileExistsAtPath:imageFile];
        if(success) {
//            success = [fileManager removeItemAtPath:imageFile error:&error];
        }
        
    //大图
        NSMutableArray *arrPic = (NSMutableArray *)[userDefaults objectForKey:@"imagePicName"];
        if (arrww ==NULL) {
            arrww=[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"0"], nil];
            [userDefaults setObject:arrww forKey:@"imageName"];
        }
        
        NSString *imageFilePic = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.png",self.strfUsid,[[arrPic objectAtIndex:([arrPic count]-1)] intValue ]+1]];
        NSMutableArray *muArrayPic=[[NSMutableArray alloc]initWithArray:arrPic];
        
        
        [muArrayPic addObject:[NSString stringWithFormat:@"%d",([[arrPic objectAtIndex:([arrPic count]-1)]intValue ]+1)]];
        //            NSLog(@"111");
        //
        //
        [userDefaults setObject:muArrayPic forKey:@"imagePicName"];
        [muArrayPic release];

        
        
        
        
        
        
        
//        imageView.image = image;
        [UIImagePNGRepresentation(image1) writeToFile:imageFilePic atomically:YES];

        [UIImagePNGRepresentation(image) writeToFile:imageFile atomically:YES];
        NSDate * senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        //    [dateformatter setDateFormat:@"HH:mm"];
        [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
        NSString * morelocationString=[[dateformatter stringFromDate:senddate] retain];
        SUser *ser=[[SUser alloc]init];
        ser.Time1=morelocationString;
//        ser.Message=inputText;
        ser.mixPic=imageFile;
        ser.Pic=imageFilePic;
        ser.userImage=[[self.personArray objectAtIndex:0]objectForKey:@"m_avatar"];
        ser.TypeUser=@"3";
        [_messageArray addObject:ser];
        [db createDataBase];
        [db saveUser:ser];
        [ser  release];
        [dateformatter release];
        [_tableView reloadData];
        [UIApplication sharedApplication].statusBarHidden=NO;
        
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            //
            
            
        }];
        [self appImage:image1 ImageName:[NSString stringWithFormat:@"Pic%@%d.png",self.strfUsid,[[arrww objectAtIndex:([arrww count]-1)] intValue ]+1]];


    }
    else if([mediaType isEqualToString:@"public.movie"]){
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];

        
   //视频缩略图
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        NSMutableArray *arrww = (NSMutableArray *)[userDefaults objectForKey:@"imageMiaName"];
        if (arrww ==NULL) {
            arrww=[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"0"], nil];
            [userDefaults setObject:arrww forKey:@"imageMiaName"];
        }
        
        NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"mia%@%d.png",self.strfUsid,[[arrww objectAtIndex:([arrww count]-1)] intValue ]+1]];
        NSMutableArray *muArray=[[NSMutableArray alloc]initWithArray:arrww];
        
        
        [muArray addObject:[NSString stringWithFormat:@"%d",([[arrww objectAtIndex:([arrww count]-1)]intValue ]+1)]];
        //            NSLog(@"111");
        //
        //
        [userDefaults setObject:muArray forKey:@"imageMiaName"];
        [muArray release];

        [UIImagePNGRepresentation(thumb) writeToFile:imageFile atomically:YES];

        

        
//
        NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
        
      //保存本地
        NSMutableArray *arrMia = (NSMutableArray *)[userDefaults objectForKey:@"imageMiaeName"];
        if (arrMia ==NULL) {
            arrMia=[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"0"], nil];
            [userDefaults setObject:arrww forKey:@"imageMiaeName"];
        }
        
        NSString *imageFile1 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.mov",self.strfUsid,[[arrMia objectAtIndex:([arrMia count]-1)] intValue ]+1]];
        NSMutableArray *mu1Array=[[NSMutableArray alloc]initWithArray:arrww];
        
        
        [mu1Array addObject:[NSString stringWithFormat:@"%d",([[arrMia objectAtIndex:([arrMia count]-1)]intValue ]+1)]];
        //            NSLog(@"111");
        //
        //
        [userDefaults setObject:mu1Array forKey:@"imageMiaeName"];
        [mu1Array release];
        
        [videoData writeToFile:imageFile1 atomically:YES];
        
        NSDate * senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        //    [dateformatter setDateFormat:@"HH:mm"];
        //    NSString * locationString=[dateformatter stringFromDate:senddate];
        [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
        NSString * morelocationString=[[dateformatter stringFromDate:senddate] retain];
        SUser *ser=[[SUser alloc]init];
        ser.Time1=morelocationString;
        ser.Midea=imageFile1;
        //        ser.Message=inputText;
        ser.mixPic=imageFile;
        ser.userImage=[[self.personArray objectAtIndex:0]objectForKey:@"m_avatar"];
        ser.TypeUser=@"3";
        
        [_messageArray addObject:ser];
        [db createDataBase];

        [db saveUser:ser];
        [dateformatter release];

        [ser release];

        [_tableView reloadData];
        [UIApplication sharedApplication].statusBarHidden=NO;
        
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            //
            
            
        }];
        
        
        
        
        
        //上传服务器
        [self addroom:videoData];

    }
    [self scrollToBottomAnimated:YES];
*/
}
-(UIImage *)jietu:(UIImage *)image
{
    CGSize newSize=CGSizeMake(95, 125);
    UIGraphicsBeginImageContext(newSize);
    
      [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;


}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [UIApplication sharedApplication].statusBarHidden=NO;
//    self.navigationController.navigationBar.hidden=NO;
//    [picker.view removeFromSuperview];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //
        
        
    }];
    
}



-(void)handleTap:(UIGestureRecognizer *)gesture
{
 
    [CATransaction begin];
    [UIView animateWithDuration:0.3f animations:^{
        [_tableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-45)];
        
    } completion:^(BOOL finished) {
        
    }];
    [CATransaction commit];
    [bar dismissKeyBoard];
    tap.enabled=NO;
}
-(void)dealloc
{
    [db release];
    [_data release];
    [bar release];
    [array release];
    [_faceMap release];
    [_faceMessage  release];
    [_dictMessage release];
    [_tableView release];
    _personArray=nil;
    [_messageArray release];
    [super dealloc];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
