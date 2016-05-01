//
// Copyright (c) 2013 Related Code - http://relatedcode.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ProgressHUD.h"

@implementation ProgressHUD

@synthesize window, hud, spinner, image, label, viewBg;

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (ProgressHUD *)shared
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	static dispatch_once_t once = 0;
	static ProgressHUD *progressHUD;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	dispatch_once(&once, ^{ progressHUD = [[ProgressHUD alloc] init]; });
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return progressHUD;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)dismiss
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[self shared] hudHide];
}

#pragma mark 显示图片动画
+ (void)showAnimationImages
{
    [[self shared] hudAnimation];
}

+ (void)viewUserInteractionEnabledStatus:(BOOL)status
{
    ProgressHUD *progressHUD = [self shared];
    progressHUD.viewBg.userInteractionEnabled = status;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)show:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[self shared] hudMake:status imgage:nil spin:YES hide:NO];
}

+ (void)showToHidden:(NSString *)status withIsSuccess:(BOOL)isSuccess
{
    UIImage *img;
    if (!isSuccess) {
        img = HUD_IMAGE_ERROR;
    } else {
        img = HUD_IMAGE_SUCCESS;
    }
    [[self shared] hudMake:status imgage:img spin:NO hide:YES];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showSuccess:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[self shared] hudMake:status imgage:HUD_IMAGE_SUCCESS spin:NO hide:YES];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showError:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[self shared] hudMake:status imgage:HUD_IMAGE_ERROR spin:NO hide:YES];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)init
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([delegate respondsToSelector:@selector(window)])
		window = [delegate performSelector:@selector(window)];
	else window = [[UIApplication sharedApplication] keyWindow];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	hud = nil; spinner = nil; image = nil; label = nil;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.alpha = 0;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudMake:(NSString *)status imgage:(UIImage *)img spin:(BOOL)spin hide:(BOOL)hide
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self hudCreate];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	label.text = status;
	label.hidden = (status == nil) ? YES : NO;
	//---------------------------------------------------------------------------------------------------------------------------------------------
    [image.layer removeAllAnimations];
	image.image = img;
    image.animationImages = nil;
	image.hidden = (img == nil) ? YES : NO;
    
    [hud addSubview:image];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (spin) [spinner startAnimating]; else [spinner stopAnimating];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self hudOrient];
	[self hudSize];
	[self hudShow];
	//---------------------------------------------------------------------------------------------------------------------------------------------
//    if (hide) {
//        [self performSelector:@selector(hudHide) withObject:nil afterDelay:2];
//    }
	if (hide) [NSThread detachNewThreadSelector:@selector(timedHide) toTarget:self withObject:nil];
}

- (void)hudAnimation
{
    //---------------------------------------------------------------------------------------------------------------------------------------------
//    if (hud == nil) {
//        hud = [[UIView alloc] initWithFrame:CGRectZero];
//        hud.backgroundColor = HUD_BACKGROUND_COLOR;
//        hud.layer.cornerRadius = 10;
//        hud.layer.masksToBounds = YES;
//        //-----------------------------------------------------------------------------------------------------------------------------------------
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
//    }
//    if (hud.superview == nil) [window addSubview:hud];
    
    if (!viewBg) {
        viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUD_Width, HUD_Height)];
    }
    
    if (viewBg.superview == nil) {
        [window addSubview:viewBg];
    }
    viewBg.userInteractionEnabled = NO;
    
    if (image == nil) {
        image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    }
    if (image.superview == nil) [viewBg addSubview:image];
    CGRect rect = image.frame;
    rect.size = CGSizeMake(30, 30);
    image.frame = rect;
    image.center = viewBg.center;
    image.image = [UIImage imageNamed:@"loadingIcon"];
//    image.animationImages = [NSArray arrayWithObjects:
//                                      [UIImage imageNamed:@"1.png"],
//                                      [UIImage imageNamed:@"2.png"],
//                                      [UIImage imageNamed:@"3.png"],
//                                      [UIImage imageNamed:@"4.png"],
//                                      [UIImage imageNamed:@"5.png"],
//                                      [UIImage imageNamed:@"6.png"],
//                                      [UIImage imageNamed:@"7.png"],
//                                      [UIImage imageNamed:@"8.png"],nil];
    
    // all frames will execute in 1.75 seconds
//    image.animationDuration = 1.8;
    // repeat the annimation forever
    image.animationRepeatCount = 0;
    // start animating
    [self startAnimating];
    [self hudOrient];
    [self hudShow];
}

- (void)startAnimating {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5;
    //    rotationAnimation.autoreverses = YES; //从起始到结束，再从结束到起始
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;//无限循环
    [image.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudCreate
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (hud == nil)
	{
		hud = [[UIView alloc] initWithFrame:CGRectZero];
        hud.backgroundColor = HUD_BACKGROUND_COLOR;
		hud.layer.cornerRadius = 10;
		hud.layer.masksToBounds = YES;
		//-----------------------------------------------------------------------------------------------------------------------------------------
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
	}
    hud.frame = CGRectZero;
    
    if (!viewBg) {
        viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUD_Width, HUD_Height)];
    }
    
    if (viewBg.superview == nil) {
        [window addSubview:viewBg];
    }
    viewBg.userInteractionEnabled = NO;
    
	if (hud.superview == nil) [viewBg addSubview:hud];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (spinner == nil)
	{
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		spinner.color = HUD_SPINNER_COLOR;
		spinner.hidesWhenStopped = YES;
	}
    [spinner removeFromSuperview];
	if (spinner.superview == nil) [hud addSubview:spinner];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (image == nil) {
		image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
	}
    [image removeFromSuperview];
	if (image.superview == nil) [hud addSubview:image];
    
    if ([image.superview isKindOfClass:[UIWindow class]]) {
        [hud addSubview:image];
        CGRect rect = image.frame;
        rect.size = CGSizeMake(28, 28);
        image.frame = rect;
    }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (label == nil)
	{
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.font = HUD_STATUS_FONT;
		label.textColor = HUD_STATUS_COLOR;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		label.numberOfLines = 0;
	}
	if (label.superview == nil) [hud addSubview:label];
	//---------------------------------------------------------------------------------------------------------------------------------------------
//    image.backgroundColor = [UIColor redColor];
//    image.frame = CGRectMake(0, 0, 30, 30);
//    NSLog(@"%@",image.superview);
//    image.hidden = NO;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudDestroy
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	//---------------------------------------------------------------------------------------------------------------------------------------------
    [viewBg removeFromSuperview];   viewBg = nil;
	[label removeFromSuperview];	label = nil;
    [image.layer removeAllAnimations];
	[image removeFromSuperview];	image = nil;
	[spinner removeFromSuperview];	spinner = nil;
	[hud removeFromSuperview];		hud = nil;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)rotate:(NSNotification *)notification
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self hudOrient];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudOrient
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGFloat rotate = 0.0;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	UIInterfaceOrientation orient = [[UIApplication sharedApplication] statusBarOrientation];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (orient == UIInterfaceOrientationPortrait)			rotate = 0.0;
	if (orient == UIInterfaceOrientationPortraitUpsideDown)	rotate = M_PI;
	if (orient == UIInterfaceOrientationLandscapeLeft)		rotate = - M_PI_2;
	if (orient == UIInterfaceOrientationLandscapeRight)		rotate = + M_PI_2;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	hud.transform = CGAffineTransformMakeRotation(rotate);
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudSize
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGRect labelRect = CGRectZero;
	CGFloat hudWidth = 100, hudHeight = 100;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (label.text != nil)
	{
		NSDictionary *attributes = @{NSFontAttributeName:label.font};
		NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
		labelRect = [label.text boundingRectWithSize:CGSizeMake(200, 300) options:options attributes:attributes context:NULL];

		labelRect.origin.x = 12;
		labelRect.origin.y = 66;

		hudWidth = labelRect.size.width + 24;
		hudHeight = labelRect.size.height + 80;

		if (hudWidth < 100)
		{
			hudWidth = 100;
			labelRect.origin.x = 0;
			labelRect.size.width = 100;
		}
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGSize screen = [UIScreen mainScreen].bounds.size;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	hud.center = CGPointMake(screen.width/2, screen.height/2);
	hud.bounds = CGRectMake(0, 0, hudWidth, hudHeight);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGFloat imagex = hudWidth/2;
	CGFloat imagey = (label.text == nil) ? hudHeight/2 : 36;
	image.center = spinner.center = CGPointMake(imagex, imagey);
    NSLog(@"%@",NSStringFromCGPoint(image.center));
	//---------------------------------------------------------------------------------------------------------------------------------------------
	label.frame = labelRect;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudShow
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (self.alpha == 0)
	{
		self.alpha = 1;

		hud.alpha = 0;
		hud.transform = CGAffineTransformScale(hud.transform, 1.4, 1.4);

		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;

		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			hud.transform = CGAffineTransformScale(hud.transform, 1/1.4, 1/1.4);
			hud.alpha = 1;
		}
		completion:^(BOOL finished){ }];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudHide
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (self.alpha == 1)
	{
		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;

		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			hud.transform = CGAffineTransformScale(hud.transform, 0.7, 0.7);
			hud.alpha = 0;
		}
		completion:^(BOOL finished)
		{
			[self hudDestroy];
			self.alpha = 0;
		}];
	}
    [image stopAnimating];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)timedHide
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	@autoreleasepool
	{
		double length = label.text.length;
        NSTimeInterval sleep = length * 0.04 + 0.5;

		[NSThread sleepForTimeInterval:sleep];
		[self hudHide];
	}
}

@end
