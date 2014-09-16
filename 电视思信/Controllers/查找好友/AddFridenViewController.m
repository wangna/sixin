//
//  AddFridenViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-9-27.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "AddFridenViewController.h"
#import "ASIHTTPRequest.h"
#import "AsyncImageView.h"
#import "AddFriend1ViewController.h"
#import "SVProgressHUD.h"
#import "Header.h"
@interface AddFridenViewController ()

@end

@implementation AddFridenViewController

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
    [_tableView release];



}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _data=[[NSMutableData alloc]init];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,320,self.view.frame.size.height-20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * array= [userDefaults dictionaryForKey:@"personF_Uid"];
    self.strUid= [[array objectForKey:[[array allKeys] objectAtIndex:0]]objectForKey:@"UId"] ;
    
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"添加好友" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonPressed:)];
	backItem.tag = 2;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];

	// Do any additional setup after loading the view.
}
-(void)buttonPressed:(UIButton *)sender
{
    if (self.strFUid==nil) {
        [SVProgressHUD showAbnormalThenDismiss:@"请选择好友"];
        return;
    }
    self.navigationItem.rightBarButtonItem.enabled=NO;
    [SVProgressHUD showInView:nil status:@"请稍等.."];
    NSString *post = [NSString stringWithFormat:@"f_UID=%@&UID=%@",self.strFUid,self.strUid];
    NSLog(@"%@",post);
    //将post数据转换为 NSASCIIStringEncoding 编码格式
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //要post的地址/
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = [user objectForKey:@"url"];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilerequestfriend?",url]]];
  
    //post类型
    [request setHTTPMethod:@"POST"];
    
    
    
    //设置post数据
    [request setHTTPBody:postData];
    //创建链接
    NSURLConnection * conn1 = [[NSURLConnection alloc] initWithRequest:request delegate:self];



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
//    NSLog(@"wwwww_________%@",str );
    if ([[str substringWithRange:NSMakeRange(1, 1)] intValue]==0) {
        [SVProgressHUD showAbnormalThenDismiss:@"发送成功"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Chage" object:@"123456" ];

        [self performSelector:@selector(back) withObject:self afterDelay:1.0];
    }
    if ([[str substringWithRange:NSMakeRange(1, 1)] intValue]==1) {
    
        [SVProgressHUD showAbnormalThenDismiss:@"你已经添加过该好友"];
    
    }
    
    [str release];
    
//    NSArray *ayyay= [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&error ];
//    NSLog(@"wwwww=%@",ayyay );
//    AddFridenViewController *search=[[AddFridenViewController alloc]init];
//    [search setHidesBottomBarWhenPushed:(BOOL)(1)];
//    search.FriendArray=ayyay;
//    [self.navigationController pushViewController:search animated:YES];
//    [search release];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.navigationItem.rightBarButtonItem.enabled=YES;

    [SVProgressHUD dismiss];
    [SVProgressHUD showAbnormalThenDismiss:@"请检测网络"];

}
-(void)back
{

    [self.navigationController popToRootViewControllerAnimated:YES];


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    
    return [self.FriendArray count];
    
    
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return [self.headViewArray count];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"%d",indexPath.row);
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

//        UIButton* backBtn=  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
//        backBtn.tag = 20000;
//        [backBtn setBackgroundImage:[UIImage imageNamed:@"listitem.png"] forState:UIControlStateHighlighted];
//        backBtn.userInteractionEnabled = NO;
//        [cell.contentView addSubview:backBtn];
//        [backBtn release];
        
        
        
        
    }
//    cell.textLabel.text=[[self.FriendArray objectAtIndex:indexPath.row]objectForKey:@"nickname"];
    
    for (UIView *vvv in cell.contentView.subviews) {
        if ([vvv isKindOfClass:[UILabel class]]) {
            [vvv removeFromSuperview];
            
        }
        if ([vvv isKindOfClass:[AsyncImageView class]]) {
            [vvv removeFromSuperview];
            
        }
        if ([vvv isKindOfClass:[UIImageView class]]) {
            [vvv removeFromSuperview];
            
        }
        
        
    }
    
    UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 59, 320, 1)];
    line.backgroundColor = [UIColor grayColor];
    [cell.contentView addSubview:line];
    [line release];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(60, 10, 100, 40)];
    [lable setBackgroundColor:[UIColor clearColor]];
    [lable setTextColor:[UIColor blackColor]];
    //    lable.text=[NSString stringWithFormat:@"%@",[[self.array objectAtIndex:i] objectForKey:@"nickname"]];
    [lable setText:[[self.FriendArray objectAtIndex:indexPath.row]objectForKey:@"nickname"]];
    
    [lable setTextAlignment:NSTextAlignmentLeft];
    [cell.contentView addSubview:lable];
    [lable  release];
    
    
    
    AsyncImageView * contentPic = [[[AsyncImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)] autorelease];
    contentPic.enabled=NO;
    contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,[[self.FriendArray objectAtIndex:indexPath.row]objectForKey:@"avatar"]];;
    [cell.contentView addSubview:contentPic];
    
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(280, 20, 20, 20)];
    imageview.tag=indexPath.row+30;
    imageview.image=[UIImage imageNamed:nil];
    [cell.contentView addSubview:imageview];
    [imageview release];
    
//    cell.accessoryType=UITableViewCellAccessoryCheckmark;


//
//    [cell.imageView addSubview:contentPic];
//    [contentPic release];
    
    
    //    cell.textLabel.text = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    //    cell.textLabel.backgroundColor = [UIColor clearColor];
    //    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    for (int i=0; i<[self.FriendArray count]; i++) {
        UIImageView *im=(UIImageView *)[tableView viewWithTag:i+30];
        if (i==indexPath.row) {
            im.image=[UIImage imageNamed:@"对.png"];

        }else{
        
            im.image=nil;
        
        }
    }
    
    
//    AddFriend1ViewController *search=[[AddFriend1ViewController alloc]init];
//    [search setHidesBottomBarWhenPushed:(BOOL)(1)];
//    search.FriendArray=[self.FriendArray objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:search animated:YES];
//    [search release];
     self.strFUid=[[self.FriendArray objectAtIndex:indexPath.row]objectForKey:@"UID"];


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
