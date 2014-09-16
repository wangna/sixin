//
//  Chat1ViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-9-26.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "Chat1ViewController.h"
#import "SRWebSocket.h"
#import "ASIHTTPRequest.h"
#import "AsyncImageView.h"
#import "WebSocket.h"
@interface Chat1ViewController ()

@end

@implementation Chat1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//取消第一响应
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}
- (UIButton *)sendButton
{
    // Override to use a custom send button
    // The button's frame is set automatically for you
    return [UIButton defaultSendButton];
}
- (void)_reconnect:(NSString *)str;
{
    self.strUsid=str;
    _webSocket.delegate = nil;
    [_webSocket close];
    
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://172.16.11.6:3946"]]];
    _webSocket.delegate = self;
    
    //    self.title = @"Opening Connection...";
    [_webSocket open];
    
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
    if ([connection isEqual:conn]) {
 
    NSError *error;
    NSArray *arrjson= [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&error ];
    for (int i=0; i<[arrjson  count]; i++) {
//        NSDictionary * dictUIDMessage1 =[[NSDictionary alloc]initWithObjectsAndKeys:[[arrjson objectAtIndex:i] objectForKey:@"content"],@"Message",nil];
//        [self.arrayMessage addObject: dictUIDMessage1];
//        [dictUIDMessage1  release];
        [self sendPressedText:[[arrjson objectAtIndex:i] objectForKey:@"content"]];
    }
    }else{
//        NSString *str=[[NSString alloc]initWithData:_data encoding:nil];
//
//        NSLog(@"%@",str);
    
    
    
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
    NSString *str11=(NSString *)message;

    if ([str11 length]>90) {
        
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
        //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
        
        //post类型
        [request setHTTPMethod:@"POST"];
        
        
        
        //设置post数据
        [request setHTTPBody:postData];
        //创建链接
          conn = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
        
        
    }
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    //    self.title = @"Connection Closed! (see logs)";
    _webSocket = nil;
}
-(void)dealloc
{
    [super dealloc];
    [_data release];
    [_dictMessage release];
    [_messages release];
    [_timestamps release];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _data=[[NSMutableData alloc]init];
    _dictMessage=[[NSMutableDictionary alloc]init];
    index =0;
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.array= [userDefaults arrayForKey:@"person"];
    
    [self _reconnect:[[self.array objectAtIndex:0] objectForKey:@"UId"]];
    _arrayMessage=[[NSMutableArray alloc]init];

//    WebSocket *web=[[WebSocket alloc]init];
//    [web _reconnect:[[self.array objectAtIndex:0] objectForKey:@"UId"]];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome:) name:@"WebsocketMessage" object:nil];
    
    self.delegate = self;
    self.dataSource = self;
    
    self.title = @"Messages";
    
    _messages = [[NSMutableArray alloc] init];
    
    _timestamps = [[NSMutableArray alloc] initWithObjects:
                       [NSDate distantPast],
                       [NSDate distantPast],
                       [NSDate distantPast],
                       [NSDate date],
                       nil];
    NSDictionary *dict= [userDefaults dictionaryForKey: self.strfUsid];
        if (dict!=NULL) {
//            NSLog(@"%@",[dict objectForKey:@"Message"] );
            for (int i=0; i<[[dict objectForKey:@"Message"] count]; i++) {
                [self.messages addObject:[[dict objectForKey:@"Message"] objectAtIndex:i]];
                [self.timestamps addObject: [[dict objectForKey:@"Time"] objectAtIndex:i]];
            }
            [self finishSend];

    
        }

    
    
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                                                           target:self
                                                                                           action:@selector(buttonPressed:)] autorelease];
	// Do any additional setup after loading the view.
}
-(void)newMsgCome:(NSNotification *)notifacation
{
    
    NSLog(@"%wwwww=@",notifacation.object);
    //[WCMessageObject save:notifacation.object];
    NSString *str11=(NSString *)notifacation.object;
    
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
        //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
        
        //post类型
        [request setHTTPMethod:@"POST"];
        
        
        
        //设置post数据
        [request setHTTPBody:postData];
        //创建链接
        conn = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
        
        
    }
    

    
    
}

- (void)buttonPressed:(UIButton*)sender
{
    // Testing pushing/popping messages view
//    DemoViewController *vc = [[DemoViewController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}
- (void)sendPressedText:(NSString *)text

{
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:text,@"5",nil];
    [self.messages addObject:dict];
    [dict release];
    
    [self.timestamps addObject:[NSDate date]];
    NSDictionary *arrayJSON1=[[NSDictionary alloc]initWithObjectsAndKeys:self.messages
                              ,@"Message",self.timestamps,@"Time",nil];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:arrayJSON1 forKey:[NSString stringWithFormat:@"%@",self.strfUsid]];
    [arrayJSON1 release];
    //    if((self.messages.count - 1) % 2)
    //        [JSMessageSoundEffect playMessageSentSound];
    //    else
    //        [JSMessageSoundEffect playMessageReceivedSound];
    
    [self finishSend];
}

#pragma mark - Messages view delegate
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text

{
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:text,@"1",nil];
    [self.messages addObject:dict];
    [dict release];
    
    [self.timestamps addObject:[NSDate date]];
    NSDictionary *arrayJSON1=[[NSDictionary alloc]initWithObjectsAndKeys:self.messages,@"Message",self.timestamps,@"Time",nil];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:arrayJSON1 forKey:[NSString stringWithFormat:@"%@",self.strfUsid]];
//    NSDictionary *dict111= [userDefaults dictionaryForKey: self.strfUsid];
//    NSLog(@"www%@",[dict111 objectForKey:@"Message"]);

//    if((self.messages.count - 1) % 2)
//        [JSMessageSoundEffect playMessageSentSound];
//    else
//        [JSMessageSoundEffect playMessageReceivedSound];
    
    [self finishSend];
    NSString *post = [NSString stringWithFormat:@"UID=%@&message=%@&f_UID=%@",self.strUsid,text,self.strfUsid];
    //将post数据转换为 NSASCIIStringEncoding 编码格式
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //要post的地址/
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = [user objectForKey:@"url"];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilesendmessage?",url]]];
     
    //    [request setURL:[NSURL URLWithString:@"http://172.16.11.6/mobilelogin"]];
    
    //post类型
    [request setHTTPMethod:@"POST"];
    
    
    
    //设置post数据
    [request setHTTPBody:postData];
    //创建链接
    conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];

}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return (indexPath.row % 2) ? JSBubbleMessageTypeIncoming : JSBubbleMessageTypeOutgoing;
    if ([[[[self.messages objectAtIndex:indexPath.row] allKeys] objectAtIndex:0] intValue]==1) {
        return JSBubbleMessageTypeIncoming;
    }
    return JSBubbleMessageTypeOutgoing;
}

- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JSBubbleMessageStyleSquare;
}

- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    return JSMessagesViewTimestampPolicyEveryThree;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy
{
    return JSMessagesViewAvatarPolicyBoth;
}

- (JSAvatarStyle)avatarStyle
{
    return JSAvatarStyleSquare;
}

//  Optional delegate method
//  Required if using `JSMessagesViewTimestampPolicyCustom`
//
//  - (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
//

#pragma mark - Messages view data source
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [[self.messages objectAtIndex:indexPath.row]objectForKey: [[[self.messages objectAtIndex:indexPath.row] allKeys] objectAtIndex:0]] ;
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.timestamps objectAtIndex:indexPath.row];

//    return 111;
}

- (UIImage *)avatarImageForIncomingMessage
{
    AsyncImageView * contentPic = [[[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 33, 33)] autorelease];
    contentPic.urlString = [NSString stringWithFormat:@"http://172.16.11.6/TSSP_FILE/HeadPic/%@",[[self.array objectAtIndex:0]objectForKey:@"m_avatar"]];;
    
    
    //    return [UIImage imageNamed:@"demo-avatar-jobs"];
    return contentPic.image;}

- (UIImage *)avatarImageForOutgoingMessage
{
    AsyncImageView * contentPic = [[[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 33, 33)] autorelease];
    contentPic.urlString = [NSString stringWithFormat:@"http://172.16.11.6/TSSP_FILE/HeadPic/%@",self.strfPic];;
    

//    return [UIImage imageNamed:@"demo-avatar-jobs"];
    return contentPic.image;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
