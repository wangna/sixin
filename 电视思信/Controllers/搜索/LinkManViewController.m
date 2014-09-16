//
//  LinkManViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-9-22.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "LinkManViewController.h"
#import "rootViewController.h"
#import "AsyncImageView.h"
#import "WebSocket.h"
#import "SBJsonParser.h"
#import "AddFriengViewController.h"
#import "ChatIngController.h"
#import "ChineseToPinyin.h"
#import "MessageViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Reachability.h"
#import "FriengList.h"
@interface LinkManViewController ()

@end

@implementation LinkManViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}



- (void)_reconnect:(NSString *)str;
{
    self.strUID=str;
    _webSocket.delegate = nil;
    [_webSocket close];

    if (_webSocket!=nil) {
        [_webSocket release];
    }
    
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://119.44.220.4:3946"]]];
//    NSLog(@"sssss=%@",[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"ws://%@:3946",HTTPHEAD]]]);
    _webSocket.delegate = self;
    
    //    self.title = @"Opening Connection...";
    [_webSocket open];
    
}
#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    //    self.title = @"Connected!";
    [_webSocket  send:[NSString stringWithFormat:@"mobile,%@",self.strUID]];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    //    self.title = @"Connection Failed! (see logs)";
//    _webSocket = nil;
//    [self _reconnect:self.strUID];

}
-(void)playMusic
{
    
    
    
    NSString *thesoundFilePath = [[NSBundle mainBundle] pathForResource:@"Clapping Crowd Studio 01" ofType:@"caf"];    //创建音乐文件路径
    CFURLRef thesoundURL = (CFURLRef) [NSURL fileURLWithPath:thesoundFilePath];
    AudioServicesCreateSystemSoundID(thesoundURL, nil);
    

}
-(void)VIewHiddle
{
    UIWindow *win=[UIApplication sharedApplication].keyWindow;

    UILabel *lableti=(UILabel *)[win viewWithTag:456];
    [lableti removeFromSuperview]; 
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
 
    NSLog(@"message=%@",message);
//   2013-10-25 10:48:16.659 电视微信[3756:60b] str11=[{"count":0,"command":"1","newfriendname":"cshi_001","requestCount":5,"type":"1"}]
    
//2013-10-25 10:51:29.440 电视微信[3756:60b] str11=[{"newMsgName":"123","count":1,"command":"1","newMsgType":"[文字]","newfriendname":"cshi_013","parameters":[{"uid":"18352","size":1}],"requestCount":7,"type":"1"}]
    NSString *str11=(NSString *)message;
    SBJsonParser *apr=[[SBJsonParser alloc]init] ;
    NSArray *dict=[apr objectWithString:str11];
    [apr release];
//    NSLog(@"str11=%@",dict);
    if ([[[dict objectAtIndex:0] objectForKey:@"type"] intValue]==2) {
        UILabel *labletishi=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
        labletishi.tag=456;
        //            labletishi.opaque=YES;
        
        labletishi.layer.cornerRadius = 10.0f;
        [labletishi setBackgroundColor:[UIColor blackColor]];
        [labletishi setText:@"账号在其他客户端登录"];
        labletishi.center=self.view.center;
        [labletishi setTextColor:[UIColor whiteColor]];
        [labletishi setTextAlignment:NSTextAlignmentCenter];
        UIWindow *win=[UIApplication sharedApplication].keyWindow;
        [win addSubview:labletishi];
        [labletishi release];
        [self performSelector:@selector(VIewHiddle) withObject:self afterDelay:1.0];
    }else{
     
    if ([[[dict objectAtIndex:0] objectForKey:@"count"] intValue]!=0) {
        AudioServicesPlaySystemSound(1106);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Message" object:message ];
   

        for (int i=0; i<[[[dict objectAtIndex:0] objectForKey:@"parameters"] count]; i++) {
            arryCell *aaaa=[[arryCell alloc]init];
            NSDate * senddate=[NSDate date];
            NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSString * morelocationString=[[dateformatter stringFromDate:senddate] retain];
            aaaa.Time1=morelocationString;
            aaaa.uid=self.strUID;
            aaaa.fuid=[[[[dict objectAtIndex:0] objectForKey:@"parameters"] objectAtIndex:i] objectForKey:@"uid"];
            aaaa.description=[[[[dict objectAtIndex:0] objectForKey:@"parameters"] objectAtIndex:i] objectForKey:@"size"];

            [db createDataBase1];
            [db updateOperationInfoQuestionIDSize:aaaa];
            [dateformatter release];
            [aaaa release];
        
        
        }
        

        self.dictMessage=[db findMessageAll:self.strUID];
        [self tabarSmallScale];
        
        [_tableView reloadData];
        

    }
   
   
      
        if ([[[dict objectAtIndex:0] objectForKey:@"requestCount"] intValue]!=0) {
            AudioServicesPlaySystemSound(1106);

            NSString *post = [NSString stringWithFormat:@"UID=%@",self.strUID];
//            NSLog(@"%@",post);
            //将post数据转换为 NSASCIIStringEncoding 编码格式
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            
            NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
            //要post的地址/
//            [request setURL:[NSURL URLWithString:@"http://119.44.220.4/mobilegetrequest"]];
            //要post的地址/
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *url = [user objectForKey:@"url"];
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilegetrequest?",url]]];

            //    [request setURL:[NSURL URLWithString:@"http://172.16.4.5:8080/TSSP/mobilelogin"]];
            
            //post类型
            [request setHTTPMethod:@"POST"];
            
            
            
            //设置post数据
            [request setHTTPBody:postData];
            //创建链接
           NSURLConnection * conn1 = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
//            [request  release];
        }
    
    
    
//    for (int i=0; i<[self.dictMessage count]; i++) {
//        arryCell *aaa=[self.dictMessage objectAtIndex:i];
//        NSLog(@"xxxxx=%@  %@",aaa.uid,aaa.mixPic);
//    }

    }
    
}
-(void)tabarSmallScale
{
    
    [db createDataBase1];
    int max=[db findSizeAll:self.strUID];
//    NSLog(@"wwww%d",max);
    if (max==0) {
        self.navigationController.tabBarItem.badgeValue=nil;
    }else{
    
        self.navigationController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",max];
    
    }

    
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    //    self.title = @"Connection Closed! (see logs)";
//    _webSocket = nil;
    [_webSocket release];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setText:@""];
    [searchBar setShowsCancelButton:YES];
    for (UIView *searchbuttons in mySearchBar.subviews)
    {
        if ([searchbuttons isKindOfClass:[UIButton class]])
        {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            cancelButton.enabled = YES;
            //            [cancelButton setBackgroundImage:[UIImage imageNamed:@"search_bg.png"] forState:UIControlStateNormal];//背景
            [cancelButton setTitle:@"取消"  forState:UIControlStateNormal];//文字
            break;
        }
    }

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
}




- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    NSLog(@"textChange");
    if (_searchArray != nil) {
        [_searchArray removeAllObjects];
    }
    if ([searchText length]!=0) {
        [self findData:searchText];

    }
}
-(void)findData:(NSString *)str11
{
  NSString *str= [ChineseToPinyin pinyinFromChiniseString:str11];
    
    for (int i=0; i<[[self.array allKeys] count]; i++) {
        
        NSRange  rang=[[ChineseToPinyin pinyinFromChiniseString: [[self.array objectForKey:[[self.array allKeys] objectAtIndex:i]] objectForKey:@"f_userId" ]] rangeOfString:str];
        NSRange  rang1=[[ChineseToPinyin pinyinFromChiniseString: [[self.array objectForKey:[[self.array allKeys] objectAtIndex:i]] objectForKey:@"f_nickname" ]] rangeOfString:str];
        NSRange  rang2=[[ChineseToPinyin pinyinFromChiniseString: [[self.array objectForKey:[[self.array allKeys] objectAtIndex:i]] objectForKey:@"nickname" ]] rangeOfString:str];
        
        if (rang.length!=0) {
            [_searchArray addObject:[self.array objectForKey:[[self.array allKeys] objectAtIndex:i]]];
            continue;
        
        }
        if (rang1.length!=0) {
            [_searchArray addObject:[self.array objectForKey:[[self.array allKeys] objectAtIndex:i]]];
            continue;
        }
        if (rang2.length!=0) {
            [_searchArray addObject:[self.array objectForKey:[[self.array allKeys] objectAtIndex:i]]];
            continue;
        }

            }
}
-(void)LinkManViewMessage:(id)message
{
    [db createDataBase1];
    self.dictMessage=[db findMessageAll:self.strUID];
    [self tabarSmallScale];
    [_tableView reloadData];

}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.035 green:0.117 blue:0.184 alpha:0.286];
//    self.navigationController.navigationBar.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"蓝条.png"]];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.array= [userDefaults dictionaryForKey:@"personF_Uid"];
    [db createDataBase1];
    self.dictMessage=[db findMessageAll:self.strUID];
    [self tabarSmallScale];
    self.array= [userDefaults dictionaryForKey:@"personF_Uid"];
    self.strUID= [[self.array objectForKey:[[self.array allKeys] objectAtIndex:0]]objectForKey:@"UId"];

    

    [_tableView reloadData];
    

    
    
    

}
-(void)dealloc
{
    [super dealloc];
    _webSocket.delegate = nil;
    [_webSocket close];
    [_webSocket release];
    [_data release];
//    [_dictMessage release];
    [_tableView release];
    [db release];
 
    _faceMap=nil;
    _faceMessage=nil;
    [_searchArray release];
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navigationController.navigationBar setHidden:YES];
    db=[[SUserDB alloc]init];
    _data=[[NSMutableData alloc]init];
    _faceMap = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_en" ofType:@"plist"]]retain];
    _faceMessage = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_ch" ofType:@"plist"]]retain];
//    _dictMessage =[[NSMutableDictionary alloc]init];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.array= [userDefaults dictionaryForKey:@"personF_Uid"];
        self.strUID= [[self.array objectForKey:[[self.array allKeys] objectAtIndex:0]]objectForKey:@"UId"];

    self.navigationItem.title=@"消息";
//    friend=[[FriengList alloc]init];
    
    _searchArray=[[NSMutableArray alloc]init];
   _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0,320,self.view.frame.size.height-90) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [_tableView setClipsToBounds:YES];
//    [_tableView setBounces:NO];

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

//    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    //    [_itemPoolTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"木纹背景.png"]]];
//    [_tableView setShowsVerticalScrollIndicator:NO];
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] ;
    [mySearchBar setAutocorrectionType:UITextAutocorrectionTypeNo];

    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar setTintColor:[UIColor colorWithRed:0.83 green:0.82 blue:0.82 alpha:0.8]];
    [mySearchBar setKeyboardType:UIKeyboardTypeDefault];
    [mySearchBar setDelegate:self];
    [mySearchBar setTag:600];
    searchDC = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self]  ;
    [searchDC setSearchResultsDataSource:self];
    [searchDC setSearchResultsDelegate:self];
    [searchDC setDelegate:self];
        _tableView.tableHeaderView = mySearchBar;
    [self.view addSubview:_tableView];
    [self _reconnect:self.strUID];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome1:) name:@"Conect" object:nil];

	// Do any additional setup after loading the view.
}
-(void)newMsgCome1:(NSNotification *)notifacation
{
    
    [self _reconnect:self.strUID];


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
    NSArray *arrjson= [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&error ];

    for (int i=0; i<[arrjson  count]; i++) {
        arryCell *aaaa=[[arryCell alloc]init];
        NSDate * senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString * morelocationString=[dateformatter stringFromDate:senddate] ;
        aaaa.Time1=[NSString stringWithFormat:@"%@",morelocationString];
        aaaa.uid=self.strUID;
        aaaa.fuid=[[arrjson objectAtIndex:i] objectForKey:@"RID"];
        aaaa.description=[NSString stringWithFormat:@"1"];
        aaaa.Midea=[[arrjson objectAtIndex:i] objectForKey:@"nickname"];;
        [db createDataBase1];
        [db updateOperationInfoQuestionIDSize:aaaa];
        [dateformatter release];
        [aaaa release];

        
    }
    self.dictMessage=[db findMessageAll:self.strUID];
    [self tabarSmallScale];
    [_tableView reloadData];

}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"%@",error);
}

#pragma mark - TableViewdelegate&&TableViewdataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 45;
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==_tableView) {
          return YES;
    }else{
    
        return NO;
    }
  
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        arryCell *aaa=[self.dictMessage objectAtIndex:indexPath.row];
        [db deleteUserId:aaa.fuid UserId:self.strUID];
        [self.dictMessage removeObjectAtIndex:indexPath.row];
        [self tabarSmallScale];
        // Delete the row from the data source.
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
        
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView==_tableView) {
        return [self.dictMessage count];

    }else{
    
        return [_searchArray count];
    
    
    }
    
    
    
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
        UIButton* backBtn=  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        backBtn.tag = 20000;
        [backBtn setBackgroundImage:[UIImage imageNamed:@"listitem.png"] forState:UIControlStateHighlighted];
        backBtn.userInteractionEnabled = NO;
        [cell.contentView addSubview:backBtn];
        [backBtn release];
        
        
     
        
    }

    if (tableView==_tableView) {
        for (UIView *vvv in cell.contentView.subviews) {
            if ([vvv isKindOfClass:[UILabel class]]) {
                [vvv removeFromSuperview];
                
            }
            if ([vvv isKindOfClass:[AsyncImageView class]]) {
                [vvv removeFromSuperview];
                
            }
        if ([vvv isKindOfClass:[UIView class]]) {
            [vvv removeFromSuperview];
            
        }
        
            
        }
       

    [cell.contentView addSubview:[self loadcell:nil Cellimage:nil IndenRow:indexPath.row]];
        UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 59, 320, 1)];
        line.backgroundColor = [UIColor colorWithRed:0.83 green:0.82 blue:0.82 alpha:0.8];
        [cell.contentView addSubview:line];
        [line release];
    
    

    }else{
        for (UIView *vvv in cell.contentView.subviews) {
            if ([vvv isKindOfClass:[UILabel class]]) {
                [vvv removeFromSuperview];
                
            }
            if ([vvv isKindOfClass:[AsyncImageView class]]) {
                [vvv removeFromSuperview];
                
            }
            if ([vvv isKindOfClass:[UIView class]]) {
                [vvv removeFromSuperview];
                
            }
            
            
        }
        
        [db createDataBase1];
       arryCell *acc= [db findUserId:[[_searchArray objectAtIndex:indexPath.row] objectForKey:@"f_UId"] UserId:self.strUID];
        if ([acc.fuid length]!=0) {

            [cell.contentView addSubview:[self loadcel2:acc]];

        }else{

            [cell.contentView addSubview:[self loadcell1:nil Cellimage:nil IndenRow:indexPath.row]];

        
        }

    
    }
    
    //    cell.textLabel.text = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    //    cell.textLabel.backgroundColor = [UIColor clearColor];
    //    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}
-(UIView *)jiequ:(NSString *)inputText
{
    int jiequTndex=0;
    NSMutableArray *array1=[[[NSMutableArray alloc]init] autorelease];
    for (int i=0; i<[inputText length]; i++) {
        
        if (index==0) {
            jiequTndex=i;
            index=1;
        }
        NSString *temp = [inputText substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"["]&&[self buOtherName:inputText Index:i]) {
            ;
            if (jiequTndex!=i) {
                [array1 addObject:[inputText substringWithRange:NSMakeRange(jiequTndex, i-jiequTndex)]];
                
            }
            [array1 addObject:[self buOtherName1:inputText Index:i]];
            i=i+[[self buOtherName1:inputText Index:i] length]-1;
            index=0;
            
        }else {
            if (i==inputText.length-1) {
                [array1 addObject:[inputText substringWithRange:NSMakeRange(jiequTndex, i-jiequTndex+1)]];
            }
        }
    }
    return [self assembleMessageAtIndex:array1];
    
}
-(NSString *)buOtherName1:(NSString *)str Index :(int)indexType
{
    for (int i=0; i<[_faceMessage count]; i++) {
        if ([str length]-indexType>2) {
            
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 3)]]) {
                return [str substringWithRange:NSMakeRange(indexType, 3)];
            }
        }
        if ([str length]-indexType>3) {
            
            
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 4)]]) {
                return [str substringWithRange:NSMakeRange(indexType, 4)];
            }
        }
        if ([str length]-indexType>4) {
            
            
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 5)]]) {
                return [str substringWithRange:NSMakeRange(indexType, 5)];
            }
        }
    }
    
    return nil;
    
}

-(UIView *)assembleMessageAtIndex:(NSArray *)arr
{
    
    UIView *returnView = [[[UIView alloc] init] autorelease]  ;
    
    NSArray *data = [[NSArray alloc]initWithArray:arr] ;
    UIFont *fon= [UIFont systemFontOfSize:16];
	CGFloat upX=0;
    CGFloat upY=0;
	if (data) {
		for (int i=0;i<[data count];i++) {
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"]&&[self bubbleBg:str])
            {
//                if (upX > 206)
//                {
//                    upY = upY + 17+3;
//                    upX = 0;
//                }
				NSString *yaoxi=[str substringWithRange:NSMakeRange(0, str.length)];
                NSString * imageName=[self bubbleBgName:yaoxi];
				UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString  stringWithFormat:@"%@.png",imageName]]];
                img.frame = CGRectMake(upX, upY, 19, 20);
                [returnView addSubview:img];
                [img release];
				upX=17+upX+3;
                
			}else
            {
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
//                    if (upX > 206)
//                    {
//                        upY = upY + 17+3;
//                        upX = 0;
//                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(206, 20)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    la.backgroundColor=[UIColor clearColor];
                    [la setTextColor:[UIColor colorWithRed:0.63 green:0.62 blue:0.62 alpha:0.9]];
                    la.font = fon;
                    la.text = temp;
                    [returnView addSubview:la];
                    [la release];
                    upX=upX+size.width;
                }
			}
        }
	}
//    if (upY>0) {
    returnView.clipsToBounds=YES;
        [returnView setFrame:CGRectMake(0, 0, 213, upY+17+3)];
        
//    }else{
//        [returnView setFrame:CGRectMake(0, 0, upX, upY+17+3)];
//    }
    [data release];
    return returnView;
}
-(BOOL)bubbleBg:(NSString *)bubbleStr
{
    for (int i=0; i<[[_faceMessage allKeys] count]; i++) {
        if ([[_faceMessage objectForKey:[[_faceMap allKeys] objectAtIndex:i] ] isEqualToString:bubbleStr]) {
            return YES;
            
        }
    }
    
    return NO;
    
    
    
}
-(NSString *)bubbleBgName:(NSString *)bubbleStr
{
    NSString *str=nil;
    for (int i=0; i<[[_faceMessage allKeys] count]; i++) {
        if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i] ] isEqualToString:bubbleStr]) {
            str=[_faceMap objectForKey: [[_faceMessage allKeys] objectAtIndex:i] ];
            return str;
        }
    }
    
    return NO;
    
    
    
}

-(BOOL)buOtherName:(NSString *)str Index :(int)indexType
{
    for (int i=0; i<[_faceMessage count]; i++) {
        if ([str length]-indexType>2) {
            
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 3)]]) {
                return YES;
            }
        }
        if ([str length]-indexType>3) {
            
            
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 4)]]) {
                return YES;
            }
        }
        if ([str length]-indexType>4) {
            
            
            if ([[_faceMessage objectForKey:[[_faceMessage allKeys] objectAtIndex:i]] isEqualToString:[str substringWithRange:NSMakeRange(indexType, 5)]]) {
                return YES;
            }
        }
    }
    
    return NO;
    
}

-(UIView *)loadcell:(NSString *)cellname Cellimage:(UIImage *)cellImage IndenRow:(int)i
{
    
    
    UIView *cellView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 59 )]autorelease];



 
    arryCell *assCell=[self.dictMessage objectAtIndex:i];
    if ([assCell.description intValue]!=0) {
        if ([assCell.Midea length]==0) {
//            NSLog(@"%@   %@",[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"],[[self.array objectForKey:assCell.fuid] objectForKey:@"nickname"]);

        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(70, 8, 100, 25)];
        [lable setBackgroundColor:[UIColor clearColor]];
        [lable setTextColor:[UIColor blackColor]];
            [lable setFont:[UIFont systemFontOfSize:18]];

        if ([[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"] length]!=0) {
            lable.text=[NSString stringWithFormat:@"%@",[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"]];

        }else{
        
            lable.text=[NSString stringWithFormat:@"%@",[[self.array objectForKey:assCell.fuid] objectForKey:@"nickname"]];

        }
        [lable setTextAlignment:NSTextAlignmentLeft];
        [cellView addSubview:lable];
        [lable  release];
        
        AsyncImageView * contentPic = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,[[self.array objectForKey:assCell.fuid] objectForKey:@"avatar"]];;
        
        [cellView addSubview:contentPic];
        [contentPic release];
        UIImageView * image12=[[UIImageView alloc]initWithFrame:CGRectMake(40, -5, 30, 30)];
        image12.image=[UIImage imageNamed:@"tabbar_badge@2x.png"] ;
        [cellView addSubview:image12];
            
        UILabel*lablescale1=[[UILabel alloc]initWithFrame:CGRectMake(3, 4, 25, 25)];
        lablescale1.tag=3000+i;
        [lablescale1 setBackgroundColor:[UIColor clearColor]];
        [lablescale1 setTextColor:[UIColor  blackColor]];
        [lablescale1 setFont:[UIFont systemFontOfSize:12]];
        [lablescale1 setTextAlignment:NSTextAlignmentCenter];
        [lablescale1 setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        lablescale1.text=assCell.description;
        [image12  addSubview:lablescale1];
        [image12 release];
        [lablescale1 release];
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(70, 35, 200, 20)];
            [view  addSubview:[self jiequ:assCell.Message]];
            [view setBackgroundColor:[UIColor  clearColor]];
        [cellView addSubview:view];
            [view release];

        }else{
        
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(70, 8, 100, 25)];
            [lable setBackgroundColor:[UIColor clearColor]];
            [lable setTextColor:[UIColor blackColor]];
            [lable setFont:[UIFont systemFontOfSize:18]];

                lable.text=@"添加好友";
          
            [lable setTextAlignment:NSTextAlignmentLeft];
            [cellView addSubview:lable];
            [lable  release];
            
            UIImageView * contentPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
            contentPic.image=[UIImage imageNamed:@"Icon.png"];
            [cellView addSubview:contentPic];
            [contentPic release];
            UIImageView * image12=[[UIImageView alloc]initWithFrame:CGRectMake(40, -5, 30, 30)];
            image12.image=[UIImage imageNamed:@"tabbar_badge@2x.png"] ;
            [cellView addSubview:image12];
            UILabel*lablescale1=[[UILabel alloc]initWithFrame:CGRectMake(3, 4, 25, 25)];
            lablescale1.tag=3000+i;
            [lablescale1 setBackgroundColor:[UIColor clearColor]];
            [lablescale1 setTextColor:[UIColor  blackColor]];
            [lablescale1 setFont:[UIFont systemFontOfSize:12]];
            [lablescale1 setTextAlignment:NSTextAlignmentCenter];
            [lablescale1 setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
            lablescale1.text=@"";
            [image12  addSubview:lablescale1];
            [image12 release];
            [lablescale1 release];
            
            UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(70, 35, 100, 20)];
            [lable1 setBackgroundColor:[UIColor clearColor]];
            [lable1 setTextColor:[UIColor blackColor]];
            
            lable1.text=assCell.Midea;
            
            [lable1 setTextAlignment:NSTextAlignmentLeft];
            [cellView addSubview:lable1];
            [lable1  release];
        
        }
    }else{
    
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(70,8, 200, 20)];
        [lable setBackgroundColor:[UIColor clearColor]];
        [lable setTextColor:[UIColor blackColor]];
        [lable setFont:[UIFont systemFontOfSize:18]];
//        NSLog(@"%@   %@",[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"],[[self.array objectForKey:assCell.fuid] objectForKey:@"nickname"]);
 
        if ([[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"] length]!=0) {
            lable.text=[NSString stringWithFormat:@"%@",[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"]];
            
        }else{
            
            lable.text=[NSString stringWithFormat:@"%@",[[self.array objectForKey:assCell.fuid] objectForKey:@"nickname"]];
            
        }
        [lable setTextAlignment:NSTextAlignmentLeft];
        [cellView addSubview:lable];
        [lable  release];

        
        AsyncImageView * contentPic = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,[[self.array objectForKey:assCell.fuid] objectForKey:@"avatar"]];;
        [cellView addSubview:contentPic];
        [contentPic release];


        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(70, 35, 200, 20)];
        [view  addSubview:[self jiequ:assCell.Message]];
        [view setBackgroundColor:[UIColor  clearColor]];
        [cellView addSubview:view];
        [view release];
    
    }
       return cellView;
    
    
}
-(UIView *)loadcel2:(arryCell *)assCell
{
    
    
    UIView *cellView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 59 )]autorelease];
    
    
    
    
//    arryCell *assCell=[self.dictMessage objectAtIndex:i];
    if ([assCell.description intValue]!=0) {
            
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(70, 8, 100, 25)];
            [lable setBackgroundColor:[UIColor clearColor]];
            [lable setTextColor:[UIColor blackColor]];
        [lable setFont:[UIFont systemFontOfSize:18]];

            if ([[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"] length]!=0) {
                lable.text=[NSString stringWithFormat:@"%@",[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"]];
                
            }else{
                
                lable.text=[NSString stringWithFormat:@"%@",[[self.array objectForKey:assCell.fuid] objectForKey:@"nickname"]];
                
            }
            [lable setTextAlignment:NSTextAlignmentLeft];
            [cellView addSubview:lable];
            [lable  release];
            
            AsyncImageView * contentPic = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
            contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,[[self.array objectForKey:assCell.fuid] objectForKey:@"avatar"]];;
            
            [cellView addSubview:contentPic];
            [contentPic release];
            UIImageView * image12=[[UIImageView alloc]initWithFrame:CGRectMake(40, -5, 30, 30)];
            image12.image=[UIImage imageNamed:@"tabbar_badge@2x.png"] ;
            [cellView addSubview:image12];
            UILabel*lablescale1=[[UILabel alloc]initWithFrame:CGRectMake(3, 4, 25, 25)];
//            lablescale1.tag=3000+i;
            [lablescale1 setBackgroundColor:[UIColor clearColor]];
            [lablescale1 setTextColor:[UIColor  blackColor]];
            [lablescale1 setFont:[UIFont systemFontOfSize:12]];
            [lablescale1 setTextAlignment:NSTextAlignmentCenter];
            [lablescale1 setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
            lablescale1.text=assCell.description;
            [image12  addSubview:lablescale1];
            [image12 release];
            [lablescale1 release];
            
            
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(70, 35, 200, 20)];
        [view  addSubview:[self jiequ:assCell.Message]];
        [view setBackgroundColor:[UIColor  clearColor]];
        [cellView addSubview:view];
        [view release];
        
           }else{
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(70,5, 200, 20)];
        [lable setBackgroundColor:[UIColor clearColor]];
        [lable setTextColor:[UIColor blackColor]];
               [lable setFont:[UIFont systemFontOfSize:18]];

        if ([[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"] length]!=0) {
            lable.text=[NSString stringWithFormat:@"%@",[[self.array objectForKey:assCell.fuid] objectForKey:@"f_nickname"]];
            
        }else{
            
            lable.text=[NSString stringWithFormat:@"%@",[[self.array objectForKey:assCell.fuid] objectForKey:@"nickname"]];
            
        }
        [lable setTextAlignment:NSTextAlignmentLeft];
        [cellView addSubview:lable];
        [lable  release];
        
        
        AsyncImageView * contentPic = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,[[self.array objectForKey:assCell.fuid] objectForKey:@"avatar"]];;
        [cellView addSubview:contentPic];
        [contentPic release];
        
        
               UIView *view=[[UIView alloc]initWithFrame:CGRectMake(70, 35, 200, 20)];
               [view  addSubview:[self jiequ:assCell.Message]];
               [view setBackgroundColor:[UIColor  clearColor]];
               [cellView addSubview:view];
               [view release];
        
    }
    return cellView;
    
    
}

-(UIView *)loadcell1:(NSString *)cellname Cellimage:(UIImage *)cellImage IndenRow:(int)i
{
    
    
    UIView *cellView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60 )]autorelease];
    [cellView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"listitem.png"]]];
    
    
    
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(70, 8, 100, 25)];
        [lable setBackgroundColor:[UIColor clearColor]];
        [lable setTextColor:[UIColor blackColor]];
    [lable setFont:[UIFont systemFontOfSize:18]];

    if ([[[_searchArray objectAtIndex:i] objectForKey:@"f_nickname"] length]!=0) {
        lable.text=[NSString stringWithFormat:@"%@",[[_searchArray objectAtIndex:i] objectForKey:@"f_nickname"]];

    }else{
        lable.text=[NSString stringWithFormat:@"%@",[[_searchArray objectAtIndex:i] objectForKey:@"nickname"]];

    
    
    }
        [lable setTextAlignment:NSTextAlignmentLeft];
        [cellView addSubview:lable];
        [lable  release];
        
        
        AsyncImageView * contentPic = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        contentPic.urlString = [NSString stringWithFormat:@"%@/HeadPic/%@",HTTPHEADPIC,[[_searchArray objectAtIndex:i] objectForKey:@"avatar"]];;
        [cellView addSubview:contentPic];
        [contentPic release];
        
        
        
        
  

    return cellView;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableView) {
  
    arryCell *ass=[self.dictMessage objectAtIndex:indexPath.row];
        if ([ass.Midea length]==0) {
     
    ChatIngController *firstViewController = [[ChatIngController alloc] init];
    [firstViewController setHidesBottomBarWhenPushed:(BOOL)(1)];
    firstViewController.strfUsid=[[self.array objectForKey:ass.fuid] objectForKey:@"f_UId"];
        if ([[[self.array objectForKey:ass.fuid] objectForKey:@"f_nickname"] length]!=0) {
            firstViewController.strfname=[[self.array objectForKey:ass.fuid] objectForKey:@"f_nickname"];
            
        }else{
            firstViewController.strfname=[[self.array objectForKey:ass.fuid] objectForKey:@"nickname"];
            
            
            
        }
    firstViewController.strfPic=[[self.array objectForKey:ass.fuid] objectForKey:@"avatar"];
             firstViewController.strfPic1=[[self.array objectForKey:ass.fuid] objectForKey:@"m_avatar"];
    [self.navigationController pushViewController:firstViewController animated:YES];
    [firstViewController release];
        }else{
        
            AddFriengViewController *firstViewController = [[AddFriengViewController alloc] init];
            [firstViewController setHidesBottomBarWhenPushed:(BOOL)(1)];
            firstViewController.dict=ass;
            firstViewController.delegate=self;
            [self.navigationController pushViewController:firstViewController animated:YES];
            [firstViewController release];
        
        
        
        
        }
    }else{
    
        
        ChatIngController *firstViewController = [[ChatIngController alloc] init];
        [firstViewController setHidesBottomBarWhenPushed:(BOOL)(1)];
        firstViewController.strfUsid=[NSString stringWithFormat:@"%@",[[_searchArray objectAtIndex:indexPath.row] objectForKey:@"f_UId"]];
        if ([[[_searchArray objectAtIndex:indexPath.row] objectForKey:@"f_nickname"] length]!=0) {
            firstViewController.strfname=[NSString stringWithFormat:@"%@",[[_searchArray objectAtIndex:indexPath.row] objectForKey:@"f_nickname"]];
            
        }else{
            firstViewController.strfname=[NSString stringWithFormat:@"%@",[[_searchArray objectAtIndex:indexPath.row] objectForKey:@"nickname"]];
            
            
            
        }
        firstViewController.strfPic=[NSString stringWithFormat:@"%@",[[_searchArray objectAtIndex:indexPath.row] objectForKey:@"avatar"]];
              firstViewController.strfPic1=[NSString stringWithFormat:@"%@",[[_searchArray objectAtIndex:indexPath.row] objectForKey:@"m_avatar"]];
        [self.navigationController pushViewController:firstViewController animated:YES];
        [firstViewController release];
    
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Chage:) name:@"Chage" object:nil];

    
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
