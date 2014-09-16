//
//  ImageViewController.m
//  电视微信
//
//  Created by 陈 琨 on 13-10-17.
//  Copyright (c) 2013年 黑小刚. All rights reserved.
//

#import "ImageViewController.h"
#import "SVProgressHUD.h"
#import "ChatIngController.h"
#import "SettingViewController.h"
#import "Header.h"
@interface ImageViewController ()

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarHidden=NO;




}
-(void)dealloc
{

    [super dealloc];
    [db release];
    [lable release];
    _strfUsid=nil;
    _strName=nil;
    _strPic=nil;
    _strUid=nil;
    _dataInfo=nil;
    _mideaInfo=nil;
    _image=nil;
    _imageFile=nil;
    _imageFilePic=nil;
    _imagePic=nil;
    _arr=nil;
    _strName=nil;
    _imagePic=nil;
    if (CCpath!=nil) {
        [CCpath release];
    }

}
- (void)viewDidLoad
{
    
    [super viewDidLoad];

    db=[[SUserDB alloc]init];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [UIApplication sharedApplication].statusBarHidden=NO;
    [self.navigationController setNavigationBarHidden:YES];
	// Do any additional setup after loading the view.
    UIImageView *imageBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-89, 320, 69)];
    imageBack.image=[UIImage  imageNamed:@"照片黑条.png"];
    [self.view addSubview:imageBack];
    [imageBack release];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.tag=320;
    [button  setBackgroundImage:[UIImage imageNamed:@"对.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(270, self.view.frame.size.height-70, 30, 30)];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
//    [button release];
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1  setBackgroundImage:[UIImage imageNamed:@"叉.png"] forState:UIControlStateNormal];

    [button1 setFrame:CGRectMake(20, self.view.frame.size.height-70, 30, 30)];
    [button1 addTarget:self action:@selector(push1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
//    [button1 release];
    if (self.image!=nil) {
        [self judeImage];
        
    }else{
        [self JudeMidea];

    
    }
    lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    lable.center=CGPointMake(self.view.center.x, self.view.center.y+20);
    [lable setBackgroundColor:[UIColor clearColor]];
    lable.textColor=[UIColor whiteColor];
    lable.text=@"";
    [self.view addSubview:lable];
    

}
-(void)judeImage
{

    [self inface:[self jietu:self.image Imag:CGSizeMake(320, self.view.frame.size.height-91)]];


}
-(void)JudeMidea
{
    
     NSString *mediaType = [self.mideaInfo objectForKey:UIImagePickerControllerMediaType];
     
     BOOL success;
     NSFileManager *fileManager = [NSFileManager defaultManager];
//     NSError *error;
    
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     
     if ([mediaType isEqualToString:@"public.image"]){
     
     UIImage *image1 =[self rotateImage:[self.mideaInfo objectForKey:UIImagePickerControllerOriginalImage]] ;
     UIImage *image=[self jietu:image1 Imag:CGSizeMake(85, 115)];
     NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
     NSMutableArray *arrww = (NSMutableArray *)[userDefaults objectForKey:@"imageName"];
     if (arrww ==NULL) {
     arrww=[[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"0"], nil] autorelease];
     [userDefaults setObject:arrww forKey:@"imageName"];
     }
     
     self.imageFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Mid%@%d.png",self.strfUsid,[[arrww objectAtIndex:([arrww count]-1)] intValue ]+1]] ;
     NSMutableArray *muArray=[[NSMutableArray alloc]initWithArray:arrww];
     
     
     [muArray addObject:[NSString stringWithFormat:@"%d",([[arrww objectAtIndex:([arrww count]-1)]intValue ]+1)]];
//     //            NSLog(@"111");
     //
     //
     [userDefaults setObject:muArray forKey:@"imageName"];
     [muArray release];
     success = [fileManager fileExistsAtPath:self.imageFile];
     if(success) {
     //            success = [fileManager removeItemAtPath:imageFile error:&error];
     }
     
     //大图
     NSMutableArray *arrPic = (NSMutableArray *)[userDefaults objectForKey:@"imagePicName"];
     if (arrww ==NULL) {
     arrww=[[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"0"], nil] autorelease];
     [userDefaults setObject:arrww forKey:@"imageName"];
     }
     
     self.imageFilePic = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.png",self.strfUsid,[[arrPic objectAtIndex:([arrPic count]-1)] intValue ]+1]];
     NSMutableArray *muArrayPic=[[NSMutableArray alloc]initWithArray:arrPic];
     
     
     [muArrayPic addObject:[NSString stringWithFormat:@"%d",([[arrPic objectAtIndex:([arrPic count]-1)]intValue ]+1)]];
     //            NSLog(@"111");
     //
     //
     [userDefaults setObject:muArrayPic forKey:@"imagePicName"];
     [muArrayPic release];
     
     
     
     
     
     
     
     
     //        imageView.image = image;
     [UIImagePNGRepresentation([self jietu:image1 Imag:CGSizeMake(320, self.view.frame.size.height-91)]) writeToFile:self.imageFilePic atomically:YES];
     
     [UIImagePNGRepresentation(image) writeToFile:self.imageFile atomically:YES];
         self.strName=  [NSString stringWithFormat:@"Pic%@%d.png",self.strfUsid,[[arrww objectAtIndex:([arrww count]-1)] intValue ]+1];
         self.imagePic=[self jietu:image1 Imag:CGSizeMake(image1.size.width, image1.size.height)];
         [self inface:[self jietu:image1 Imag:CGSizeMake(320, self.view.frame.size.height-91)]];
         
         
//     [_tableView reloadData];
//[self appImage:image1 ImageName:[NSString stringWithFormat:@"Pic%@%d.png",self.strfUsid,[[arrww objectAtIndex:([arrww count]-1)] intValue ]+1]];
     
     
     }
     else if([mediaType isEqualToString:@"public.movie"]){
     NSURL *videoURL = [self.mideaInfo objectForKey:UIImagePickerControllerMediaURL];

         CCpath = [[NSString alloc] initWithFormat:@"%@",[[self.mideaInfo objectForKey:UIImagePickerControllerMediaURL] path]];
         
//         NSLog(@"path==%@",CCpath);
//             UISaveVideoAtPathToSavedPhotosAlbum(CCpath, self, @selector(videoSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
         
//         [self inface1:CCpath];


    

         

     //视频缩略图
     AVURLAsset *asset = [[[AVURLAsset alloc] initWithURL:videoURL options:nil] autorelease];
     AVAssetImageGenerator *gen = [[[AVAssetImageGenerator alloc] initWithAsset:asset] autorelease];
     gen.appliesPreferredTrackTransform = YES;
     CMTime time = CMTimeMakeWithSeconds(0.0, 600);
     NSError *error = nil;
     CMTime actualTime;
     CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
     UIImage *thumb = [self jietu:[[UIImage alloc] initWithCGImage:image] Imag:CGSizeMake(85, 115)  ];
     CGImageRelease(image);
     
     NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
     NSMutableArray *arrww = (NSMutableArray *)[userDefaults objectForKey:@"imageMiaName"];
     if (arrww ==NULL) {
     arrww=[[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"0"], nil] autorelease];
     [userDefaults setObject:arrww forKey:@"imageMiaName"];
     }
     
     self.imageFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"mia%@%d.png",self.strfUsid,[[arrww objectAtIndex:([arrww count]-1)] intValue ]+1]];
     NSMutableArray *muArray=[[NSMutableArray alloc]initWithArray:arrww];
     
     
     [muArray addObject:[NSString stringWithFormat:@"%d",([[arrww objectAtIndex:([arrww count]-1)]intValue ]+1)]];
     //            NSLog(@"111");
     //
     //
     [userDefaults setObject:muArray forKey:@"imageMiaName"];
     [muArray release];
     
     [UIImagePNGRepresentation([self jietu:thumb Imag:CGSizeMake(85, 115)]) writeToFile:self.imageFile atomically:YES];
         [self inface2:thumb];
     
     
     
     
     //
     self.dataInfo = [NSData dataWithContentsOfURL:videoURL] ;
//         self.dataInfo=[[NSData alloc] initWithContentsOfFile:[videoURL path]];
     
//         self.imageFile = [documentsDirectory stringByAppendingPathComponent:@"shipin.mov"];
//         [userDefaults setObject:self.imageFile forKey:@"llll"];
//         NSLog(@"mmmmmmmmmm=%@",self.imageFile);
         
         
         
         NSMutableArray *arrPic = (NSMutableArray *)[userDefaults objectForKey:@"imageMeaName"];
         if (arrww ==NULL) {
             arrww=[[[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"0"], nil] autorelease];
             [userDefaults setObject:arrww forKey:@"imageMeaName"];
         }
         
         self.imageFilePic = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.3gp",self.strfUsid,[[arrPic objectAtIndex:([arrPic count]-1)] intValue ]+1]];
         [self.dataInfo writeToFile:self.imageFilePic atomically:YES];

         NSMutableArray *muArrayPic=[[NSMutableArray alloc]initWithArray:arrPic];
         
         
         [muArrayPic addObject:[NSString stringWithFormat:@"%d",([[arrPic objectAtIndex:([arrPic count]-1)]intValue ]+1)]];
         //            NSLog(@"111");
         //
         //
         [userDefaults setObject:muArrayPic forKey:@"imageMeaName"];
         [muArrayPic release];
         
         
         
         
//     NSDate * senddate=[NSDate date];
//     NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//     //    [dateformatter setDateFormat:@"HH:mm"];
//     //    NSString * locationString=[dateformatter stringFromDate:senddate];
//     [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
//     NSString * morelocationString=[[dateformatter stringFromDate:senddate] retain];
//     SUser *ser=[[SUser alloc]init];
//     ser.Time1=morelocationString;
//     ser.Midea=CCpath;
//     //        ser.Message=inputText;
//     ser.mixPic=imageFile;
//     ser.userImage=[[self.personArray objectAtIndex:0]objectForKey:@"m_avatar"];
//     ser.TypeUser=@"3";
//     
//     [_messageArray addObject:ser];
//     [db createDataBase];
//     
//     [db saveUser:ser];
//     [dateformatter release];
//     
//     [ser release];
//
//     [_tableView reloadData];

     
     
     
     
     
     //上传服务器
//         [self inface1:imageFile1];
  
     }
     




}

-(void)inface1:(NSString *)fileUrl
{

    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:CCpath]];
    [self presentMoviePlayerViewControllerAnimated:player];
    [player release];

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
-(void)inface:(UIImage *)image
{

    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-91)];
    imageview.image=image;
    [self.view addSubview:imageview];
    [imageview release];



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
-(void)push
{

    NSString *mediaType = [self.mideaInfo objectForKey:UIImagePickerControllerMediaType];

    if (self.image!=nil) {
        UIButton *button=(UIButton *)[self.view viewWithTag:320];
        [button setUserInteractionEnabled:NO];
        [SVProgressHUD showInView:nil status:@"加载中...."];
        [self performSelector:@selector(appImage) withObject:self afterDelay:0.5];
    }
    if ([mediaType isEqualToString:@"public.image"]){
        UIButton *button=(UIButton *)[self.view viewWithTag:320];
        [button setUserInteractionEnabled:NO];
//        UIActivityIndicatorView *spinny = (UIActivityIndicatorView *) [self.view viewWithTag: 20];
//        [spinny startAnimating];
        [SVProgressHUD showInView:nil status:@"加载中...."];
        [self performSelector:@selector(appImage) withObject:self afterDelay:0.5];
//               [self appImage:self.imagePic ImageName:self.strName];
    }
    if ([mediaType isEqualToString:@"public.movie"]){
        UIButton *button=(UIButton *)[self.view viewWithTag:320];
        [button setUserInteractionEnabled:NO];
        [SVProgressHUD showInView:nil status:nil];
        [self addroom:self.dataInfo];
    }
}
-(void)addroom:(NSData *)data1
{
    NSString * inputMsgStr = [NSString stringWithFormat:@"Content-Length=%d;filename=%@;sourceid=%@;UID=%@;f_UID=%@",[data1 length],@"ff444.avi",@"",self.strUid,self.strfUsid];
//    NSLog(@"%d",[testByte ] );
    NSString * content = [inputMsgStr stringByAppendingString:@"\r\n"];
    NSData *data = [content dataUsingEncoding: NSUTF8StringEncoding];//数据使用编码类型
    NSMutableData *data12=[[[NSMutableData alloc]init] autorelease];
    [data12 appendData:data];
    [data12 appendData:data1];



    AsyncSocket *socket=[[AsyncSocket alloc]initWithDelegate:self userData:nil] ;
    
    BOOL connect= [socket connectToHost:@"119.44.220.4" onPort:7878 error:nil];
    [socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    if (connect) {
        [socket writeData:data12 withTimeout:3 tag:10000];
    }
    
    
    
    //1358683
    //1353632  1358683
    
    
}
-(void)onSocket:(AsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{

    if (tag==10000) {
        
//        NSLog(@"444444444444");
    self.index=self.index+partialLength;
        int n=self.index*100/[self.dataInfo length];
        [lable setText:[NSString stringWithFormat:@"%d%@",n,@"%"]];
//        NSLog(@"%d",self.index);

    }
}

-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    [SVProgressHUD dismiss];
    UIButton *button=(UIButton *)[self.view viewWithTag:320];
    [button setUserInteractionEnabled:YES];
    [SVProgressHUD showAbnormalThenDismiss:@"上传失败"];
    
    
}
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
//    NSLog(@"1111=%@",sock.description);

}
-(void)onSocketDidSecure:(AsyncSocket *)sock
{
//    NSLog(@"11112=%@",sock.description);




}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag;
{
//    NSLog(@"wwwwww=%@",sock.description);

    [lable setText:@"100%"];
    [self performSelector:@selector(disapper) withObject:self afterDelay:0.5];


}
-(void)disapper
{
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    //    [dateformatter setDateFormat:@"HH:mm"];
    //    NSString * locationString=[dateformatter stringFromDate:senddate];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString * morelocationString=[[dateformatter stringFromDate:senddate] retain];
    SUser *ser=[[SUser alloc]init];
    ser.Time1=morelocationString;
    ser.Midea=self.imageFilePic;
    ser.userId=self.strUid;
    ser.f_userId=self.strfUsid;
    //        ser.Message=inputText;
    ser.mixPic=self.imageFile;
    ser.userImage=self.strPic;
    ser.TypeUser=@"3";
    
   
    [db createDataBase];
    
    [db saveUser:ser];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"serMessage" object:ser ];

    [dateformatter release];
    
    [ser release];
    UIButton *button=(UIButton *)[self.view viewWithTag:320];
    [button setUserInteractionEnabled:YES];
    [SVProgressHUD dismiss];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}
-(NSTimeInterval)onSocket:(AsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
{



    return 1;
}

-(UIImage *)rotateImage:(UIImage *)aImage

{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = aImage.size.width/10;
    CGFloat height = aImage.size.height/10;
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

//-(void)appImage{
////    edituserinfo
//    NSURL *url=nil;
//    if (self.image!=nil) {
//    url=[NSURL URLWithString:@"http://119.44.220.4/edituserinfo"];
//    }else{
//    
//        url=[NSURL URLWithString:@"http://119.44.220.4/sendpic"];
//
//    }
//    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc]initWithURL:url] autorelease];
//    request.delegate=self;
//    if (self.image!=nil) {
//        
//        [request setPostValue:self.strUid forKey:@"UID"];
////        [request setPostValue:self.strfUsid forKey:@"f_UID"];
//        [request setPostValue:@"HeadPic.png" forKey:@"filenames"];
////        [NSString stringWithFormat:@"nickname=%@&UID=%@&passWord=%@&phone=%@&email=%@&filenames=%@",lable.text,self.strUID,@"",[self.Message objectAtIndex:4],[self.Message objectAtIndex:1],@""];
//        [request setPostValue:[[self.arr objectAtIndex:0] substringWithRange:NSMakeRange(1, [[self.arr objectAtIndex:0] length]-1)] forKey:@"nickname"];
//        [request setPostValue:@"" forKey:@"passWord"];
//        [request setPostValue:[self.arr objectAtIndex:1] forKey:@"phone"];
//        [request setPostValue:[self.arr objectAtIndex:4] forKey:@"email"];
////        NSLog(@"wwwwww=%@  %@  %@  %@",self.strUid,[self.arr objectAtIndex:0],[self.arr objectAtIndex:4],[self.arr objectAtIndex:4]);
//        NSData *data=UIImagePNGRepresentation(self.image);
//        [request setData:data withFileName:@"HeadPic.png" andContentType:@"image/png" forKey:@"PicAndVdo"];
//        
//        
//        
//    }else{
//    
//    [request setPostValue:self.strUid forKey:@"UID"];
//    [request setPostValue:self.strfUsid forKey:@"f_UID"];
//    [request setPostValue:self.strName forKey:@"filenames"];
//
//    NSData *data=UIImagePNGRepresentation(self.imagePic);
//    [request setData:data withFileName:self.strName andContentType:@"image/png" forKey:@"PicAndVdo"];
//}
//    [request startSynchronous];
//    
//
//}
-(void)appImage{
    //    edituserinfo
//    NSURL *url=nil;
//    if (self.image!=nil) {
//        url=[NSURL URLWithString:@"http://172.16.11.6/edituserinfo"];
//    }else{
//        
//        url=[NSURL URLWithString:@"http://172.16.11.6/sendpic"];
//        
//    }
        NSURL *url=nil;
       if (self.image!=nil) {
//        url=[NSURL URLWithString:@"http://119.44.220.4/edituserinfo"];
           url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/edituserinfo",HTTPHEAD]];

           
        }else{
    
//            url=[NSURL URLWithString:@"http://119.44.220.4/sendpic"];
            url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/sendpic",HTTPHEAD]];

    
        }

    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc]initWithURL:url] autorelease];
    request.delegate=self;
    if (self.image!=nil) {
        
        [request setPostValue:self.strUid forKey:@"UID"];
        //        [request setPostValue:self.strfUsid forKey:@"f_UID"];
        [request setPostValue:@"HeadPic.png" forKey:@"filenames"];
        //        [NSString stringWithFormat:@"nickname=%@&UID=%@&passWord=%@&phone=%@&email=%@&filenames=%@",lable.text,self.strUID,@"",[self.Message objectAtIndex:4],[self.Message objectAtIndex:1],@""];
        [request setPostValue:[[self.arr objectAtIndex:0] substringWithRange:NSMakeRange(1, [[self.arr objectAtIndex:0] length]-1)] forKey:@"nickname"];
        [request setPostValue:@"" forKey:@"passWord"];
        [request setPostValue:[self.arr objectAtIndex:1] forKey:@"phone"];
        [request setPostValue:[self.arr objectAtIndex:4] forKey:@"email"];
        //        NSLog(@"wwwwww=%@  %@  %@  %@",self.strUid,[self.arr objectAtIndex:0],[self.arr objectAtIndex:4],[self.arr objectAtIndex:4]);
        NSData *data=UIImagePNGRepresentation(self.image);
        [request setData:data withFileName:@"HeadPic.png" andContentType:@"image/png" forKey:@"PicAndVdo"];
//        NSLog(@"----------------------------");
        
        
    }else{
//        NSLog(@"++++++++++++++++++++++++++");
        
        [request setPostValue:self.strUid forKey:@"UID"];
        [request setPostValue:self.strfUsid forKey:@"f_UID"];
        [request setPostValue:self.strName forKey:@"filenames"];
        
        NSData *data=UIImagePNGRepresentation(self.imagePic);
        [request setData:data withFileName:self.strName andContentType:@"image/png" forKey:@"PicAndVdo"];
    }
    [request startSynchronous];
    
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    UIButton *button=(UIButton *)[self.view viewWithTag:320];
    [button setUserInteractionEnabled:YES];
    [SVProgressHUD dismiss];
        
}
-(void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    UIButton *button=(UIButton *)[self.view viewWithTag:320];
    [button setUserInteractionEnabled:YES];
    [SVProgressHUD dismiss];

    NSString *str11=[[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"str11=%@",str11);
    
    if (self.image!=nil) {
        NSLog(@"1111111");
        if ([str11 length]<100) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"Back" object:self.image];
            
            [self.navigationController dismissModalViewControllerAnimated:YES];
        }
        else{
            
            
            [SVProgressHUD showAbnormalThenDismiss:@"上传失败"];
            
        }
        
    }else{
        NSLog(@"2222222");

        NSDate * senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        //    [dateformatter setDateFormat:@"HH:mm"];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString * morelocationString=[[dateformatter stringFromDate:senddate] retain];
        SUser *ser=[[SUser alloc]init];
        ser.f_userId=self.strfUsid;
        ser.userId=self.strUid;
        ser.Time1=morelocationString;
        //        ser.Message=inputText;
        ser.mixPic=self.imageFile;
        ser.Pic=self.imageFilePic;
        ser.userImage=self.strPic;
        ser.TypeUser=@"3";
        [db createDataBase];
        [db saveUser:ser];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"serMessage" object:ser ];
        
        [dateformatter release];
        [ser.Time1 release];
        [ser  release];
        
        [self.navigationController dismissModalViewControllerAnimated:YES];
    }

    
    
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"33333=%@",request.responseString);
   
    [SVProgressHUD dismiss];
    
    UIButton *button=(UIButton *)[self.view viewWithTag:320];
    [button setUserInteractionEnabled:YES];
    if ([request.responseString  isEqualToString:@""]) {
        if (self.image!=nil) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"Back" object:self.image];
                
                [self.navigationController dismissModalViewControllerAnimated:YES];
                           
            
            
        }else{
        NSDate * senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        //    [dateformatter setDateFormat:@"HH:mm"];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString * morelocationString=[[dateformatter stringFromDate:senddate] retain];
        SUser *ser=[[SUser alloc]init];
        ser.f_userId=self.strfUsid;
        ser.userId=self.strUid;
        ser.Time1=morelocationString;
        //        ser.Message=inputText;
        ser.mixPic=self.imageFile;
        ser.Pic=self.imageFilePic;
        ser.userImage=self.strPic;
        ser.TypeUser=@"3";
        [db createDataBase];
        [db saveUser:ser];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"serMessage" object:ser ];
        
        [dateformatter release];
        [ser.Time1 release];
        [ser  release];
        
        [self.navigationController dismissModalViewControllerAnimated:YES];

        }
        
    }else{
    
        [SVProgressHUD showAbnormalThenDismiss:@"上传失败"];

    }

}
-(void)push1
{

    [self.navigationController popToRootViewControllerAnimated:YES];


}
- (void)videoSavedToPhotosAlbum:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    NSLog(@"qqqqqqq===%@ error=%@  info=%@",videoPath,error,contextInfo);
    CCpath = [[NSString alloc] initWithFormat:@"%@",videoPath];
    //  CCpath = videoPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
