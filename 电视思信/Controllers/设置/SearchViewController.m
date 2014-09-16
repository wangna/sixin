//
//  SearchViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-9-22.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchFriendViewController.h"
#import "Header.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"发现";
 
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.035 green:0.117 blue:0.184 alpha:0.286];

    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"发现灰色 30.png"] tag:2];
//    [item setFinishedSelectedImage:[UIImage imageNamed:@"发现  蓝30.png"]
//       withFinishedUnselectedImage:[UIImage imageNamed:@"发现灰色 30.png"]];
    self.tabBarItem = item;
    [item release];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 300, 50)];
    imageview.image=[UIImage imageNamed:@"添加好.png"];
    [self.view addSubview:imageview];
    [imageview release];
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(60, 20, 300, 50)];
    lable1.text=@"添加好友";
    [lable1 setFont:[UIFont systemFontOfSize:20]];
    [lable1 setBackgroundColor:[UIColor clearColor]];
    [lable1 setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:lable1];
    [lable1 release];
    
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 300, 50)];
    [button addTarget:self action:@selector(pass) forControlEvents:UIControlEventTouchUpInside];
    //    [button setTitle:@"修改密码" forState:UIControlStateNormal];
    //    [button.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [button setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:button];
    [button release];
    
    UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(285, 35, 13,20)];
    imageview2.image=[UIImage imageNamed:@"setting_row.png"];
    
    [self.view addSubview:imageview2];
    [imageview2 release];
    
    UIImageView *imageview21=[[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 30,30)];
    imageview21.image=[UIImage imageNamed:@"发现  蓝310.png"];
    
    [self.view addSubview:imageview21];
    [imageview21 release];

//    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"发现  蓝.png"]]];

    
    
	// Do any additional setup after loading the view.
}
-(void)pass
{

    SearchFriendViewController *search=[[SearchFriendViewController alloc]init];
    [search setHidesBottomBarWhenPushed:(BOOL)(1)];
    
    [self.navigationController pushViewController:search animated:YES];
    [search release];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
