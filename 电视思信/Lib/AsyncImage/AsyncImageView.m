//
//  AsyncImageView.M
//  Musiline
//
//  Created by fuacici on 10-5-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AsyncImageView.h"




static const NSString * gDefaultImages[]=
{
	@"16.png",@""
};
#define SPINNY_TAG 5555

@implementation AsyncImageView
@synthesize  urlString; 
@synthesize defaultImage;
@synthesize manager;
@synthesize selectedRow;
@synthesize selectedSection;
@synthesize isImage;
@synthesize autoImage;
@synthesize imageViewBorderWidth;
@synthesize imageViewBorderColor;
@synthesize imageViewCornerRadius;
@synthesize imageViewMasksToBounds;
@synthesize chatImage;
@synthesize MessageStr;
- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) 
	{
		self.manager = [ImageManager sharedImageManager];
        self.chatImage=0;
	}
    return self;
}
- (void)awakeFromNib
{
	[super awakeFromNib];
	self.manager = [ImageManager sharedImageManager];
}
- (void) setUrlString:(NSString *) theUrl
{
	if ([urlString isEqualToString: theUrl ]) 
	{
		return;
	}
	[manager removeTarget: self forUrl: urlString];
	[urlString release];
	urlString = nil;
	[self imageDidLoaded: nil animate: NO];
	if (nil == theUrl) 
	{
		
		return;
	}
	urlString = [theUrl retain];
	if (nil == theUrl) 
	{
		
		return;
	}
	// setup the spiner
	UIActivityIndicatorView *spinny = (UIActivityIndicatorView *) [self viewWithTag: SPINNY_TAG];
	
	if (nil == spinny) 
	{
		spinny = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]autorelease];
	}
	
	spinny.tag = SPINNY_TAG;
	spinny.center = CGPointMake(self.center.x -self.frame.origin.x, self.center.y- self.frame.origin.y);
	[spinny startAnimating];
	[self addSubview:spinny];
    [manager addTaskWithURLString: urlString
                     withDelegate: self];
//    [self performSelector:@selector(hhh) withObject:self afterDelay:0.001];
}
-(void)hhh
{
	[manager addTaskWithURLString: urlString
                     withDelegate: self];


}


- (void)dealloc 
{
	[manager removeTarget: self forUrl: urlString];
	self.manager = nil;
	self.urlString = nil;
	[imageView release];
	imageView = nil;
	[super dealloc];
}

- (void)setImage:(UIImage*) _image animate: (BOOL) animate
{
	//remove the spinner first

	if (autoImage==YES) {
				
		
		if (_image.size.width<=250&&_image.size.height<300) {
			self.bounds=CGRectMake(self.frame.origin.x, self.frame.origin.y, _image.size.width, _image.size.height);
		}else if (_image.size.width>250) {
			self.bounds=CGRectMake(self.frame.origin.x, self.frame.origin.y, 250, 250*(_image.size.height/_image.size.width));
		}else if (_image.size.height>300) {
			self.bounds=CGRectMake(self.frame.origin.x, self.frame.origin.y, 300*(_image.size.width/_image.size.height), 300);
		}
		
		CGAffineTransform  affineTransform1=CGAffineTransformMakeScale(0.1, 0.1);
		CGAffineTransform  affineTransform2=CGAffineTransformMakeScale(1, 1);

		[self setTransform:affineTransform1];
		[UIView beginAnimations:@"zfAnimations" context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[self setTransform:affineTransform2];
		[UIView commitAnimations];
		
	}
	UIView * _spinny = [self viewWithTag:SPINNY_TAG];
	[_spinny removeFromSuperview];
	
	//set the image

	if (nil == imageView) 
	{
		imageView = [[UIImageView alloc] initWithImage: _image] ;
		//imageView.userInteractionEnabled=YES;
		[self insertSubview: imageView atIndex:0];
	}else
	{
		imageView.image = _image;
	}
	
	imageView.tag = 2;
	imageView.frame = self.bounds;
	imageView.layer.borderColor=imageViewBorderColor.CGColor;
	imageView.layer.borderWidth=imageViewBorderWidth;
	imageView.layer.cornerRadius = imageViewCornerRadius;
	imageView.layer.masksToBounds = imageViewMasksToBounds;
	
	if (animate)
	{
		CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
		animation.fromValue = [NSNumber numberWithFloat:0.0f];
		animation.toValue = [NSNumber numberWithFloat:1.0f];
		animation.duration = 0.5f;
		animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
		[self.layer addAnimation: animation forKey: @"FadeIn"];
	}
	
	[imageView setNeedsLayout];
	[self setNeedsLayout];
}
- (void)setImage:(UIImage*) _image
{
	[self setImage: _image animate: NO];
}



- (UIImage*) image
{
    UIImageView* iv = imageView;
    return [iv image];
}
-(void)imageDidLoaded:(UIImage*) _image animate:(BOOL) animate
{

	
	if (nil == _image)
	{
        if (self.chatImage==0) {
            [self setImage: [UIImage imageNamed:  (NSString *) gDefaultImages[defaultImage] ]];

        }
        if (self.chatImage==1) {
            [self setImage: [UIImage imageNamed:@"缓冲.png"]];

        }
		return;
	}
	
	[self setImage: _image animate:  animate];
	
}
- (void)layoutSubviews
{
	[super layoutSubviews];
	imageView.frame = self.bounds;
	UIActivityIndicatorView * spinny = (UIActivityIndicatorView *) [self viewWithTag: SPINNY_TAG];
	spinny.center = CGPointMake(self.center.x -self.frame.origin.x, self.center.y- self.frame.origin.y);
	

}




@end
