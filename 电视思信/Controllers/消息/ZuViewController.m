//
//  ZuViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-11-6.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "ZuViewController.h"
#import "addTreamViewController.h"
#import "DeleteTreamViewController.h"
#import "Header.h"
#import <QuartzCore/QuartzCore.h>
@interface ZuViewController ()

@end

@implementation ZuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{




}
-(void)pushZu
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
    
    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];




}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:@"分组管理"];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSArray *arrr= [userDefaults arrayForKey:@"person"];
    //    NSLog(@"%@",arrr);
    _data=[[NSMutableData alloc]init];
    self.strUid=[[arrr objectAtIndex:0] objectForKey:@"UId"];
    NSString *str=[[arrr objectAtIndex:0] objectForKey:@"tream"];
    self.arrzu=[str componentsSeparatedByString:@","];
    NSString *str1=[[arrr objectAtIndex:0] objectForKey:@"treamname"];
    self.arr=[str1 componentsSeparatedByString:@","];
    

    
       listTable = [[[UITableView alloc] initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height-0) style:UITableViewStyleGrouped] autorelease];
    //    [listTable setBackgroundColor:[UIColor clearColor]];
    listTable.showsVerticalScrollIndicator = NO;
    [listTable setBackgroundColor:[UIColor clearColor]];
    [listTable setBackgroundView:nil];
    [listTable setDelegate:self];
    [listTable setDataSource:self];
    [listTable setTag:666];
    [self.view addSubview:listTable];

    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(pushZu)];
    self.navigationItem.backBarButtonItem=item;
    [item release];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        
        return 1;
    }else{
        
        
        return [self.arr count];
    }
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section==0) {
            return 50;
    }else{
    
        return 40;

    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * listCell = @"listCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    if (cell == NULL) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    for (UIView *vvv in cell.contentView.subviews) {
        if ([vvv isKindOfClass:[UIView class]]) {
            [vvv removeFromSuperview];
        }
        if ([vvv isKindOfClass:[UIImageView class]]) {
            [vvv removeFromSuperview];
        }
        
        
        
    }
    if (indexPath.section==0) {
        
        UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(15,10, 200, 30)];
        [lablequan1 setBackgroundColor:[UIColor clearColor]];
        //        [lablequan1 setTextColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.92 alpha:1.0]];
        [lablequan1 setFont:[UIFont systemFontOfSize:18]];
        lablequan1.text=@"添加分组";
        [lablequan1 setTextAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:lablequan1];
        [lablequan1 release];
        
        UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(270, 15, 13,20)];
        imageview2.image=[UIImage imageNamed:@"setting_row.png"];
//        imageview2.center=CGPointMake(280, cell.center.y);
        [cell.contentView addSubview:imageview2];
        [imageview2 release];
    }else{
        if (indexPath.row==0) {
            UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(15,5, 200, 30)];
            [lablequan1 setBackgroundColor:[UIColor clearColor]];
            [lablequan1 setFont:[UIFont systemFontOfSize:18]];
            lablequan1.text=[self.arr objectAtIndex:indexPath.row];
            [lablequan1 setTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:lablequan1];
            [lablequan1 release];
        }else{
    
        UILabel *lablequan1=[[UILabel alloc]initWithFrame:CGRectMake(15,5, 200, 30)];
        [lablequan1 setBackgroundColor:[UIColor clearColor]];
           [lablequan1 setFont:[UIFont systemFontOfSize:18]];
        lablequan1.text=[self.arr objectAtIndex:indexPath.row];
        [lablequan1 setTextAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:lablequan1];
        [lablequan1 release];
        
        UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(270, 10, 13,20)];
        imageview2.image=[UIImage imageNamed:@"setting_row.png"];
//        imageview2.center=CGPointMake(280, cell.center.y);
        [cell.contentView addSubview:imageview2];
        [imageview2 release];
        }
    }
    
    
    
    return cell;
}
-(void)addTreamViewMessage:(id)message
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSArray *arrr=  [userDefaults arrayForKey:@"yonghu"];
    [self request:arrr];


}
-(void)DeleteTreamViewMessage:(id)message
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSArray *arrr=  [userDefaults arrayForKey:@"yonghu"];
    [self request:arrr];


}
-(void)request:(NSArray *)arr
{
    
    NSString *post = [NSString stringWithFormat:@"userId=%@&passWord=%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
    //    NSLog(@"post=%@",post);
    //将post数据转换为 NSASCIIStringEncoding 编码格式
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    //要post的地址/
    //    [request setURL:[NSURL URLWithString:@"http://119.44.220.4/mobilelogin"]];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = [user objectForKey:@"url"]; 
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilelogin?",url]]];
    
    //    [request setURL:[NSURL URLWithString:@"http://172.16.4.5:8080/TSSP/mobilelogin"]];
    
    //post类型
    [request setHTTPMethod:@"POST"];
    
    
    
    //设置post数据
    [request setHTTPBody:postData];
    //创建链接
    NSURLConnection * conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    
    
    
    
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
    
    NSArray *arrPerson= [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&error ];
    NSLog(@"arrPerson=%@",arrPerson);
    if (arrPerson==NULL) {
        ;
    }else{
        
        
        NSString *str=[[arrPerson objectAtIndex:0] objectForKey:@"tream"];
        self.arrzu=[str componentsSeparatedByString:@","];
        NSString *str1=[[arrPerson objectAtIndex:0] objectForKey:@"treamname"];
        self.arr=[str1 componentsSeparatedByString:@","];
        [listTable reloadData];
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setObject:arrPerson forKey:@"person"];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        for (int i=0; i<[arrPerson count]; i++) {
            
            [dict setObject:[arrPerson  objectAtIndex:i] forKey:[[arrPerson  objectAtIndex:i]objectForKey:@"f_UId" ]];
        }
        
        [userDefaults setObject:dict forKey:@"personF_Uid"];
        [dict release];

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
    addTreamViewController *firstViewController = [[addTreamViewController alloc] init];
            [firstViewController setHidesBottomBarWhenPushed:(BOOL)(1)];
           firstViewController.strUid=self.strUid;
         firstViewController.delegate=self;
             [self.navigationController pushViewController:firstViewController animated:YES];
          [firstViewController release];
        
        
    }else{
        if (indexPath.row!=0) {
     
        DeleteTreamViewController *firstViewController = [[DeleteTreamViewController alloc] init];
        [firstViewController setHidesBottomBarWhenPushed:(BOOL)(1)];
        firstViewController.strUid=[self.arrzu objectAtIndex:indexPath.row];
        firstViewController.TreamName=[self.arr objectAtIndex:indexPath.row];
        firstViewController.delegate=self;
        firstViewController.index=indexPath.row;
        [self.navigationController pushViewController:firstViewController animated:YES];
        [firstViewController release];
        }
    }
  
    
    
}
-(void)dealloc
{
    [super dealloc];
    [_data release];
    _strUid=nil;
    _arr=nil;
    _arrzu=nil;


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
