//
//  RestViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-10-21.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "RestViewController.h"
#import "SVProgressHUD.h"
#import "Header.h"
@interface RestViewController ()

@end
#define CHAR_NUMBER_TEXT @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\n"
@implementation RestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)back
{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title=@"注册";
 [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]]];
//    self.navigationController.navigationItem.title=@"注册";
    _data=[[NSMutableData alloc]init];
    UIButton *backButton = [UIButton buttonWithType:101];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"登录" forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    self.navigationItem.backBarButtonItem = backItem;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.207 green:0.592 blue:0.831 alpha:0.8];
   strsex=@"男";
    [self registered1:nil];
	// Do any additional setup after loading the view.
}
-(void)registered1:(UIButton *)sender{
    
    //    self.navigationController.navigationBar.hidden=YES;
    //    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    //    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonPressed1:)];
    //	backItem.tag = 90;
    //	self.navigationItem.leftBarButtonItem = backItem;
    //    [backItem release];
    
    viewRegistered=[[UIView alloc]init];
    viewRegistered.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [viewRegistered setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]]];
    [self.view addSubview:viewRegistered];
//    [self.view addSubview:image3];
//    [self.view addSubview:image2];
    
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    
    
    [viewRegistered addGestureRecognizer:tap];
    tap.enabled=NO;
    //
    //    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(2, 10, 290, 40)];
    //    image2.image=[UIImage imageNamed:@"标志.png"];
    //    [viewRegistered addSubview:image2];
    //    [image2 release];
    
    
    UILabel *lableUser=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    lableUser.text=@"昵称";
    [lableUser setTextColor:[UIColor blackColor]];
    [lableUser setBackgroundColor:[UIColor clearColor]];
    [viewRegistered addSubview:lableUser];
    [lableUser  release];
    
    
    lableName=[[UITextField alloc]initWithFrame:CGRectMake(90, 10, 210, 40)];
    [lableName setBackgroundColor:[UIColor  whiteColor]];
    lableName.delegate=self;
    [viewRegistered addSubview:lableName];
    //    lableName.text=@"请输入1到8位的用户名";
    [lableName setBackgroundColor:[UIColor clearColor]];
    lableName.clearsOnBeginEditing = YES;
    [lableName setBorderStyle:UITextBorderStyleRoundedRect];
//    lableName.clearButtonMode = UITextFieldViewModeWhileEditing;
    lableName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    UILabel *lableSure=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 40, 40)];
    [lableSure setBackgroundColor:[UIColor clearColor]];
    lableSure.text=@"性别";
    [lableSure setTextColor:[UIColor blackColor]];
    [viewRegistered addSubview:lableSure];
    [lableSure  release];
    
    
    UIButton *buttonMan=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonMan setFrame:CGRectMake(100, 55, 45, 40)];
    buttonMan.tag=1001;
    //    [buttonMan setTitle:@"登陆" forState:UIControlStateNormal];
    [buttonMan setImage:[UIImage imageNamed:@"注册用.png"] forState:UIControlStateNormal];
    [buttonMan setBackgroundColor:[UIColor clearColor]];
    [buttonMan addTarget:self action:@selector(sex:) forControlEvents:UIControlEventTouchUpInside];
    [buttonMan setBackgroundColor:[UIColor clearColor]];
    [viewRegistered addSubview:buttonMan];
    
    UILabel *lableMan=[[UILabel alloc]initWithFrame:CGRectMake(150, 55, 40, 40)];
    [lableMan setBackgroundColor:[UIColor clearColor]];
    lableMan.text=@"男";
    [lableMan setTextColor:[UIColor blackColor]];
    [viewRegistered addSubview:lableMan];
    [lableMan release];
    
    
    UIButton *buttonwon=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonwon setBackgroundColor:[UIColor clearColor]];
    [buttonwon setFrame:CGRectMake(195, 55, 45, 40)];
    buttonwon.tag=1000;
    //    [buttonwon setTitle:@"注册" forState:UIControlStateNormal];
    [buttonwon setImage:[UIImage imageNamed:@"注册用灰点.png"] forState:UIControlStateNormal];
    [buttonwon addTarget:self action:@selector(sex:) forControlEvents:UIControlEventTouchUpInside];
    [buttonwon setBackgroundColor:[UIColor clearColor]];
    [viewRegistered addSubview:buttonwon];
    UILabel *lableWon=[[UILabel alloc]initWithFrame:CGRectMake(245, 55, 40, 40)];
    [lableWon setBackgroundColor:[UIColor clearColor]];
    lableWon.text=@"女";
    [lableWon setTextColor:[UIColor blackColor]];
    [viewRegistered addSubview:lableWon];
    [lableWon release];
    
    
    
    
    UILabel *lablePressWord=[[UILabel alloc]initWithFrame:CGRectMake(10, 105, 40, 40)];
    lablePressWord.text=@"密码";
    
    [lablePressWord setBackgroundColor:[UIColor clearColor]];
    [lablePressWord setTextColor:[UIColor blackColor]];
    [viewRegistered addSubview:lablePressWord];
    [lablePressWord  release];
    
    lablePress=[[UITextField alloc]initWithFrame:CGRectMake(90, 105, 210, 40)];
    lablePress.delegate=self;
    [lablePress  setBackgroundColor:[UIColor  clearColor]];
    [viewRegistered addSubview:lablePress];
    lablePress.delegate=self;
    //    lableName.text=@"请输入1到8位的用户名";
    
    lablePress.secureTextEntry = YES;
    [lablePress setBorderStyle:UITextBorderStyleRoundedRect];
//    lablePress.clearButtonMode = UITextFieldViewModeWhileEditing;
    lablePress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel *lableSurePressWord=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 80, 40)];
    lableSurePressWord.text=@"确认密码";
    [lableSurePressWord  setBackgroundColor:[UIColor  clearColor]];
    [lableSurePressWord setTextColor:[UIColor blackColor]];
    [viewRegistered addSubview:lableSurePressWord];
    [lableSurePressWord  release];
    
    lableTextPressWord=[[UITextField alloc]initWithFrame:CGRectMake(90, 160, 210, 40)];
    [lableTextPressWord  setBackgroundColor:[UIColor  clearColor]];
    lableTextPressWord.delegate=self;
    [viewRegistered addSubview:lableTextPressWord];
    lableTextPressWord.delegate=self;
    lableTextPressWord.secureTextEntry = YES;
    
    [lableTextPressWord setBorderStyle:UITextBorderStyleRoundedRect];
//    lableTextPressWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    lableTextPressWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel *lableEmail=[[UILabel alloc]initWithFrame:CGRectMake(10, 210, 40, 40)];
    lableEmail.text=@"邮箱";
    [lableEmail  setBackgroundColor:[UIColor  clearColor]];
    [lableEmail setTextColor:[UIColor blackColor]];
    [viewRegistered addSubview:lableEmail];
    [lableEmail  release];
    
    lableTextEmail=[[UITextField alloc]initWithFrame:CGRectMake(90, 210, 210, 40)];
    lableTextEmail.delegate=self;
    [lableTextEmail  setBackgroundColor:[UIColor  clearColor]];
    [viewRegistered addSubview:lableTextEmail];
    [lableTextEmail setBorderStyle:UITextBorderStyleRoundedRect];
//    lableTextEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    lableTextEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel *lableiphone=[[UILabel alloc]initWithFrame:CGRectMake(10, 260, 40, 40)];
    lableiphone.text=@"手机";
    [lableiphone  setBackgroundColor:[UIColor  clearColor]];
    [lableiphone setTextColor:[UIColor blackColor]];
    [viewRegistered addSubview:lableiphone];
    [lableiphone  release];
    
    lableTextiphone=[[UITextField alloc]initWithFrame:CGRectMake(90, 260, 210, 40)];
    lableTextiphone.delegate=self;
    [lableTextiphone  setBackgroundColor:[UIColor  clearColor]];
    [viewRegistered addSubview:lableTextiphone];
    [lableTextiphone setBorderStyle:UITextBorderStyleRoundedRect];
//    lableTextiphone.clearButtonMode = UITextFieldViewModeWhileEditing;
    lableTextiphone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    //    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [button setFrame:CGRectMake(110,330, 100, 40)];
    //    [button setTitle:@"提 交" forState:UIControlStateNormal];
    //    [button addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    //    [button setBackgroundColor:[UIColor whiteColor]];
    //    [viewRegistered addSubview:button];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(110, 320, 100, 40)];
    [button setImage:[UIImage imageNamed:@"登录2.png"] forState:UIControlStateNormal];
//    [button setTitle:@"登录" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    [viewRegistered addSubview:button];
    
    UILabel *lableYes=[[UILabel alloc]initWithFrame:CGRectMake(110, 320, 100,40)];
    lableYes.text=@"提交";
    [lableYes setBackgroundColor:[UIColor clearColor]];
    [lableYes setTextAlignment:NSTextAlignmentCenter];
    [lableYes setTextColor:[UIColor whiteColor]];
    [viewRegistered addSubview:lableYes];
    [lableYes release];
    
    
}
-(void)dismissKeyBord
{
    [UIView animateWithDuration:0.3f animations:^{
        [viewRegistered setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
    [lableTextiphone resignFirstResponder];
    [lableTextPressWord resignFirstResponder];
    [lableTextEmail resignFirstResponder];
    [lableName resignFirstResponder];
    [lablePress resignFirstResponder];
    //    self.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-20);
}
-(void)sex:(UIButton *)sender
{
    
    if (sender.tag==1001) {
        [sender setImage:[UIImage imageNamed:@"注册用.png"] forState:UIControlStateNormal];
        UIButton *button=(UIButton *)[self.view viewWithTag:1000];
        [button setImage:[UIImage imageNamed:@"注册用灰点.png"] forState:UIControlStateNormal];
        
        
        strsex=@"男";
    }else{
        [sender setImage:[UIImage imageNamed:@"注册用.png"] forState:UIControlStateNormal];
        
        UIButton *button=(UIButton *)[self.view viewWithTag:1001];
        [button setImage:[UIImage imageNamed:@"注册用灰点.png"] forState:UIControlStateNormal];
        strsex=@"女";
        
    }
    
}

- (BOOL)verificationEmail:(NSString *)email{
//    NSLog(@"email=%@",str);
    if ([email length]==0) {
        return YES;
    }
    NSString *regexString=@"^([0-9a-zA-Z]([-.\\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\\w]*[0-9a-zA-Z])*\\.)+[a-zA-Z]{2,9})$";
    NSRegularExpression *regular=[NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numer= [regular numberOfMatchesInString:email options:NSMatchingReportProgress range:NSMakeRange(0, email.length)];
    if (numer) {
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)checkTel:(NSString *)str

{
    if ([str length]==0) {

        return YES;
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        return NO;
        
    }
    
    
    
    return YES;
    
}
-(BOOL)SurePress:(NSString *)str
{
    if ([str length]>=6&&[str length]<=12) {
        return YES;
    }
    if ([str isEqualToString:lableTextPressWord.text]) {
        return YES;
    }
    return NO;
    
}
-(BOOL)SureName:(NSString *)str
{
    
    if([str length]>=1&&[str length]<=8)
    {
        return YES;
    }
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //    [textField resignFirstResponder];
    tap.enabled=YES;
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    tap.enabled=YES;

    return YES;

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    
    
}
-(BOOL)PressMima:(NSString *)ssss
{

    
    for (int i=0; i<[ssss length]; i++) {
        NSString *sa=[ssss substringWithRange:NSMakeRange(i, 1)];
        if ([CHAR_NUMBER_TEXT rangeOfString:sa].length==0){
            return NO;
        }else{
            
            
            
           
            
        }

    }
   
  return YES;

}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:0.5];
    if(textField == lableName)
    {
    
            viewRegistered.frame = CGRectMake(0, 0, 320,self.view.frame.size.height-44);
            
        
    }else if(textField == lablePress)
    {
        if (self.view.frame.size.height>500) {
        viewRegistered.frame = CGRectMake(0, 0, 320,self.view.frame.size.height-44);
        }else{
            viewRegistered.frame = CGRectMake(0, -30, 320,self.view.frame.size.height-44);

        }
    }
    else if(textField == lableTextPressWord)
    {
        if (self.view.frame.size.height>500) {
            viewRegistered.frame = CGRectMake(0, -70, 320,self.view.frame.size.height-44);

        }else{
            viewRegistered.frame = CGRectMake(0, -80, 320,self.view.frame.size.height-44);

        }
    }
    else if(textField == lableTextEmail)
    {
        if (self.view.frame.size.height>500) {
            viewRegistered.frame = CGRectMake(0, -90, 320,self.view.frame.size.height-44);
            
        }else{
            viewRegistered.frame = CGRectMake(0, -160, 320,self.view.frame.size.height-44);
            
        }

    }
    else if(textField == lableTextiphone)
    {
        if (self.view.frame.size.height>500) {
            viewRegistered.frame = CGRectMake(0, -130, 320, self.view.frame.size.height-44);
            
        }else{
            viewRegistered.frame = CGRectMake(0, -220, 320, self.view.frame.size.height-44);
            
        }
    }
    [UIView commitAnimations];
}

-(void)sure
{
    [self dismissKeyBord];
    //    [SVProgressHUD show];
    
    if (![self kongge:lableName.text]) {
        [SVProgressHUD showAbnormalThenDismiss:@"请输入1到8位的昵称"];
    }else if (![self SureName:lableName.text]) {
        [SVProgressHUD showAbnormalThenDismiss:@"请输入1到8位的昵称"];
    }else if (![lablePress.text isEqualToString:lableTextPressWord.text]) {
        [SVProgressHUD showAbnormalThenDismiss:@"密码和确认密码不符"];
        
    }else if (!([lablePress.text length]>=6&&[lablePress.text length]<=12)) {
        [SVProgressHUD showAbnormalThenDismiss:@"密码长度在6到12位之间"];
        
    }else if (![self PressMima:lablePress.text]) {
        [SVProgressHUD showAbnormalThenDismiss:@"密码请输入字母或数字组合"];
        
    }else if(![self verificationEmail:lableTextEmail.text?lableTextEmail.text:@""])
    {
        [SVProgressHUD showAbnormalThenDismiss:@"邮箱格式不对"];
        
        
    }else if(![self checkTel:lableTextiphone.text])
    {
        [SVProgressHUD showAbnormalThenDismiss:@"手机号码格式错误"];
        
        
        
    }else{
        
        NSString *post = [NSString stringWithFormat:@"nickname=%@&passWord=%@&phone=%@&email=%@&usex=%@",lableName.text,lablePress.text,lableTextiphone.text,lableTextEmail.text,strsex];
        //将post数据转换为 NSASCIIStringEncoding 编码格式
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
        //要post的地址/
//        [request setURL:[NSURL URLWithString:@"http://119.44.220.4/register"]];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *url = [user objectForKey:@"url"]; 
        
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@register?",url]]];

        //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
        
        //post类型
        [request setHTTPMethod:@"POST"];
        
        
        
        //设置post数据
        [request setHTTPBody:postData];
        //创建链接
       NSURLConnection * conn = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
        
        [SVProgressHUD showInView:nil status:@"加载中......"];
        [self.view setUserInteractionEnabled:NO];

        
    }
    
}
-(void)handleTap:(UIGestureRecognizer *)gesture
{
    tap.enabled=NO;
    [UIView animateWithDuration:0.3f animations:^{
        [viewRegistered setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
  
    [lableTextPressWord resignFirstResponder];
    [lableTextiphone resignFirstResponder];
    [lableTextEmail resignFirstResponder];
    [lablePress resignFirstResponder];
    [lableName resignFirstResponder];

    
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
    [SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:YES];

  
        _string=[[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
    NSString *str=[_string substringWithRange:NSMakeRange(1, [_string length]-2)];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSArray *arrr=[[NSArray alloc]initWithObjects:str,@"111",@"0", nil];
    
    [userDefaults setObject:arrr forKey:@"yonghu"];
    [arrr release];
    NSString *str4=[NSString stringWithFormat:@"账号:%@",str];
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"注册成功，请牢记账号" message:str4 delegate:self cancelButtonTitle:@"开始登录" otherButtonTitles: nil];
        [av show];
//        [str release];
        [av release];


  }
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:YES];

    [SVProgressHUD showAbnormalThenDismiss:@"请检测网络"];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    [self surehiddle];
}
-(void)surehiddle
{

    [self.navigationController popViewControllerAnimated:YES];

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
-(void)dealloc
{
    [super dealloc];
    [lableName release];
    [lablePress release];
    [lableTextEmail release];
    [lableTextiphone release];
    [lableTextPressWord release];
    [_data release];
    [_string release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
