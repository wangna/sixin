//
//  FriendViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-10-26.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "FriendViewController.h"
#import "AsyncImageView.h"
#import "Header.h"
@interface FriendViewController ()

@end

@implementation FriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)connect1{
    
    NSString *post = [NSString stringWithFormat:@"f_UID=%@&UID=%@&treamid=%@",self.strFuid,self.strUid,@"123"];
    NSLog(@"%@",post);
    //将post数据转换为 NSASCIIStringEncoding 编码格式
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //要post的地址/
    //    [request setURL:[NSURL URLWithString:@"http://119.44.220.4/getfriendinfo"]];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = [user objectForKey:@"url"]; 
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@deletefriend?",url]]];
    
    //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
    
    //post类型
    [request setHTTPMethod:@"POST"];
    
    
    
    //设置post数据
    [request setHTTPBody:postData];
    //创建链接
    NSURLConnection * conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    
    
    [request release];
    
}

- (void)connect{
    
    NSString *post = [NSString stringWithFormat:@"f_UID=%@",self.strFuid];
    NSLog(@"%@",post);
    //将post数据转换为 NSASCIIStringEncoding 编码格式
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //要post的地址/
//    [request setURL:[NSURL URLWithString:@"http://119.44.220.4/getfriendinfo"]];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = [user objectForKey:@"url"]; 
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getfriendinfo?",url]]];

    //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
    
    //post类型
    [request setHTTPMethod:@"POST"];
    
    
    
    //设置post数据
    [request setHTTPBody:postData];
    //创建链接
    NSURLConnection * conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    
    
    [request release];
    
}
-(void)UpdataFriengViewMessage:(id)message
{
    NSArray *aaa=(NSArray *)message;
//    NSLog(@"%@",aaa);
    if ([[aaa objectAtIndex:1] intValue]==0) {
        self.strName=[message objectAtIndex:0];
        if (listTable!=nil) {
            [listTable removeFromSuperview];
        }
        listTable = [[[UITableView alloc] initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height) style:UITableViewStyleGrouped] autorelease];
        //    [listTable setBackgroundColor:[UIColor clearColor]];
        
        [listTable setBackgroundColor:[UIColor clearColor]];
        [listTable setBackgroundView:nil];
        //    [listTable.layer setBackgroundColor:[UIColor whiteColor].CGColor];
        //    [listTable setClipsToBounds:YES];
        
        //    [listTable setShowsHorizontalScrollIndicator:NO];
        //    [listTable setShowsVerticalScrollIndicator:NO];
        [listTable setBounces:NO];
        [listTable setDelegate:self];
        [listTable setDataSource:self];
        [listTable setTag:666];
        [self.view addSubview:listTable];

    }else{
    
        self.strZu=[message objectAtIndex:0];
        if (listTable!=nil) {
            [listTable removeFromSuperview];
        }
        listTable = [[[UITableView alloc] initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height) style:UITableViewStyleGrouped] autorelease];
        //    [listTable setBackgroundColor:[UIColor clearColor]];
        
        [listTable setBackgroundColor:[UIColor clearColor]];
        [listTable setBackgroundView:nil];
        //    [listTable.layer setBackgroundColor:[UIColor whiteColor].CGColor];
        //    [listTable setClipsToBounds:YES];
        
        //    [listTable setShowsHorizontalScrollIndicator:NO];
        //    [listTable setShowsVerticalScrollIndicator:NO];
        [listTable setBounces:NO];
        [listTable setDelegate:self];
        [listTable setDataSource:self];
        [listTable setTag:666];
        [self.view addSubview:listTable];

    
    
    
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Chage" object:@"123456" ];

}
#pragma mark -connect
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    id conectMessage=[NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:nil
                      ];
    NSLog(@"conectMessage=%@",conectMessage);

    if ([conectMessage isKindOfClass:[NSArray class]]) {
        self.array=conectMessage;
        listTable = [[[UITableView alloc] initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height) style:UITableViewStyleGrouped] autorelease];
        //    [listTable setBackgroundColor:[UIColor clearColor]];
        
        [listTable setBackgroundColor:[UIColor clearColor]];
        [listTable setBackgroundView:nil];
        //    [listTable.layer setBackgroundColor:[UIColor whiteColor].CGColor];
        //    [listTable setClipsToBounds:YES];
        
        //    [listTable setShowsHorizontalScrollIndicator:NO];
        //    [listTable setShowsVerticalScrollIndicator:NO];
        [listTable setBounces:NO];
        [listTable setDelegate:self];
        [listTable setDataSource:self];
        [listTable setTag:666];
        [self.view addSubview:listTable];
    }else{
//        NSLog(@"conectMessage1=%@",conectMessage);
        [db createDataBase];
        [db deleteJiLuUserId:self.strFuid UserId:self.strUid];
        [db createDataBase1];
        
        [db deleteUserId:self.strFuid UserId:self.strUid];
            UILabel *labletishi=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
            labletishi.tag=456;
            //            labletishi.opaque=YES;
            
            labletishi.layer.cornerRadius = 10.0f;
            [labletishi setBackgroundColor:[UIColor blackColor]];
            [labletishi setText:@"清空成功"];
            labletishi.center=self.view.center;
            [labletishi setTextColor:[UIColor whiteColor]];
            [labletishi setTextAlignment:NSTextAlignmentCenter];
            
            [self.view addSubview:labletishi];
            [labletishi release];
            [self performSelector:@selector(VIewHiddle) withObject:self afterDelay:1.0];
        
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{


}
-(void)back
{

    [self.navigationController popViewControllerAnimated:YES];

}
-(void)dealloc
{
    [super dealloc];
    [_data release];
    [db release];
//    self.dict=nil;
//    self.array=nil;
//    self.array1=nil;
//
//    self.strZu=nil;



}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _data =[[NSMutableData alloc]init];
    db=[[SUserDB alloc]init];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.dict= [userDefaults dictionaryForKey:@"personF_Uid"];
    self.array1=[self.dict objectForKey:self.strFuid];
    self.strName=[self.array1  objectForKey:@"f_nickname"];
    self.strUid=[self.array1  objectForKey:@"UId"];
    NSArray *arrzu=[[self.array1 objectForKey:@"tream"] componentsSeparatedByString:@","];
    NSString *str1=[self.array1  objectForKey:@"thistream"];
    NSArray *arrzu1=[[self.array1  objectForKey:@"treamname"] componentsSeparatedByString:@","];
     
    int n= [arrzu indexOfObject: str1];

    self.strZu=[arrzu1 objectAtIndex:n];
        [self connect];
    UIBarButtonItem*backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem= backButton;
    [backButton release];

    
	// Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 2;
    }
    if (section==2) {
        return 3;
    }
    if (section==3) {
        return 1;
    }
    if (section==4) {
        return 1;
    }
    return 0;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;

    }else{
        return 40;
    
    }
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//100134


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==1) {
        if (indexPath.row==0) {
  
        UpdataFriengViewController *search=[[UpdataFriengViewController alloc]init];
        [search setHidesBottomBarWhenPushed:(BOOL)(1)];
        search.delegate=self;
        search.index=indexPath.row;
        search.strfUID=self.strFuid;
        search.strUID=[self.array1 objectForKey:@"UId"];
//        search.Message=self.array;
        [self.navigationController pushViewController:search animated:YES];
        [search release];
        }else{
        
           
            UpdataFriengViewController *search=[[UpdataFriengViewController alloc]init];
            [search setHidesBottomBarWhenPushed:(BOOL)(1)];
            search.delegate=self;
            search.index=indexPath.row;
            search.strfUID=self.strFuid;
            search.strUID=[self.array1 objectForKey:@"UId"];
            search.Message=self.array1;
//            [NSArray arrayWithObjects:arrzu1,[NSString stringWithFormat:@"%d",n], nil];
            //        search.Message=self.array;
            [self.navigationController pushViewController:search animated:YES];
            [search release];
        
        
        
        }
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * listCell = @"listCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    if (cell == NULL) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell] autorelease];
        //            [cell setBackgroundColor:[UIColor whiteColor]];
//        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 280, 300, 40)];
//        imageview.image=[UIImage imageNamed:@"添加好.png"];
//        [cell addSubview:imageview];
//        [imageview release];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        
    }
    if (indexPath.section==0) {

        AsyncImageView * contentPic = [[[AsyncImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)] autorelease];
        contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,[self.array1 objectForKey:@"avatar"]];;
        [cell.contentView addSubview:contentPic] ;
        
        
        
        UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(90,15, 200, 20)];
        [lablequan1 setBackgroundColor:[UIColor clearColor]];
        //        [lablequan1 setTextColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.92 alpha:1.0]];
        [lablequan1 setFont:[UIFont systemFontOfSize:18]];
        
        lablequan1.text=[NSString stringWithFormat:@"昵称:%@",[self.array1 objectForKey:@"nickname"]];
        [lablequan1 setTextAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:lablequan1];
        [lablequan1 release];
        
        UILabel *lablequan2=[[UILabel alloc]initWithFrame:CGRectMake(90,45, 200, 20)];
        [lablequan2 setBackgroundColor:[UIColor clearColor]];
        //        [lablequan1 setTextColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.92 alpha:1.0]];
        [lablequan2 setFont:[UIFont systemFontOfSize:18]];
        
        lablequan2.text=[NSString stringWithFormat:@"账号:%@",[self.array1 objectForKey:@"f_userId"]];
        [lablequan2 setTextAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:lablequan2];
        [lablequan2 release];

    }
    if (indexPath.section==1) {
 
           if (indexPath.row==0) {
            UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(10,5, 100, 30)];
            [lablequan1 setBackgroundColor:[UIColor clearColor]];
            //        [lablequan1 setTextColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.92 alpha:1.0]];
            [lablequan1 setFont:[UIFont systemFontOfSize:18]];
            lablequan1.text=@"修改备注";
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];
            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 40, 13,20)];
            imageview2.image=[UIImage imageNamed:@"setting_row.png"];
            imageview2.center=CGPointMake(280, cell.center.y);
            [cell.contentView addSubview:imageview2];
            [imageview2 release];
            UILabel *lablequanMessage=[[UILabel alloc]initWithFrame:CGRectMake(80,5, 180, 30)];
            [lablequanMessage setBackgroundColor:[UIColor clearColor]];
            [lablequanMessage setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
            [lablequanMessage setFont:[UIFont systemFontOfSize:18]];
            lablequanMessage.text=self.strName;
            //                lablequanMessage.text=[self.array objectAtIndex:0];
            [lablequanMessage setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:lablequanMessage];
            [lablequanMessage release];
        }
        if (indexPath.row==1) {
            UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(10,5, 100, 30)];
            [lablequan1 setBackgroundColor:[UIColor clearColor]];
            //        [lablequan1 setTextColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.92 alpha:1.0]];
            [lablequan1 setFont:[UIFont systemFontOfSize:18]];
            lablequan1.text=@"移动分组";
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];
            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 40, 13,20)];
            imageview2.image=[UIImage imageNamed:@"setting_row.png"];
            imageview2.center=CGPointMake(280, cell.center.y);
            [cell.contentView addSubview:imageview2];
            [imageview2 release];
            UILabel *lablequanMessage=[[UILabel alloc]initWithFrame:CGRectMake(80,5, 180, 40)];
            [lablequanMessage setBackgroundColor:[UIColor clearColor]];
            [lablequanMessage setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
            [lablequanMessage setFont:[UIFont systemFontOfSize:18]];

            lablequanMessage.text=self.strZu;
            [lablequanMessage setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:lablequanMessage];
            [lablequanMessage release];
        }
    }
        if (indexPath.section==2) {
     
        if (indexPath.row==0) {
            UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(10,5, 100, 30)];
            [lablequan1 setBackgroundColor:[UIColor clearColor]];
            [lablequan1 setFont:[UIFont systemFontOfSize:18]];
            lablequan1.text=@"性别";
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];

            UILabel *lablequanMessage=[[UILabel alloc]initWithFrame:CGRectMake(80,5, 180, 30)];
            [lablequanMessage setBackgroundColor:[UIColor clearColor]];
            [lablequanMessage setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
            [lablequanMessage setFont:[UIFont systemFontOfSize:18]];
            lablequanMessage.text=[[self.array objectAtIndex:0] objectForKey:@"usex"];
            //                lablequanMessage.text=[self.array objectAtIndex:0];
            [lablequanMessage setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:lablequanMessage];
            [lablequanMessage release];
        }
        if (indexPath.row==1) {
            UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(10,5, 100, 30)];
            [lablequan1 setBackgroundColor:[UIColor clearColor]];
            [lablequan1 setFont:[UIFont systemFontOfSize:18]];
            lablequan1.text=@"手机";
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];

            UILabel *lablequanMessage=[[UILabel alloc]initWithFrame:CGRectMake(80,5, 180, 40)];
            [lablequanMessage setBackgroundColor:[UIColor clearColor]];
            [lablequanMessage setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
            [lablequanMessage setFont:[UIFont systemFontOfSize:18]];
            lablequanMessage.text=[[self.array objectAtIndex:0] objectForKey:@"phone"];
            [lablequanMessage setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:lablequanMessage];
            [lablequanMessage release];
        }

        if (indexPath.row==2) {
            UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(10,5, 100, 30)];
            [lablequan1 setBackgroundColor:[UIColor clearColor]];
            //        [lablequan1 setTextColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.92 alpha:1.0]];
            [lablequan1 setFont:[UIFont systemFontOfSize:18]];
            lablequan1.text=@"邮箱";
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];

            UILabel *lablequanMessage=[[UILabel alloc]initWithFrame:CGRectMake(80,5, 180, 40)];
            [lablequanMessage setBackgroundColor:[UIColor clearColor]];
            [lablequanMessage setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
            [lablequanMessage setFont:[UIFont systemFontOfSize:18]];
            lablequanMessage.text=[[self.array objectAtIndex:0] objectForKey:@"email"];
            [lablequanMessage setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:lablequanMessage];
            [lablequanMessage release];
        }
        }
    if (indexPath.section==3) {
        UIButton *butontuichu=[UIButton buttonWithType:UIButtonTypeCustom];
        [butontuichu setFrame:CGRectMake(0,0, 300, 40)];
        [butontuichu addTarget:self action:@selector(clearMessage) forControlEvents:UIControlEventTouchUpInside];
        [butontuichu setImage:[UIImage imageNamed:@"hong.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:butontuichu];
        butontuichu.tag=3663;
        
        UILabel *lable1221=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
        [lable1221 setText:@"清空聊天记录"];
        [lable1221 setBackgroundColor:[UIColor clearColor]] ;
        [cell.contentView addSubview:lable1221];
        [lable1221 setTextAlignment:NSTextAlignmentCenter];
        [lable1221 release];

    }
    if (indexPath.section==4) {
        UIButton *butontuichu1=[UIButton buttonWithType:UIButtonTypeCustom];
        [butontuichu1 setFrame:CGRectMake(0,0, 300, 40)];
        [butontuichu1 addTarget:self action:@selector(clearMessage1) forControlEvents:UIControlEventTouchUpInside];
        [butontuichu1 setImage:[UIImage imageNamed:@"hong.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:butontuichu1];
        butontuichu1.tag=3663;
        
        UILabel *lable1222=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
        [lable1222 setText:@"删除好友"];
        [lable1222 setBackgroundColor:[UIColor clearColor]] ;
        [cell.contentView addSubview:lable1222];
        [lable1222 setTextAlignment:NSTextAlignmentCenter];
        [lable1222 release];

    }
    return cell;
    
}
-(void)clearMessage
{
 
    UIActionSheet *aActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"清空聊天记录", nil];
    aActionSheet.tag=1245;
    aActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [aActionSheet showInView:[UIApplication sharedApplication].keyWindow];
    [aActionSheet release];



}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//      NSLog(@"%d",buttonIndex);
    if (actionSheet.tag==1245) {
 
    if (buttonIndex==0) {
        
        [db createDataBase];
       BOOL *succe= [db deleteJiLuUserId:self.strFuid UserId:self.strUid];
        [db deleteMiaUserId:self.strFuid UserId:self.strUid];
        [db createDataBase1];

       [db deleteUserId:self.strFuid UserId:self.strUid];
        if (succe) {
            UILabel *labletishi=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
            labletishi.tag=456;
//            labletishi.opaque=YES;
            
            labletishi.layer.cornerRadius = 10.0f;
            [labletishi setBackgroundColor:[UIColor blackColor]];
            [labletishi setText:@"清空成功"];
            labletishi.center=self.view.center;
            [labletishi setTextColor:[UIColor whiteColor]];
            [labletishi setTextAlignment:NSTextAlignmentCenter];

            [self.view addSubview:labletishi];
            [labletishi release];
            [self performSelector:@selector(VIewHiddle) withObject:self afterDelay:1.0];
        }
        UILabel *labletishi=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        labletishi.tag=456;
//        labletishi.opaque=YES;
        labletishi.layer.cornerRadius = 4.0f;
        [labletishi setTextAlignment:NSTextAlignmentCenter];

        labletishi.center=self.view.center;
        [labletishi setTextColor:[UIColor whiteColor]];
        [labletishi setBackgroundColor:[UIColor blackColor]];
        [labletishi setText:@"清空成功"];
        [self.view addSubview:labletishi];
        [labletishi release];
        [self performSelector:@selector(VIewHiddle) withObject:self afterDelay:1.0];

    }
    
    if (buttonIndex==1) {
        
               
    }
    }else{
        if (buttonIndex==0) {
            
            
            
            [self connect1];
            
        }
    
    
    }
}
-(void)VIewHiddle
{

    UILabel *lableti=(UILabel *)[self.view viewWithTag:456];
    [lableti removeFromSuperview];
    [lableti release];
    [self.navigationController popToRootViewControllerAnimated:YES];

}
-(void)clearMessage1
{
    UIActionSheet *aActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除该好友", nil];
    aActionSheet.tag=1246;
    aActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [aActionSheet showInView:[UIApplication sharedApplication].keyWindow];
    [aActionSheet release];



}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
