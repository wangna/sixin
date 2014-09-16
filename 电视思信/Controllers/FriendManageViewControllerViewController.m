//
//  FriendManageViewControllerViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-9-27.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "FriendManageViewControllerViewController.h"
#import "SearchFriendViewController.h"
@interface FriendManageViewControllerViewController ()

@end

@implementation FriendManageViewControllerViewController

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
     
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(15, 30, 295,100) style:UITableViewStyleGrouped];
    //    [listTable setBackgroundColor:[UIColor clearColor]];
    
    [listTable setBackgroundColor:[UIColor clearColor]];
    [listTable setBackgroundView:nil];
    [listTable.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    [listTable setClipsToBounds:YES];
    
    [listTable setShowsHorizontalScrollIndicator:YES];
    [listTable setShowsVerticalScrollIndicator:YES];
    [listTable setBounces:NO];
    [listTable setDelegate:self];
    [listTable setDataSource:self];
    [listTable setTag:666];
    [self.view addSubview:listTable];

    
    
    secondTable = [[UITableView alloc] initWithFrame:CGRectMake(listTable.frame.origin.x, listTable.frame.origin.y + listTable.frame.size.height + 10, 295, 60)style:UITableViewStyleGrouped];
    [secondTable setTag:667];
    [secondTable setBackgroundView:nil];
    [secondTable setBackgroundColor:[UIColor clearColor]];
    [secondTable setBounces:NO];
    [secondTable setDelegate:self];
    [secondTable setDataSource:self];
    [self.view addSubview:secondTable];

	// Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 666) {
        return 1;
    }
    else
        return 1;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//100134
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 666) {
        SearchFriendViewController *search=[[SearchFriendViewController alloc]init];
        [search setHidesBottomBarWhenPushed:(BOOL)(1)];

        [self.navigationController pushViewController:search animated:YES];
        [search release];
        
        
           }
    else if (tableView.tag == 667) {
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 666) {
        static NSString * listCell = @"listCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:listCell];
        if (cell == NULL) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell] autorelease];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(280, 20, 11,16)];
            imageview2.image=[UIImage imageNamed:@"UpAccessory@2x.png"];
            imageview2.center=CGPointMake(260, cell.center.y);
            [cell.contentView addSubview:imageview2];
            [imageview2 release];
            
        }
        [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"image-1.png"]]];
        [cell.textLabel setText:@"添加好友"];
        [cell.textLabel setFont:[UIFont fontWithName:@"Heiti SC" size:20]];

        
                
        return cell;
        
    }
    else{
        static NSString * listCell = @"secondCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:listCell];
        if (cell == NULL) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell] autorelease];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(280, 20, 11,16)];
            imageview2.image=[UIImage imageNamed:@"UpAccessory@2x.png"];
            imageview2.center=CGPointMake(260, cell.center.y);
            [cell.contentView addSubview:imageview2];
            [imageview2 release];
        }
        [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"image-1.png"]]];
        [cell.textLabel setText:@"添加分组"];
        [cell.textLabel setFont:[UIFont fontWithName:@"Heiti SC" size:20]];
        
        return cell;
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
