//
//  ChatViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-9-24.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "ChatViewController.h"
#import "SRWebSocket.h"
#import "ASIHTTPRequest.h"
#import "AsyncImageView.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    

 

}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    
}
#pragma mark ---触摸关闭键盘----
-(void)handleTap:(UIGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}


-(void)newMsgCome1:(NSString *)string
    {
        
        //[WCMessageObject save:notifacation.object];
        NSString *str11=(NSString *)string;
        
        if ([str11 length]>60) {
            
            NSArray *arr123=[str11 componentsSeparatedByString:@"["];
            arr123=[[arr123 objectAtIndex:3] componentsSeparatedByString:@"]"];
            arr123=[[arr123 objectAtIndex:0] componentsSeparatedByString:@"}"];
            NSLog(@"%d",[arr123 count]);
            for (int i=0; i<[arr123 count]-1; i++) {
                
                
                [self.dictMessage setObject:[[[[arr123 objectAtIndex:i] componentsSeparatedByString:@"\""] objectAtIndex:6] stringByReplacingOccurrencesOfString:@":" withString:@""] forKey: [[[arr123 objectAtIndex:i] componentsSeparatedByString:@"\""] objectAtIndex:3]];
            }
        }
        
        if ([[self.dictMessage allKeys] containsObject:self.strfUsid]) {
            NSString *post = [NSString stringWithFormat:@"UID=%@&f_UID=%@",self.strUsid,self.strfUsid];
            //将post数据转换为 NSASCIIStringEncoding 编码格式
            NSLog(@"%@",post);
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            //要post的地址/
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *url = [user objectForKey:@"url"];
            
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilegetnewmessage?",url]]];
            
//            [request setURL:[NSURL URLWithString:@"http://119.44.220.4/mobilegetnewmessage"]];
            //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
            
            //post类型
            [request setHTTPMethod:@"POST"];
            
            
            
            //设置post数据
            [request setHTTPBody:postData];
            //创建链接
          NSURLConnection *  conn = [[NSURLConnection alloc] initWithRequest:request delegate:self] ;
            
            
        }
        
        
        
        
    }
    
    
    

-(void)dealloc
{
    [super dealloc];
    [_data release];
    [_dictMessage release];
    [_arrayMessage release];
    [viewl release];
    [textFild release];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _data=[[NSMutableData alloc]init];
    _dictMessage=[[NSMutableDictionary alloc]init];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.array= [userDefaults arrayForKey:@"person"];
    [self _reconnect:[[self.array objectAtIndex:0] objectForKey:@"UId"]];
    _arrayMessage=[[NSMutableArray alloc]init];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,320,self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor blackColor];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [_tableView addGestureRecognizer:tap];
    [tap release];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome:) name:@"Message" object:nil];

//    FaceToolBar* bar=[[FaceToolBar alloc]initWithFrame:CGRectMake(0.0f,self.view.frame.size.height - toolBarHeight,self.view.frame.size.width,toolBarHeight) superView:self.view];
//    bar.delegate=self;
//    [self.view addSubview:bar];
//    [bar release];
    
    viewl=[[UIView alloc]initWithFrame:CGRectMake(0, 377, 320, 40)];
    [viewl setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:viewl];
    UIImageView *imageliao=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    imageliao.image=[UIImage imageNamed:@"聊天.png"];
    [viewl addSubview:imageliao];
    [imageliao release];
    textFild=[[UITextField alloc]initWithFrame:CGRectMake(38,6, 210, 28)];
    textFild.delegate=self;
    [textFild setBorderStyle:UITextBorderStyleRoundedRect];
    [textFild setBackgroundColor:[UIColor whiteColor]];
    [viewl addSubview:textFild];
//    [textFild release];
	// Do any additional setup after loading the view.
}
-(void)ReceiveMessage:(id)message
{
    NSLog(@"hhhhhhhhh");
    NSLog(@"wwww___________Received %@",message);

}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyBord];
}
-(void)dismissKeyBord
{
    [textFild resignFirstResponder];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:0.2];
   
        viewl.frame = CGRectMake(0, 377, 320, 40);
 
    [UIView commitAnimations];
}
-(void)sendTextAction:(NSString *)inputText{
    NSLog(@"sendTextAction%@",inputText);
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    viewl.frame = CGRectMake(0,165, 320, 40);
    [UIView commitAnimations];


}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"HH:mm"];
//    NSString * locationString=[dateformatter stringFromDate:senddate];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSString * morelocationString=[dateformatter stringFromDate:senddate];
   NSDictionary * dictUIDMessage1 =[[NSDictionary alloc]initWithObjectsAndKeys:[[self.array objectAtIndex:0]objectForKey:@"m_avatar"],@"m_avatar",textField.text,@"Message",morelocationString,@"senddate", nil];
    [self.arrayMessage addObject: dictUIDMessage1];
//    [self.arrayMessage addObject:@"你好，有事请留言"];
    [_tableView  reloadData];
    textField.text=@"";
    [dictUIDMessage1  release];
    [dateformatter release];
    return YES;
}
-(CGFloat)getHeight:(NSString *) str

{
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    
    
    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(200,3500)lineBreakMode:NSLineBreakByCharWrapping];
    
    //这里的10为字符的上下边距，可以自行设计
    
    return size.height+10;
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
//     NSLog(@"2222");
  

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.arrayMessage count];
    
    
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return [self.headViewArray count];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [self getHeight:[[self.arrayMessage objectAtIndex:indexPath.row]objectForKey:@"Message"]]+23;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier] autorelease];

        
    }
    
    [cell.contentView  addSubview:[self loadcell:nil MessAge:indexPath.row Cellimage:nil]];
    
    return cell;
}
-(UIView *)loadcell:(NSString *)cellname MessAge:(int)index Cellimage:(UIImage *)cellImage
{
    
    UIView *cellView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44 )] autorelease];
    
//    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 33, 33)];
//    image1.image=[UIImage imageNamed:@"meinv2.jpg"];
//    [cellView addSubview:image1];
//    [image1 release];
//    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 10, 15, 30)];
//    image2.image=[UIImage imageNamed:@"UpAccessory@2x.png"];
//    [cellView addSubview:image2];
//    [image2 release];
//    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 200, 20)];
//    [lable setBackgroundColor:[UIColor clearColor]];
//    [lable setTextColor:[UIColor blackColor]];
//    lable.text=[NSString stringWithFormat:@"美女"];
//    [lable setTextAlignment:NSTextAlignmentLeft];
//    [cellView addSubview:lable];
//    [lable  release];
    
//    NSLog(@"%f",[self getHeight:[self.arrayMessage objectAtIndex:index]]);
    UILabel *lable11=[[UILabel alloc]initWithFrame:CGRectMake(60, 2, 200, [self getHeight:[[self.arrayMessage objectAtIndex:index]objectForKey:@"Message"]])];
    [lable11 setBackgroundColor:[UIColor clearColor]];
    [lable11 setTextColor:[UIColor blackColor]];
    [lable11 setFont:[UIFont systemFontOfSize:15]];
    [lable11 setLineBreakMode:NSLineBreakByCharWrapping];
    lable11.numberOfLines=0;
    lable11.text=[NSString stringWithFormat:@"%@",[[self.arrayMessage objectAtIndex:index] objectForKey:@"Message"]];
    [lable11 setTextAlignment:NSTextAlignmentLeft];
    [cellView addSubview:lable11];
    [lable11  release];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(30, 8+lable11.frame.size.height, 200, 20)];
    [lable setBackgroundColor:[UIColor clearColor]];
    [lable setTextColor:[UIColor blackColor]];
    lable.text=[NSString stringWithFormat:@"%@",[[self.arrayMessage objectAtIndex:index] objectForKey:@"senddate"]];
    [lable setTextAlignment:NSTextAlignmentLeft];
    [cellView addSubview:lable];
    [lable  release];
    
    AsyncImageView * contentPic = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 33, 33)];
    contentPic.urlString = [NSString stringWithFormat:@"http://172.16.11.6/TSSP_FILE/HeadPic/%@",[[self.arrayMessage objectAtIndex:index] objectForKey:@"m_avatar"]];;
    
    [cellView addSubview:contentPic];
    [contentPic release];
    return cellView;
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self dismissKeyBord];

}
- (void)_reconnect:(NSString *)str;
{
//    self.strUsid=str;
//    _webSocket.delegate = nil;
//    [_webSocket close];
//    
//    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://172.16.11.6:3946"]]];
//    _webSocket.delegate = self;
//    
//    //    self.title = @"Opening Connection...";
//    [_webSocket open];
    
}


#pragma mark -connect
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"hhh=%@",data);
    [_data appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSError *error;
   NSArray *arrjson= [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&error ];
    for (int i=0; i<[arrjson  count]; i++) {
      NSDictionary * dictUIDMessage1 =[[NSDictionary alloc]initWithObjectsAndKeys:self.strfPic,@"m_avatar",[[arrjson objectAtIndex:i] objectForKey:@"content"],@"Message",[[arrjson objectAtIndex:i] objectForKey:@"senddate"] ,@"senddate",nil];
        [self.arrayMessage addObject: dictUIDMessage1];
        [dictUIDMessage1  release];
    }
 

    }
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

    NSLog(@"%@",error);
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    //    self.title = @"Connected!";
    //    NSLog(@"%@",[NSString stringWithFormat:@"mobile,%@",[[self.arrayJSON objectAtIndex:0] objectForKey:@"UId"]]);
    [_webSocket  send:[NSString stringWithFormat:@"mobile,%@",self.strUsid]];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    //    self.title = @"Connection Failed! (see logs)";
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"Received %@", message);
    NSString *str11=(NSString *)message;
//    [delegate ReceiveMessage:message];
//    NSArray *array11=[str11 stringArrayForKey:@"[{"];
//    NSLog(@"%@",[str11 objectForKey:@"parameters"]);
    if ([str11 length]>60) {
   
    NSArray *arr123=[str11 componentsSeparatedByString:@"["];
    arr123=[[arr123 objectAtIndex:3] componentsSeparatedByString:@"]"];
    arr123=[[arr123 objectAtIndex:0] componentsSeparatedByString:@"}"];
    NSLog(@"%d",[arr123 count]);
    for (int i=0; i<[arr123 count]-1; i++) {
        
   
        [self.dictMessage setObject:[[[[arr123 objectAtIndex:i] componentsSeparatedByString:@"\""] objectAtIndex:6] stringByReplacingOccurrencesOfString:@":" withString:@""] forKey: [[[arr123 objectAtIndex:i] componentsSeparatedByString:@"\""] objectAtIndex:3]];
    }
    }
    
    if ([[self.dictMessage allKeys] containsObject:self.strfUsid]) {
        NSString *post = [NSString stringWithFormat:@"UID=%@&f_UID=%@",self.strUsid,self.strfUsid];
        //将post数据转换为 NSASCIIStringEncoding 编码格式
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        //要post的地址/
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *url = [user objectForKey:@"url"]; 
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilegetnewmessage?",url]]];
        
//        [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilegetnewmessage"]];
        //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
        
        //post类型
        [request setHTTPMethod:@"POST"];
        
        
        
        //设置post数据
        [request setHTTPBody:postData];
        //创建链接
        NSURLConnection *  conn = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
        [request release];

    }
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    //    self.title = @"Connection Closed! (see logs)";
    _webSocket = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
