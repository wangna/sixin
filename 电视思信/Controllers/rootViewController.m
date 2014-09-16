//
//  rootViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-9-22.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "rootViewController.h"
#import "MessageViewController.h"
#import "LinkManViewController.h"
#import "SearchViewController.h"
#import "SettingViewController.h"
#import "SVProgressHUD.h"
#import "RestViewController.h"


@interface rootViewController ()
{
    int type;
}
@end

@implementation rootViewController

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
    
    type = 0;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    strMi=@"bujizhu"; // 密码记住状态
    _data=[[NSMutableData alloc]init];
    _dictMessage =[[NSMutableDictionary alloc]init];
   

    image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    image3.image=[UIImage imageNamed:@"LOGO 条(1).png"];

    image2=[[UIImageView alloc]initWithFrame:CGRectMake(2, 5, 290, 34)];
    image2.image=[UIImage imageNamed:@"34.png"];

    UIButton *buttonRegistered=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [buttonRegistered setFrame:CGRectMake(120, aview.frame.size.height-50, 80, 40)];
    //    [buttonRegistered setImage:[UIImage imageNamed:@"蓝条.png"] forState:UIControlStateNormal];
    [buttonRegistered setTitle:@"登录" forState:UIControlStateNormal];
    [buttonRegistered addTarget:self action:@selector(buttonPressed1:) forControlEvents:UIControlEventTouchUpInside];
    [buttonRegistered setBackgroundColor:[UIColor clearColor]];

    [self inface];
	// Do any additional setup after loading the view.
}
-(void)inface
{
    
    aview=[[UIView alloc]init];
    aview.frame=CGRectMake(0,44, self.view.frame.size.width, self.view.frame.size.height-44);
    [aview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]]];
    [self.view addSubview:aview];
    [self.view addSubview:image3];
    [self.view addSubview:image2];
    
     tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap1:)];
    
    
    [aview addGestureRecognizer:tap];
    tap.enabled=NO;

//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"大背景.png"]]];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
   NSArray *arrMan= [userDefaults arrayForKey:@"yonghu"];
    UILabel *lableSure=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    lableSure.text=@"账号";
    [lableSure setBackgroundColor:[UIColor clearColor]];
    [lableSure setTextColor:[UIColor blackColor]];
    [aview addSubview:lableSure];
    [lableSure release];
    
    
    lable=[[UITextField alloc]initWithFrame:CGRectMake(60, 20, 250, 40)];
    [lable setBackgroundColor:[UIColor  clearColor]];
    [aview addSubview:lable];
    if (arrMan!=nil) {
        lable.text=[arrMan objectAtIndex:0];
        if ([[arrMan objectAtIndex:2]isEqualToString:@"jizhu"]) {
            lable.text=[arrMan objectAtIndex:0];
        }
    }
    lable.delegate=self;
    [lable setBorderStyle:UITextBorderStyleRoundedRect];
//    lable.clearButtonMode = UITextFieldViewModeWhileEditing;
    lable.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel *lablePressWord=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, 40, 40)];
    lablePressWord.text=@"密码";
    [lablePressWord setBackgroundColor:[UIColor clearColor]];
    [lablePressWord setTextColor:[UIColor blackColor]];
    [aview addSubview:lablePressWord];
    [lablePressWord  release];
    
    lable1=[[UITextField alloc]initWithFrame:CGRectMake(60, 80, 250, 40)];
    [lable1  setBackgroundColor:[UIColor  clearColor]];
    [aview addSubview:lable1];
    if (arrMan!=nil) {
        if ([[arrMan objectAtIndex:2]isEqualToString:@"jizhu"]) {
            lable1.text=[arrMan objectAtIndex:1];
        }
        
    }
    lable1.delegate=self;
//    lable1.clearButtonMode = UITextFieldViewModeWhileEditing;
    lable1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    lable1.secureTextEntry = YES;
    [lable1 setBorderStyle:UITextBorderStyleRoundedRect];
    
    
    
    //NSD
    NSString *strPath = [NSString stringWithFormat:@"%@/Documents/jizhu.plist", NSHomeDirectory()];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:strPath];
    
    
    UIButton *buttonjizhu=[[UIButton alloc]initWithFrame:CGRectMake(20, 150, 25, 25)];
//    [buttonjizhu setFrame:CGRectMake(20, 145, 30, 30)];
    
    if (dic == nil) {
        [buttonjizhu setImage:[UIImage imageNamed:@"记住框2.png"] forState:UIControlStateNormal];
    }
    else {
        
        if ([dic objectForKey:@"name"] || [dic objectForKey:@"pwd"]) {
            [buttonjizhu setImage:[UIImage imageNamed:@"记住框.png"] forState:UIControlStateNormal];
        }
        else {
            [buttonjizhu setImage:[UIImage imageNamed:@"记住框2.png"] forState:UIControlStateNormal];
        }
    }
    
//    if (arrMan!=nil) {
//        if ([[arrMan objectAtIndex:2]isEqualToString:@"jizhu"]) {
//            [buttonjizhu setImage:[UIImage imageNamed:@"记住框.png"] forState:UIControlStateNormal];
//        }else{
//        
//            [buttonjizhu setImage:[UIImage imageNamed:@"记住框2.png"] forState:UIControlStateNormal];
//
//        
//        }
//        
//    }else{
//    
//        [buttonjizhu setImage:[UIImage imageNamed:@"记住框2.png"] forState:UIControlStateNormal];
//
//    
//    }
    buttonjizhu.tag=900;
    [buttonjizhu setBackgroundColor:[UIColor clearColor]];
    [aview addSubview:buttonjizhu];
    [buttonjizhu addTarget:self action:@selector(jizhu:) forControlEvents:UIControlEventTouchUpInside];
    [buttonjizhu release];
    
    UILabel *lablejizhu=[[UILabel alloc]initWithFrame:CGRectMake(55, 150, 80, 30)];
    [lablejizhu setText:@"记住密码"];
    lablejizhu.textColor=[UIColor colorWithRed:0.56 green:0.5 blue:0.7 alpha:0.8];

    [lablejizhu setFont:[UIFont systemFontOfSize:18]];
    [lablejizhu setBackgroundColor:[UIColor clearColor]];
    [aview addSubview:lablejizhu];
    [lablejizhu release];
    
    
    
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(220, 140, 80, 40)];
    [button setImage:[UIImage imageNamed:@"登录2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    [aview addSubview:button];
    
    UILabel *lableYes=[[UILabel alloc]initWithFrame:CGRectMake(220, 140, 80, 40)];
    lableYes.text=@"登录";
    [lableYes setBackgroundColor:[UIColor clearColor]];
    [lableYes setTextAlignment:NSTextAlignmentCenter];
    [lableYes setTextColor:[UIColor whiteColor]];
    [aview addSubview:lableYes];
    [lableYes release];

    
   
    UILabel *lableRegistered=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 300, 40)];
    lableRegistered.text=@"没有账号,赶快去       吧 !";
    lableRegistered.textColor=[UIColor colorWithRed:0.56 green:0.5 blue:0.7 alpha:0.8];
    [lableRegistered setBackgroundColor:[UIColor clearColor]];
    [aview addSubview:lableRegistered];
    [lableRegistered  release];
    
    buttonRegistered1=[[UIButton alloc]initWithFrame:CGRectMake(130, 190, 40, 40)];

    [buttonRegistered1 setTitle:@"注册" forState:UIControlStateNormal];
    [buttonRegistered1.titleLabel setFont:[UIFont systemFontOfSize:16]];
    buttonRegistered1.titleLabel.textColor=[UIColor redColor];
    [buttonRegistered1 addTarget:self action:@selector(registered1:) forControlEvents:UIControlEventTouchUpInside];
    [buttonRegistered1 addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchDown];
    [buttonRegistered1 setBackgroundColor:[UIColor clearColor]];
    [aview addSubview:buttonRegistered1];
    
    UIButton *buttonhhhh=[[UIButton alloc]initWithFrame:CGRectMake(10, 190, 200, 40)];
    [buttonhhhh setBackgroundColor:[UIColor clearColor]];
    [buttonhhhh addTarget:self action:@selector(registered1:) forControlEvents:UIControlEventTouchUpInside];
    [aview addSubview:buttonhhhh];
    [buttonhhhh release];

    

}
-(void)jizhu:(UIButton *)sender
{
    //NSD
    NSString *strPath = [NSString stringWithFormat:@"%@/Documents/jizhu.plist", NSHomeDirectory()];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:strPath]) {
//        return NO;
//    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:strPath];
     
    
    if (sender.tag==900) {
        
        if (dic == nil) {
            dic = [[NSMutableDictionary alloc] init]; 
        }
        
        if (lable.text) {
            [dic setObject:lable.text forKey:@"name"];
        }
        if (lable1.text) {
            [dic setObject:lable1.text forKey:@"pwd"];
        }
        [dic writeToFile:strPath atomically:YES];
        
        
           [sender setImage:[UIImage imageNamed:@"记住框.png"] forState:UIControlStateNormal];
        sender.tag=901;
        strMi=@"jizhu";
    }else{
    if (sender.tag==901) {
        
        if (dic != nil) {
            if ([dic objectForKey:@"name"]) {
                [dic removeObjectForKey:@"name"];
            }
            if ([dic objectForKey:@"pwd"]) {
                [dic removeObjectForKey:@"pwd"]; 
            }
            [dic writeToFile:strPath atomically:YES];
        } 
        
        [sender setImage:[UIImage imageNamed:@"记住框2.png"] forState:UIControlStateNormal];
        sender.tag=900;
        strMi=@"bujizhu";
    }


    }

}
-(void)regist:(UIButton *)sender
{
    buttonRegistered1.titleLabel.textColor=[UIColor blueColor];



}
-(void)buttonPressed1:(id)sender
{
    buttonRegistered1.titleLabel.textColor=[UIColor redColor];
//    [self surehiddle];


}
-(void)registered1:(UIButton *)sender{

    RestViewController *rest=[[RestViewController alloc]init];
    [self.navigationController pushViewController:rest animated:YES];
    [rest release];
}

-(void)handleTap1:(UIGestureRecognizer *)gesture
{
    tap.enabled=NO;
    [lable1 resignFirstResponder];
    [lable resignFirstResponder];

}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    tap.enabled=YES;


    return YES;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    tap.enabled=YES;
   }
//取消第一响应
//-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self dismissKeyBord];
//}
-(void)dismissKeyBord
{
    [lable resignFirstResponder];
    [lable1 resignFirstResponder];

//    self.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-20);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //    [textField resignFirstResponder];
    tap.enabled=YES;
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    
    
}
-(void)right
{ 
    [self dismissKeyBord];
    
    type = 0;//第一步
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    //要post的地址/ 
    NSString *url = [NSString stringWithFormat:@"http://www.kusxin.com/mobileloginredirectaction?userid=%@&password=%@",lable.text,lable1.text];//外网
//    NSString *url = [NSString stringWithFormat:@"http://172.16.2.6/mobileloginredirectaction?userid=%@&password=%@",lable.text,lable1.text];//内网
    [request setURL:[NSURL URLWithString:url]];
    //post类型
    [request setHTTPMethod:@"POST"];  
    //创建链接
    conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    
    [SVProgressHUD showInView:nil status:@"加载中......"];
    
    [self.view setUserInteractionEnabled:NO];
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
    [self.view setUserInteractionEnabled:YES];

    NSError *error;

    if (type == 0) {
        
        type = 1;
        
        NSMutableString *str = [[NSMutableString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
        [str insertString:@"," atIndex:[str length] - 1];
        NSArray *arr = [str componentsSeparatedByString:@"/"];
        NSString *url1 = [arr objectAtIndex:1];
        NSArray *arr2 = [url1 componentsSeparatedByString:@","];
        NSString *url2 = [arr2 objectAtIndex:0];
        NSString *url3 = [NSString stringWithFormat:@"http://%@/",url2];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:url3 forKey:@"url"]; 
        
        //
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
        //要post的地址/
        NSString *url = [NSString stringWithFormat:@"%@/mobilelogin?userId=%@&passWord=%@",url3,lable.text,lable1.text];
        [request setURL:[NSURL URLWithString:url]];
        //post类型
        [request setHTTPMethod:@"POST"];
        //创建链接
        conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
        
        [SVProgressHUD showInView:nil status:@"加载中......"];

        [self.view setUserInteractionEnabled:NO];
        return;
    }
    else {
        
        [SVProgressHUD dismiss];
        
        self.arrayJSON= [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&error ];
        if (self.arrayJSON==NULL) {
            UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"密码或账号有误" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [av show];
            [av release];
        }else{
            //    NSLog(@"%@",self.arrayJSON );
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.arrayJSON forKey:@"person"];
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            for (int i=0; i<[self.arrayJSON count]; i++) {
                [dict setObject:[self.arrayJSON  objectAtIndex:i] forKey:[[self.arrayJSON  objectAtIndex:i]objectForKey:@"f_UId" ]];
            }
            [userDefaults setObject:dict forKey:@"personF_Uid"];
            [dict release];
            NSArray *arrr=[[NSArray alloc]initWithObjects:lable.text,lable1.text,strMi, nil];
            
            [userDefaults setObject:arrr forKey:@"yonghu"];
            [arrr release];
            
            
            
            MessageViewController *message=[[MessageViewController alloc]init];
            LinkManViewController *link=[[LinkManViewController alloc]init];
            SearchViewController *searcher=[[SearchViewController alloc]init];
            SettingViewController *sss=[[SettingViewController alloc]init];
            
            UINavigationController *na1=[[UINavigationController alloc]initWithRootViewController:message];
            na1.title=@"联系人";
            
            UINavigationController *na2=[[UINavigationController alloc]initWithRootViewController:link];
            na2.title=@"消息";
            UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"消息301.png"] tag:2];
            [item1 setFinishedSelectedImage:[UIImage imageNamed:@"消息   蓝30.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"消息  30.png"]];
            na2.tabBarItem =item1;
            [item1 release];
            UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"联系人" image:[UIImage imageNamed:@"好友列表灰 1 30.png"] tag:3];
            [item2 setFinishedSelectedImage:[UIImage imageNamed:@"好友列表 1蓝色30.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"好友列表灰 1 30.png"]];
            na1.tabBarItem =item2;
            [item2 release];
            na2.tabBarItem.tag=1005;
            
            
            UINavigationController *na3=[[UINavigationController alloc]initWithRootViewController:searcher];
            na3.title=@"发现";
            UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"发现灰301.png"] tag:3];
            [item3 setFinishedSelectedImage:[UIImage imageNamed:@"发现  蓝310.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"发现灰301.png"]];
            na3.tabBarItem =item3;
            [item3 release];
            
            
            UINavigationController  *na4=[[UINavigationController alloc]initWithRootViewController:sss];
            na4.title=@"设置";
            UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"设置30灰1.png"] tag:3];
            [item4 setFinishedSelectedImage:[UIImage imageNamed:@"设置 蓝302.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"设置30灰1.png"]];
            na4.tabBarItem =item4;
            [item4 release];
            
            UITabBarController *tabar=[[UITabBarController alloc]init];
            //    [tabar.view  setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
            tabar.viewControllers=[NSArray arrayWithObjects:na2,na1,na3,na4, nil];
            tabar.selectedIndex=0;
            [tabar.tabBar setBackgroundImage:[UIImage imageNamed:@"主条300.png"]];
            
            [self.navigationController pushViewController:tabar animated:YES];
            
            [message release];
            [link  release];
            [searcher release];
            [sss  release];
            [na1 release];
            [na2 release];
            [na3 release];
            [na4 release];
            [tabar  release];
            
            
        }
    }  
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:YES];

    [SVProgressHUD showAbnormalThenDismiss:@"请检测网络"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //NSD
    NSString *strPath = [NSString stringWithFormat:@"%@/Documents/jizhu.plist", NSHomeDirectory()];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:strPath]; 
    if (dic != nil) {
        if ([dic objectForKey:@"name"]) {
            lable.text=[dic objectForKey:@"name"];
        }
        if ([dic objectForKey:@"pwd"]) {
            lable1.text=[dic objectForKey:@"pwd"];
        } 
    }
    
    
    
//    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//    NSArray *arrMan= [userDefaults arrayForKey:@"yonghu"];
//    if (arrMan!=nil) {
//        if ([[arrMan objectAtIndex:2]isEqualToString:@"jizhu"]) {
//            lable.text=[arrMan objectAtIndex:0];
//            lable1.text=[arrMan objectAtIndex:1];
//        }else{
//           
//                 lable.text=[arrMan objectAtIndex:0];
//                       
//            lable1.text=@"";
//        
//        
//        }
//    }
//    [self inface];

//    buttonRegistered1.titleLabel.textColor=[UIColor redColor];

}
-(void)dealloc
{
    [super dealloc];
    [_data  release];
    [lable1 release];
    [lable  release];
    [image3 release];
    [image2 release];
    [buttonRegistered1 release];
    [tap release];
    [aview release];
    self.strUID=nil;
    self.arrayJSON=nil;
    self.dictMessage=nil;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
