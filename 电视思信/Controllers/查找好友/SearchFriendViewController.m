//
//  SearchFriendViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-9-27.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "SearchFriendViewController.h"
#import "AddFridenViewController.h"
#import "SVProgressHUD.h"
#import "Header.h"
@interface SearchFriendViewController ()

@end

@implementation SearchFriendViewController

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
    [lable release];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _data=[[NSMutableData alloc]init];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSArray *array= [userDefaults arrayForKey:@"person"];
    self.strUid= [[array objectAtIndex:0] objectForKey:@"UId"];
    [self.navigationItem setTitle:@"搜索好友"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]]];
    UIImageView *imagepic=[[UIImageView alloc]init];
    imagepic.frame=self.view.frame;
    imagepic.image=[UIImage imageNamed:@"背景.png"];
    imagepic.userInteractionEnabled=YES;
    [self.view addSubview:imagepic];
    [imagepic  release];
    
//    UILabel *lableSearch=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 20)];
//    lableSearch.text=@"添加好友";
//    [lableSearch setFont:[UIFont fontWithName:@"Heiti SC" size:18]];
//
//    [lableSearch setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:lableSearch];
//    [lableSearch release];
    
    
    
    lable=[[UITextField alloc]initWithFrame:CGRectMake(20, 5, 280,40)];
    [lable setBackgroundColor:[UIColor  whiteColor]];
    [lable setFont:[UIFont systemFontOfSize:20]];
    [lable setPlaceholder:@"请输入昵称或者ID号"];
    lable.delegate=self;
    lable.clearsOnBeginEditing = YES;
    lable.clearButtonMode = UITextFieldViewModeWhileEditing;
    lable.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    [imagepic addSubview:lable];
    [lable setBorderStyle:UITextBorderStyleRoundedRect];
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(addTream)];
    
	backItem.tag = 90;
	self.navigationItem.rightBarButtonItem = backItem;
    [backItem release];

	// Do any additional setup after loading the view.
}
-(void)addTream
{
    if ([lable.text length] == 0 || lable.text == nil) {
        [SVProgressHUD showAbnormalThenDismiss:@"请输入昵称或者ID"];
    }
    else {
        [SVProgressHUD showInView:nil status:@"请稍等.."];
        self.navigationItem.rightBarButtonItem.enabled=NO;
        NSString *post = [NSString stringWithFormat:@"userId=%@&UID=%@",lable.text,self.strUid];
        //    NSLog(@"%@",post);
        //将post数据转换为 NSASCIIStringEncoding 编码格式
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        //要post的地址/
        //    [request setURL:[NSURL URLWithString:@"http://119.44.220.4/searchfriend"]];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *url = [user objectForKey:@"url"];
        
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@searchfriend?",url]]];
        
        //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
        
        //post类型
        [request setHTTPMethod:@"POST"];
         
        
        //设置post数据
        [request setHTTPBody:postData];
        //创建链接
        NSURLConnection * conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
        [request release];
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
    
    NSError *error;
    self.navigationItem.rightBarButtonItem.enabled=YES;

    [SVProgressHUD dismiss];
    NSArray *ayyay= [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&error ];
//    NSLog(@"xxxx=%@",ayyay );
    if ([ayyay count]==0) {
        [SVProgressHUD showAbnormalThenDismiss:@"没有该好友"];
    }else{
    AddFridenViewController *search=[[AddFridenViewController alloc]init];
    [search setHidesBottomBarWhenPushed:(BOOL)(1)];
    search.FriendArray=ayyay;
    [self.navigationController pushViewController:search animated:YES];
    [search release];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showAbnormalThenDismiss:@"请检测网络"];
    self.navigationItem.rightBarButtonItem.enabled=YES;

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //     NSLog(@"2222");
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
      
    // Dispose of any resources that can be recreated.
}

@end
