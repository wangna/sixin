//
//  AddFriend1ViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-9-27.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "AddFriend1ViewController.h"
#import "AsyncImageView.h"
#import "SearchFriendViewController.h"
#import "AddZuViewController.h"
@interface AddFriend1ViewController ()

@end

@implementation AddFriend1ViewController

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
 
    //    [listTable setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    
    UIImageView *imagepic=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    imagepic.image=[UIImage  imageNamed:@"datu.png"];
    [self.view  addSubview:imagepic];
    [imagepic  release];
    
    
    AsyncImageView * contentPic = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 40, 60, 60)];
    contentPic.urlString = [NSString stringWithFormat:@"http://172.16.11.6/TSSP_FILE/HeadPic/%@",[self.FriendArray objectForKey:@"avatar"]];;
    [self.view addSubview:contentPic];
    [contentPic  release];
    
    UILabel *lableName=[[UILabel alloc]initWithFrame:CGRectMake(750, 28, 200, 40)];
    lableName.text=[self.FriendArray objectForKey:@"nickname"];
    [lableName setTextAlignment:NSTextAlignmentCenter];
    [lableName setBackgroundColor:[UIColor clearColor]];
    [lableName setTextColor:[UIColor blackColor]];
    [imagepic addSubview:lableName];
    [lableName  release];

    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(15, 100, 290, 350) style:UITableViewStyleGrouped];
    [listTable setBackgroundColor:[UIColor clearColor]];
    [listTable setBackgroundView:nil];
    [listTable.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    [listTable setClipsToBounds:YES];
    
    [listTable setShowsHorizontalScrollIndicator:NO];
    [listTable setShowsVerticalScrollIndicator:NO];
    [listTable setBounces:NO];
    [listTable setDelegate:self];
    [listTable setDataSource:self];
    [listTable setTag:666];
    [self.view addSubview:listTable];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(60, 290, 200, 50)];
    [button setImage:[UIImage imageNamed:@"找密码等.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *lableEmail=[[UILabel alloc]initWithFrame:CGRectMake(60, 290, 200, 50)];
    lableEmail.text=@"加为好友";
    [lableEmail setTextAlignment:NSTextAlignmentCenter];
    [lableEmail setBackgroundColor:[UIColor clearColor]];
    [lableEmail setTextColor:[UIColor blackColor]];
    [self.view addSubview:lableEmail];
    [lableEmail  release];
    
    viewAdd=[[UIView alloc]initWithFrame:CGRectMake(20, 20, 280, 200)];
    [viewAdd  setBackgroundColor:[UIColor  colorWithRed:0.2 green:0.5 blue:0.5 alpha:1]];
    [self.view addSubview:viewAdd];
    lableMessage=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 36)];
    [viewAdd addSubview:lableMessage];
    [lableMessage setBackgroundColor:[UIColor clearColor]] ;
    
    lable=[[UITextField alloc]initWithFrame:CGRectMake(20, 50, 240, 60)];
    [lable setBackgroundColor:[UIColor whiteColor]];
    [viewAdd addSubview:lable];
    [lable setFont:[UIFont systemFontOfSize:30]];
    [lable setBorderStyle:UITextBorderStyleRoundedRect];
    lable.clearButtonMode = UITextFieldViewModeWhileEditing;
    lable.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIButton *button11=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button11 setFrame:CGRectMake(60, 130, 60, 50)];
    [button11 setTitle:@"确定" forState:UIControlStateNormal];
    [button11 addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
//    [button11 setBackgroundColor:[UIColor whiteColor]];
    [viewAdd addSubview:button11];
    
//    UILabel *lableEmail1=[[UILabel alloc]initWithFrame:CGRectMake(60, 130, 60, 50)];
//    lableEmail1.text=@"确定";
//    [lableEmail1 setTextAlignment:NSTextAlignmentCenter];
//    [lableEmail1 setBackgroundColor:[UIColor clearColor]];
//    [lableEmail1 setTextColor:[UIColor blackColor]];
//    [viewAdd addSubview:lableEmail1];
//    [lableEmail1  release];
    
    
    
    
    UIButton *buttonRegistered=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonRegistered setFrame:CGRectMake(150, 130, 60, 50)];
    [buttonRegistered setTitle:@"取消" forState:UIControlStateNormal];
    [buttonRegistered addTarget:self action:@selector(cencell) forControlEvents:UIControlEventTouchUpInside];
//    [buttonRegistered setBackgroundColor:[UIColor whiteColor]];
    [viewAdd addSubview:buttonRegistered];
    
//    UILabel *lableEmail2=[[UILabel alloc]initWithFrame:CGRectMake(150, 130, 60, 50)];
//    lableEmail2.text=@"取消";
//    [lableEmail2 setTextAlignment:NSTextAlignmentCenter];
//    [lableEmail2 setBackgroundColor:[UIColor clearColor]];
//    [lableEmail2 setTextColor:[UIColor blackColor]];
//    [viewAdd addSubview:lableEmail2];
//    [lableEmail2  release];
    
    

    [viewAdd  setHidden:YES];
    

	// Do any additional setup after loading the view.
}
-(void)sure
{
    if ([lableMessage.text isEqualToString:@"修改标题"]) {
        
    }else{
    
    
    
    }

}
-(void)cencell
{
    lableMessage.text=@"";
    viewAdd.hidden=YES;

}
-(void)addFriend
{





}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return 1;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  3;
}
//100134
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:
 
            
            break;
            
        case 1:
     
            viewAdd.hidden=NO;
            lableMessage.text=@"修改标题";
            
            break;
        case 2:
            viewAdd.hidden=NO;
            lableMessage.text=@"添加分组";

            
            break;
            
        default:
            break;
    }

        
   }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString * listCell = @"listCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:listCell];
        if (cell == NULL) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell] autorelease];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(270, 20, 11,16)];
//            imageview2.image=[UIImage imageNamed:@"UpAccessory@2x.png"];
//            imageview2.center=CGPointMake(260, cell.center.y);
//            [cell.contentView addSubview:imageview2];
//            [imageview2 release];
            
        }
 
    switch (indexPath.section) {
        case 0:
            [cell.textLabel setText:[NSString stringWithFormat:@"账号 : %@", [self.FriendArray objectForKey:@"userId"]]];
            [cell.textLabel setFont:[UIFont fontWithName:@"Heiti SC" size:20]];

            break;
            
        case 1:
            [cell.textLabel setText:@"修改备注"];
            [cell.textLabel setFont:[UIFont fontWithName:@"Heiti SC" size:20]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(270, 20, 11,16)];
            imageview2.image=[UIImage imageNamed:@"UpAccessory@2x.png"];
            imageview2.center=CGPointMake(260, cell.center.y);
            [cell.contentView addSubview:imageview2];
            [imageview2 release];
            
            break;
        case 2:
            [cell.textLabel setText:@"好友分组"];
            [cell.textLabel setFont:[UIFont fontWithName:@"Heiti SC" size:20]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            UIImageView *imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(270, 20, 11,16)];
            imageview3.image=[UIImage imageNamed:@"UpAccessory@2x.png"];
            imageview3.center=CGPointMake(260, cell.center.y);
            [cell.contentView addSubview:imageview3];
            [imageview3 release];
            
            break;
            
        default:
            break;
    }
    
        
        
        return cell;
        
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
