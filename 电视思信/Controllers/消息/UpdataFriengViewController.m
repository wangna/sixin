//
//  UpdataFriengViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-10-28.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "UpdataFriengViewController.h"
#import "SVProgressHUD.h"
#import "Header.h"
@interface UpdataFriengViewController ()

@end

@implementation UpdataFriengViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [_data release];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _data=[[NSMutableData alloc]init];
    UIImageView *imagepic=[[UIImageView alloc]init];
    imagepic.frame=CGRectMake(0, 0, 320, self.view.frame.size.height);
    imagepic.image=[UIImage imageNamed:@"背景.png"];
    imagepic.userInteractionEnabled=YES;
    [self.view addSubview:imagepic];
    [imagepic  release];
    
    
    
    
    
    if (self.index==0) {
  
    UITextField *lable=[[UITextField alloc]initWithFrame:CGRectMake(20, 20, 280,45)];
        lable.tag=10;
    [lable setBackgroundColor:[UIColor  whiteColor]];
    [lable setFont:[UIFont systemFontOfSize:20]];
    [lable setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
    lable.delegate=self;
    lable.clearsOnBeginEditing = YES;
    
    lable.clearButtonMode = UITextFieldViewModeWhileEditing;
    lable.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [lable setBorderStyle:UITextBorderStyleRoundedRect];
    [imagepic addSubview:lable];
        [lable release];
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(addTream)];
	backItem.tag = 90;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];
    }else{
//        self.index1=[[self.Message objectAtIndex:1] intValue];
        self.Message2=[[self.Message objectForKey:@"tream"] componentsSeparatedByString:@","];
       self.Strindex=[self.Message  objectForKey:@"thistream"];
        self.Message1=[[self.Message  objectForKey:@"treamname"] componentsSeparatedByString:@","];
        self.index1= [self.Message2 indexOfObject: self.Strindex];
    
        listTable = [[[UITableView alloc] initWithFrame:CGRectMake(0,10, 320,440) style:UITableViewStyleGrouped] autorelease];
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
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
   return  [self.Message1  count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
    
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//100134


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.index1=indexPath.row;
    [tableView reloadData];
    
    [self moveZu];
    
}
-(void)moveZu
{
    NSString *post=nil;
    
    post = [NSString stringWithFormat:@"currtreamid=%@&movetreamid=%@&UID=%@&f_UID=%@",self.Strindex,[self.Message2 objectAtIndex:self.index1],self.strUID,self.strfUID];
    
//    NSLog(@"%@",post);
    
    [SVProgressHUD showInView:nil status:@"请稍等.."];
    //将post数据转换为 NSASCIIStringEncoding 编码格式
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //要post的地址/
//    [request setURL:[NSURL URLWithString:@"http://119.44.220.4/mobilemove"]];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = [user objectForKey:@"url"]; 
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilemove?",url]]];

    //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
    
    //post类型
    [request setHTTPMethod:@"POST"];
    
    
    
    //设置post数据
    [request setHTTPBody:postData];
    //创建链接
    NSURLConnection * conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [request release];




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
    if (self.index1==indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;

    
    
    }
    [cell.textLabel setText:[self.Message1 objectAtIndex:indexPath.row]];
    
    return cell;
    
}

-(void)addTream
{
    UILabel *lable=(UILabel *)[self.view viewWithTag:10];
    [lable resignFirstResponder];
    //    if ([lable.text length]>0&&[lable.text length]<9) {
     if (![ self kongge:lable.text]) {
        [SVProgressHUD showAbnormalThenDismiss:@"请输入备注内容"];
    }else{
        if ([lable.text length]>8&&[lable.text length]<1) {
            [SVProgressHUD showAbnormalThenDismiss:@"备注不能超过8位"];
            return;

        }
    self.navigationItem.rightBarButtonItem.enabled=NO;
    NSString *post=nil;

    post = [NSString stringWithFormat:@"f_nickname=%@&UID=%@&f_UID=%@",lable.text,self.strUID,self.strfUID];
            
//    NSLog(@"%@",post);

       [SVProgressHUD showInView:nil status:@"请稍等.."];
    //将post数据转换为 NSASCIIStringEncoding 编码格式
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //要post的地址/
//    [request setURL:[NSURL URLWithString:@"http://119.44.220.4/updatefriendinfo"]];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *url = [user objectForKey:@"url"]; 
        
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@updatefriendinfo?",url]]];

    //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
    
    //post类型
    [request setHTTPMethod:@"POST"];
    
    
    
    //设置post数据
    [request setHTTPBody:postData];
    //创建链接
    NSURLConnection * conn1 = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [request release];
    //    }else{
    //
    //        [SVProgressHUD showAbnormalThenDismiss:@"组名在一位与八位之间"];
    //
    //
    //    }
    
    }
    
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
    
    //    NSError *error;
    [SVProgressHUD dismiss];
    self.navigationItem.rightBarButtonItem.enabled=YES;

    NSString *str=[[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
//    NSLog(@"wwww=%@",str);
    if (self.index==0) {
  
    if ([str intValue]==0) {
        UILabel *lable=(UILabel *)[self.view viewWithTag:10];

        [SVProgressHUD showAbnormalThenDismiss:@"添加成功"];
        [self.delegate UpdataFriengViewMessage:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",lable.text],[NSString stringWithFormat:@"%d",self.index], nil]];
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:lable.text forKey:@"ChageName"];
        [self performSelector:@selector(back) withObject:self afterDelay:0.3];
        
    }else{
        [SVProgressHUD showAbnormalThenDismiss:@"添加失败"];
        
        
    }
    
    }else{
        if ([str intValue]==0) {
            [SVProgressHUD showAbnormalThenDismiss:@"移动成功"];
            [self.delegate UpdataFriengViewMessage:[NSArray arrayWithObjects:[self.Message1 objectAtIndex:self.index1],[NSString stringWithFormat:@"%d",self.index], nil]];
            [self performSelector:@selector(back) withObject:self afterDelay:0.3];
            
        }else{
            [SVProgressHUD showAbnormalThenDismiss:@"添加失败"];
            
            
        }

    
    
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.navigationItem.rightBarButtonItem.enabled=YES;

    [SVProgressHUD dismiss];
    [SVProgressHUD showAbnormalThenDismiss:@"清监测网络"];

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
-(void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
