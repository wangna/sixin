//
//  FacialView.m
//  KeyBoardTest
//
//  Created by wangqiulei on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacialView.h"


@implementation FacialView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        faces=[EmojiEmoticons allEmoticons];
//        faces=[Emoji allEmoji];
//        faces=[EmojiPictographs allPictographs];
    }
    return self;
}

-(void)loadFacialView:(int)page size:(CGSize)size
{
    NSLog(@"page=%d",page);
       _faceMap = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_en" ofType:@"plist"]]retain];
        _faceMessage = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_ch" ofType:@"plist"]]retain];
	//row number
    if (page==0) {
   
	for (int i=0; i<5; i++) {
		//column numer
		for (int y=0; y<7; y++) {
			UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setFrame:CGRectMake(y*(size.width+14), i*(size.height+7), size.width, size.height)];
            if (i==4&&y==6) {
                
                [button setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
                button.tag=10000;
                
            }else{
                
            
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"0%d",7*i+y]] forState:UIControlStateNormal];

                
                
            

                button.tag=7*i+y;
                
            }
			[button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
		}
    }
	}else{
    	for (int i=0; i<4; i++) {
            //column numer
            for (int y=0; y<7; y++) {
                UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundColor:[UIColor clearColor]];
                [button setFrame:CGRectMake(y*(size.width+14), i*(size.height+7), size.width, size.height)];
                if (i>2) {
                    [button setFrame:CGRectMake(6*(size.width+14), i*(size.height+7), size.width, size.height)];

                    [button setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
                    button.tag=10000;
                    [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:button];
                    break;
                    
                    
                }else{
                    
                    
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"0%d",7*i+34+y]] forState:UIControlStateNormal];
                    
                    
                    
                    
                    
                    button.tag=7*i+y+34;
                    [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:button];
                    
                }

            }
        }
    
    }
}


-(void)selected:(UIButton*)bt
{
    if (bt.tag==10000) {
        NSLog(@"点击删除");
        [delegate selectedFacialView:@"删除"];
    }else{
        NSString *str=nil;
        for (int i=0; i<[[_faceMap allKeys] count]; i++) {
            if ([[_faceMap objectForKey:[[_faceMap allKeys] objectAtIndex:i] ] isEqualToString:[NSString stringWithFormat:@"0%d",bt.tag]]) {
                str= [[_faceMap allKeys] objectAtIndex:i];
                
            
            }
        }
        
        [delegate selectedFacialView:[_faceMessage objectForKey:str]];
    }	
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/
- (void)dealloc {
    [super dealloc];
}
@end
