//
//  ShowMideaViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-10-18.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "ShowMideaViewController.h"
#import "AsyncImageView.h"
#import "SVProgressHUD.h"
@interface ShowMideaViewController ()

@end

@implementation ShowMideaViewController

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
//    [UIApplication sharedApplication].statusBarHidden=YES;
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window viewWithTag:123].hidden=YES;

    [UIApplication sharedApplication].statusBarHidden=NO;
    self.navigationController.navigationBar.hidden=YES;

}
-(void)dealloc
{
    [super dealloc];
    [dataPic release];


}
-(void)push1
{
    [moviePlayer release];
    [view removeFromSuperview];
    [self push];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    dataPic=[[NSMutableData alloc]init];
//    [self InterceptionStr];
    //我收视频
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIImageView *imageBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-89, 320, 69)];
    imageBack.image=[UIImage  imageNamed:@"照片黑条.png"];
    [self.view addSubview:imageBack];
    [imageBack release];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button  setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(145, self.view.frame.size.height-70, 30, 30)];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


    if ([[self InterceptionStr]isEqualToString:@"12"]) {
//        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        [button  setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
//        [button setFrame:CGRectMake(145, self.view.frame.size.height-70, 30, 30)];
//        [button addTarget:self action:@selector(push1) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
        [self infaceShouMie:[[self.strFile componentsSeparatedByString:@"*"] objectAtIndex:0] Suo:[[self.strFile componentsSeparatedByString:@"*"] objectAtIndex:1]];
    }
       if ([[self InterceptionStr]isEqualToString:@"02"]) {

          [self infaceShou:[[self.strFile componentsSeparatedByString:@"*"] objectAtIndex:0] Suo:[[self.strFile componentsSeparatedByString:@"*"] objectAtIndex:1]];
       }
    //我发图片
    if ([[self InterceptionStr]isEqualToString:@"03"]) {
//        UIImageView *imageBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-89, 320, 69)];
//        imageBack.image=[UIImage  imageNamed:@"照片黑条.png"];
//        [self.view addSubview:imageBack];
//        [imageBack release];
//        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        [button  setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
//        [button setFrame:CGRectMake(145, self.view.frame.size.height-70, 30, 30)];
//        [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
//        NSLog(@"%@",[[self.strFile componentsSeparatedByString:@"*"] objectAtIndex:1]);
        [self inface:[UIImage imageWithContentsOfFile:[[self.strFile componentsSeparatedByString:@"*"] objectAtIndex:1]]];
    }
    //我发视频
    if ([[self InterceptionStr]isEqualToString:@"13"]) {
//        UIImageView *imageBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-89, 320, 69)];
//        imageBack.image=[UIImage  imageNamed:@"照片黑条.png"];
//        [self.view addSubview:imageBack];
//        [imageBack release];
//        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        [button  setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];
//        [button setFrame:CGRectMake(145, self.view.frame.size.height-70, 30, 30)];
//        [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
        self.strMia=[[self.strFile componentsSeparatedByString:@"*"] objectAtIndex:1];
        [self inface2:[UIImage imageWithContentsOfFile:[[self.strFile componentsSeparatedByString:@"*"] objectAtIndex:0]]];
//        [self inface1:self.strMia];
    }
    //我收图片

    
}
-(void)inface2:(UIImage *)image
{
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-91)];
    imageview.image=image;
    [self.view addSubview:imageview];
    [imageview release];
    
    UIButton *button11=[UIButton buttonWithType:UIButtonTypeCustom];
    [button11 setImage:[UIImage imageNamed:@"播放.png"] forState:UIControlStateNormal];
    [button11 addTarget:self action:@selector(inface1:) forControlEvents:UIControlEventTouchUpInside];
    [button11 setFrame:CGRectMake(0, 0, 50, 50)];
    [button11 setCenter:imageview.center];
    [self.view addSubview:button11];
    
    
}

-(void)inface1:(NSString *)fileUrl
{
    [UIApplication sharedApplication].statusBarHidden=NO;
//    self.navigationController.navigationBar.hidden=YES;
//    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:self.strMia]];
//   
//    [self.navigationController presentViewController:player animated:YES completion:^{
//          }];
//    [player release];
    
    

//
//    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//   NSString *ssss= [userDefaults stringForKey:@"llll"];
    
    
    
    
    
    
    
   view=[[UIView alloc]init];
    view.frame=self.view.frame;

    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:self.strMia]];
    [moviePlayer prepareToPlay];
    moviePlayer.shouldAutoplay = YES;
    moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    moviePlayer.repeatMode = MPMovieRepeatModeNone;
    moviePlayer.controlStyle = MPMovieControlStyleFullscreen ;
    moviePlayer.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, self.view.frame.size.height);
    [view addSubview:moviePlayer.view];
//    [moviePlayer release];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continuePlay:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    [self.view addSubview:view];
    
    
}
-(void)continuePlay:(MPMoviePlayerController *)player
{
    [UIApplication sharedApplication].statusBarHidden=NO;
    self.navigationController.navigationBar.hidden=NO;
    [moviePlayer release];
    [view removeFromSuperview];
    [self push];
}
-(void)continuePlay1:(MPMoviePlayerController *)player
{
//    NSLog(@"jkkkjkkkk");
//    [view removeFromSuperview];
//    [self push];
}
-(UIImage *)jietu:(UIImage *)image Imag:(CGSize)newSize
{
    //    CGSize newSize=CGSizeMake(95, 125);
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
    
}
-(void)infaceShouMie:(NSString *)image Suo:(NSString *)srr
{
    NSString * realPath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, //NSDocumentDirectory or NSCachesDirectory
															  NSUserDomainMask, //NSUserDomainMask
															  YES)	// YES
						  objectAtIndex: 0];
	NSString *imageCachePath = [image stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
	NSString * filePath=[realPath stringByAppendingPathComponent:imageCachePath];
    
    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:filePath]];
    //    imageview.image=[UIImage imageWithContentsOfFile:filePath];
    imageview.center=CGPointMake(self.view.center.x, self.view.center.y-55);
    [self.view addSubview:imageview];
    [imageview release];
//    [SVProgressHUD showInView:nil status:@"加载中.."];
    [UIApplication sharedApplication].statusBarHidden=YES;
//    [self.navigationController setNavigationBarHidden:YES];
    view=[[UIView alloc]init];
    view.frame=self.view.frame;

    self.strMia=[srr substringWithRange:NSMakeRange(50, 8)];
    NSLog(@"%@",self.strMia);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    [NSString stringWithFormat:@"%@.3pg",self.strMia]
    NSString *file=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.3gp",self.strMia]];
    [UIApplication sharedApplication].statusBarHidden=YES;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    NSData *data=[[NSData alloc]initWithContentsOfFile:file];
    if (data !=nil) {
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:file]];
        [moviePlayer prepareToPlay];
        moviePlayer.shouldAutoplay = YES;
        moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        moviePlayer.repeatMode = MPMovieRepeatModeNone;
        moviePlayer.controlStyle = MPMovieControlStyleFullscreen ;
        moviePlayer.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, self.view.frame.size.height);
        [self.view  addSubview:moviePlayer.view];
        //    [self presentViewController:moviePlayer animated:YES completion:nil];
        //    [moviePlayer release];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continuePlay:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
        [self.view addSubview:view];

    }else{

        [SVProgressHUD showInView:nil status:@"请稍等.."];
        NSURL *url1 = [NSURL URLWithString:srr];
        
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url1 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        
        NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self] autorelease];
    }

  
 


}

-(void)infaceShou:(NSString *)image Suo:(NSString *)srr
{
    NSString * realPath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, //NSDocumentDirectory or NSCachesDirectory
															  NSUserDomainMask, //NSUserDomainMask
															  YES)	// YES
						  objectAtIndex: 0];
	NSString *imageCachePath = [image stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
	NSString * filePath=[realPath stringByAppendingPathComponent:imageCachePath];

    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:filePath]];
//    imageview.image=[UIImage imageWithContentsOfFile:filePath];
    imageview.center=CGPointMake(self.view.center.x, self.view.center.y-55);
    [self.view addSubview:imageview];
    [imageview release];

    [SVProgressHUD showInView:nil status:@"加载中.."];
    NSURL *url = [NSURL URLWithString:srr];
    //    MPMoviePlayerController * moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    //    [moviePlayer prepareToPlay];
    //    moviePlayer.shouldAutoplay = YES;
    //    moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    //    moviePlayer.repeatMode = MPMovieRepeatModeNone;
    //    moviePlayer.controlStyle = MPMovieControlStyleFullscreen ;
    //    moviePlayer.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-50);
    //    [self.view  addSubview:moviePlayer.view];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{

    [dataPic setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"123");
    [dataPic appendData:data];
    
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    [SVProgressHUD dismiss];
    if (![[self InterceptionStr]isEqualToString:@"12"]) {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-91)];
        imageview.image=[UIImage imageWithData:dataPic];
        [self.view addSubview:imageview];
        [imageview release];
    }else{
        
        //    NSURL *url=[NSURL URLWithString:[[NSString alloc] initWithData:dataPic encoding:NSUTF8StringEncoding]];
        //
        
        //    NSFileManager *fileManager = [NSFileManager defaultManager];
        //     NSError *error;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        //    [NSString stringWithFormat:@"%@.3pg",self.strMia]
        NSString *file=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.3gp",self.strMia]];
           NSLog(@"%@",file);
        [dataPic writeToFile:file atomically:YES];
        //    NSBundle *bundle = [NSBundle mainBundle];
        //    NSString *moviePath = [bundle pathForResource:@"jjj" ofType:@"3pg"];
        //    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:file]];
        [moviePlayer prepareToPlay];
        moviePlayer.shouldAutoplay = YES;
        moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        moviePlayer.repeatMode = MPMovieRepeatModeNone;
        moviePlayer.controlStyle = MPMovieControlStyleFullscreen ;
        moviePlayer.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, self.view.frame.size.height);
        [self.view  addSubview:moviePlayer.view];
        //    [self presentViewController:moviePlayer animated:YES completion:nil];
        //    [moviePlayer release];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continuePlay:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
        [self.view addSubview:view];
        
        
    }
    
    
}

-(void)connection:(NSURLConnection *)connection{
    [SVProgressHUD dismiss];
    [SVProgressHUD showAbnormalThenDismiss:@"加载失败"];
}

-(void)inface:(UIImage *)image
{
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-91)];
    imageview.image=image;
    [self.view addSubview:imageview];
    [imageview release];
    
    
    
}
-(void)push
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];

}

-(NSString *)InterceptionStr
{
    
    NSArray *arr=[self.strFile componentsSeparatedByString:@"*"];
 
    return [arr objectAtIndex:2];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
