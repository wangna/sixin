//
//  DianSHiViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-11-11.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "DianSHiViewController.h"
#import "Header.h"
#import "AsyncImageView.h"
@interface DianSHiViewController ()

@end

@implementation DianSHiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    //    NSLog(@"conectMessage=%@",conectMessage);
    
        self.arr=conectMessage;
    [listTable reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
 
    _data=[[NSMutableData alloc]init];
    [self connect];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    ;
    self.array1=[[userDefaults dictionaryForKey:@"personF_Uid"] objectForKey:self.strFuid];
    listTable = [[[UITableView alloc] initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height-0) style:UITableViewStyleGrouped] autorelease];
    //    [listTable setBackgroundColor:[UIColor clearColor]];
    listTable.showsVerticalScrollIndicator = NO;
    [listTable setBackgroundColor:[UIColor clearColor]];
    [listTable setBackgroundView:nil];
    [listTable setDelegate:self];
    [listTable setDataSource:self];
    [listTable setTag:666];
    [self.view addSubview:listTable];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 4;
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
            UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(10,5,100,30)];
            [lablequan1 setBackgroundColor:[UIColor clearColor]];
            //        [lablequan1 setTextColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.92 alpha:1.0]];
            [lablequan1 setFont:[UIFont systemFontOfSize:18]];
            lablequan1.text=@"性别";
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];
//            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 40, 13,20)];
//            imageview2.image=[UIImage imageNamed:@"setting_row.png"];
//            imageview2.center=CGPointMake(280, cell.center.y);
//            [cell.contentView addSubview:imageview2];
//            [imageview2 release];
            
            UILabel *lablequanMessage=[[UILabel alloc]initWithFrame:CGRectMake(110,0, 180, 30)];
            [lablequanMessage setBackgroundColor:[UIColor clearColor]];
            [lablequanMessage setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
            [lablequanMessage setFont:[UIFont systemFontOfSize:18]];
            lablequanMessage.text=[[self.arr objectAtIndex:0] objectForKey:@"usex"];;
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
            lablequan1.text=@"手机";
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];
//            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 40, 13,20)];
//            imageview2.image=[UIImage imageNamed:@"setting_row.png"];
//            imageview2.center=CGPointMake(280, cell.center.y);
//            [cell.contentView addSubview:imageview2];
//            [imageview2 release];
            UILabel *lablequanMessage=[[UILabel alloc]initWithFrame:CGRectMake(110,0, 180, 40)];
            [lablequanMessage setBackgroundColor:[UIColor clearColor]];
            [lablequanMessage setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
            [lablequanMessage setFont:[UIFont systemFontOfSize:18]];
            
            lablequanMessage.text=[[self.arr objectAtIndex:0]  objectForKey:@"phone"];
            [lablequanMessage setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:lablequanMessage];
            [lablequanMessage release];
        }
        if (indexPath.row==2) {
            UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(10,0, 100, 30)];
            [lablequan1 setBackgroundColor:[UIColor clearColor]];
            //        [lablequan1 setTextColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.92 alpha:1.0]];
            [lablequan1 setFont:[UIFont systemFontOfSize:18]];
            lablequan1.text=@"邮箱";
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];
//            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 40, 13,20)];
//            imageview2.image=[UIImage imageNamed:@"setting_row.png"];
//            imageview2.center=CGPointMake(280, cell.center.y);
//            [cell.contentView addSubview:imageview2];
//            [imageview2 release];
            UILabel *lablequanMessage=[[UILabel alloc]initWithFrame:CGRectMake(110,0, 180, 40)];
            [lablequanMessage setBackgroundColor:[UIColor clearColor]];
            [lablequanMessage setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
            [lablequanMessage setFont:[UIFont systemFontOfSize:18]];
            
            lablequanMessage.text=[[self.arr objectAtIndex:0]  objectForKey:@"email"];
            [lablequanMessage setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:lablequanMessage];
            [lablequanMessage release];
        }

        if (indexPath.row==3) {
            UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(10,5, 100, 30)];
            [lablequan1 setBackgroundColor:[UIColor clearColor]];
            //        [lablequan1 setTextColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.92 alpha:1.0]];
            [lablequan1 setFont:[UIFont systemFontOfSize:18]];
            lablequan1.text=@"所在分组";
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];
//            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 40, 13,20)];
//            imageview2.image=[UIImage imageNamed:@"setting_row.png"];
//            imageview2.center=CGPointMake(280, cell.center.y);
//            [cell.contentView addSubview:imageview2];
//            [imageview2 release];
            UILabel *lablequanMessage=[[UILabel alloc]initWithFrame:CGRectMake(110,0, 180, 40)];
            [lablequanMessage setBackgroundColor:[UIColor clearColor]];
            [lablequanMessage setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
            [lablequanMessage setFont:[UIFont systemFontOfSize:18]];
            
            lablequanMessage.text=@"我的好友";
            [lablequanMessage setTextAlignment:NSTextAlignmentRight];
            [cell.contentView addSubview:lablequanMessage];
            [lablequanMessage release];
        }

    }
          
    
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
