//
//  TVMessageCell.m
//  EmojiKeyboard
//
//  Created by 陈 琨 on 13-10-11.
//  Copyright (c) 2013年 wangjianle. All rights reserved.
//

#import "TVMessageCell.h"
#define CELL_HEIGHT self.contentView.frame.size.height
#define CELL_WIDTH self.contentView.frame.size.width
@implementation TVMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        if (self) {
            self.mideStyle=0;
            _faceMap = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_en" ofType:@"plist"]]retain];
            _faceMessage = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_ch" ofType:@"plist"]]retain];
            
            // Initialization code
            _userHead =[[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            _midiaPic =[[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];

            _bubbleBg =[[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            _timeConent=[[[UILabel alloc]initWithFrame:CGRectZero]autorelease];
            _headMask =[[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            _chatImage =[[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            _chatImage1=[[[AsyncImageView alloc]initWithFrame:CGRectZero]autorelease];
//            _selectButton=[[[FaceButton alloc]initWithFrame:CGRectZero] autorelease];
//            [_selectButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
//            [_messageConent setFont:[UIFont systemFontOfSize:15]];
//            [_messageConent setNumberOfLines:20];
            _chatImage1.chatImage=1;
            _chatImage1.autoImage=NO;
            [_chatImage1 addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
            
            [_timeConent setBackgroundColor:[UIColor clearColor]];
            [_timeConent setFont:[UIFont systemFontOfSize:15]];
            [_timeConent setTextColor:[UIColor colorWithRed:0.56 green:0.5 blue:0.7 alpha:0.8]];
            [_timeConent setTextAlignment:NSTextAlignmentCenter];
            [self.contentView addSubview:_bubbleBg];
            [self.contentView addSubview:_userHead];
            [self.contentView addSubview:_headMask];
            [self.contentView addSubview:_chatImage];
            [self.contentView addSubview:_timeConent];
            [self.contentView addSubview:_chatImage1];
            [self.contentView addSubview:_midiaPic];
//            [_chatImage setBackgroundColor:[UIColor redColor]];
            [self setSelectionStyle:UITableViewCellSelectionStyleNone];
            [_headMask setImage:[[UIImage imageNamed:@"UserHeaderImageBox"]stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        }

    }
    return self;
}
-(void)push:(AsyncImageView *)button
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ImageFile" object:button.MessageStr ];


}
//蓝色对话框.png
//灰色色对话框.png
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    if (_messageConent!=nil) {
        [_messageConent removeFromSuperview];
        [_messageConent release];
    }
    
    
    _messageConent=[[UIView alloc]initWithFrame:CGRectZero];
    [_messageConent setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_messageConent];
    
    
    [self assembleMessageAtIndex:self.array];
    CGSize textSize=CGSizeMake(_messageConent.frame.size.width, _messageConent.frame.size.height);
    
    switch (_msgStyle) {
        case 1:
        {
            [_midiaPic setHidden:YES];
            [_chatImage setHidden:YES];
            [_messageConent setHidden:NO];
            [_chatImage1 setHidden:YES];
            
            [_messageConent setFrame:CGRectMake(CELL_WIDTH-INSETS*2-HEAD_SIZE-textSize.width-15, (CELL_HEIGHT-textSize.height)/2, textSize.width+10, textSize.height)];
            //            [_messageConent addSubview:retianView];
            //            [retianView release];
            [_userHead setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE, _messageConent.frame.origin.y+_messageConent.frame.size.height-30,HEAD_SIZE , HEAD_SIZE)];
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"灰（2）.png"]stretchableImageWithLeftCapWidth:18 topCapHeight:18]];
            
            _bubbleBg.frame=CGRectMake(_messageConent.frame.origin.x-7, _messageConent.frame.origin.y-10, textSize.width+25, textSize.height+20);
            //            _timeConent.text=@"11111";
            [_timeConent setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE-5-240,_bubbleBg.frame.size.height+_bubbleBg.frame.origin.y-5, 240, 30)];
            [_timeConent setTextAlignment:NSTextAlignmentRight];
        }
            break;
        case 0:
        {
            [_midiaPic setHidden:YES];
            
            [_chatImage setHidden:YES];
            [_chatImage1 setHidden:YES];
            
            [_messageConent setHidden:NO];
            [_messageConent setFrame:CGRectMake(2*INSETS+HEAD_SIZE+15, (CELL_HEIGHT-textSize.height)/2, textSize.width, textSize.height)];
            [_userHead setFrame:CGRectMake(INSETS, _messageConent.frame.origin.y+_messageConent.frame.size.height-30,HEAD_SIZE , HEAD_SIZE)];
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"篮框(1).png"]stretchableImageWithLeftCapWidth:18 topCapHeight:18]];
            _bubbleBg.frame=CGRectMake(_messageConent.frame.origin.x-15, _messageConent.frame.origin.y-10, textSize.width+25, textSize.height+15);
            //            _timeConent.text=@"11111";
            
            [_timeConent setFrame:CGRectMake(_messageConent.frame.origin.x-15,_bubbleBg.frame.size.height+_bubbleBg.frame.origin.y, 240, 30)];
            [_timeConent setTextAlignment:NSTextAlignmentLeft];
            
        }
            break;
        case 3:
        {
            if (_mideStyle==1) {
                _midiaPic.hidden=NO;
            }else{
                [_midiaPic setHidden:YES];
                
            }
            [_chatImage1 setHidden:NO];
            [_chatImage setHidden:YES];
            [_messageConent setHidden:YES];
            //            [_chatImage1 addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
            
            [_chatImage1 setFrame:CGRectMake(CELL_WIDTH-INSETS*2-HEAD_SIZE-82, (CELL_HEIGHT-100)/2, 70, 100)];
            [_userHead setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE,_chatImage1.frame.origin.y+_chatImage1.frame.size.height-30,HEAD_SIZE , HEAD_SIZE)];
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"灰（2）.png"]stretchableImageWithLeftCapWidth:18 topCapHeight:18]];
            _bubbleBg.frame=CGRectMake(_chatImage1.frame.origin.x-3, _chatImage1.frame.origin.y-6, 70+15, 100+15);
            [_midiaPic setImage:[UIImage imageNamed:@"播放.png"]];
            [_midiaPic setFrame:CGRectMake(0, 0, 50, 50)];
            _midiaPic.center=_bubbleBg.center;
            
            //            _timeConent.text=@"11111";
            
            [_timeConent setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE-5-240,_bubbleBg.frame.size.height+_bubbleBg.frame.origin.y, 240, 30)];
            [_timeConent setTextAlignment:NSTextAlignmentRight];
            
            
        }
            break;
        case 2:
        {
            if (_mideStyle==1) {
                _midiaPic.hidden=NO;
            }else{
                [_midiaPic setHidden:YES];
                
            }
            [_chatImage setHidden:YES];
            [_chatImage1 setHidden:NO];
            [_messageConent setHidden:YES];
            [_chatImage1 setFrame:CGRectMake(2*INSETS+HEAD_SIZE+15, (CELL_HEIGHT-100)/2,70,100)];
            [_userHead setFrame:CGRectMake(INSETS,_chatImage1.frame.origin.y+_chatImage1.frame.size.height-30,HEAD_SIZE , HEAD_SIZE)];
            
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"篮框(1).png"]stretchableImageWithLeftCapWidth:18 topCapHeight:18]];
            
            _bubbleBg.frame=CGRectMake(_chatImage1.frame.origin.x-10, _chatImage1.frame.origin.y-6, 70+15, 100+15);
            //            _timeConent.text=@"11111";
            [_midiaPic setImage:[UIImage imageNamed:@"播放.png"]];
            [_midiaPic setFrame:CGRectMake(0, 0, 50, 50)];
            _midiaPic.center=_bubbleBg.center;
            [_timeConent setFrame:CGRectMake(_chatImage1.frame.origin.x-10,_bubbleBg.frame.size.height+_bubbleBg.frame.origin.y, 200, 30)];
            [_timeConent setTextAlignment:NSTextAlignmentLeft];
            
            
        }
            break;
        default:
            break;
    }
    
    _headMask.frame=CGRectMake(_userHead.frame.origin.x-3, _userHead.frame.origin.y-1, HEAD_SIZE+6, HEAD_SIZE+6);
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
-(void)assembleMessageAtIndex:(NSArray *)arr
{
    
//    UIView *returnView = [[UIView alloc] init]  ;
    
    NSArray *data = [[NSArray alloc]initWithArray:arr] ;
    UIFont *fon= [UIFont systemFontOfSize:16];
	CGFloat upX=0;
    CGFloat upY=0;
	if (data) {
		for (int i=0;i<[data count];i++) {
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"]&&[self bubbleBg:str])
            {
                if (upX > 206)
                {
                    upY = upY + 17+3;
                    upX = 0;
                }
				NSString *yaoxi=[str substringWithRange:NSMakeRange(0, str.length)];
                NSString * imageName=[self bubbleBgName:yaoxi];
				UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString  stringWithFormat:@"%@.png",imageName]]];
                img.frame = CGRectMake(upX, upY, 19, 20);
                [_messageConent addSubview:img];
                [img release];
				upX=17+upX+3;
                
			}else
            {
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > 206)
                    {
                        upY = upY + 17+3;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(206, 20)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    la.backgroundColor=[UIColor clearColor];
                    la.textAlignment=NSTextAlignmentRight;
                    la.font = fon;
                    la.text = temp;
                    [_messageConent addSubview:la];
                    [la release];
                    upX=upX+size.width;
                }
			}
        }
	}
    if (upY>0) {
        [_messageConent setFrame:CGRectMake(0, 0, 213, upY+17+3)];

    }else{
        if (upX<20) {
            [_messageConent setFrame:CGRectMake(0, 0, 20, upY+17+3)];

        }else{
            [_messageConent setFrame:CGRectMake(0, 0, upX, upY+17+3)];

        }
    }
    [data release];
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
-(void)setMessageObject:(NSString *)aMessage
{

    [_timeConent setText:aMessage];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc
{
    [super dealloc];
    _faceMap=nil ;
    _faceMessage=nil;
    [_messageConent release];

}
@end
