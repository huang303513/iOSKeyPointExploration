//
//  UrlImageButton.m
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UrlImageButton.h"
#import "SDWebImageManager.h"
#import "NSURLAdditions.h"

@interface UrlImageButton () <SDWebImageManagerDelegate>

@end

@implementation UrlImageButton

@synthesize iconIndex;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
		iconIndex = -1;

		isScale = NO;
    
	}
    return self;
}


- (void)setImage:(BOOL)animated withUrl:(NSString *)iconUrl withIsBkg:(BOOL)isBkg
{       
	_animated = animated;
	_isBackgroundImage = isBkg;
	
	if(isBkg)
	{
		[self setBackgroundImage:[self getDefaultImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[self getDefaultImage] forState:UIControlStateSelected];
        [self setBackgroundImage:[self getDefaultImage] forState:UIControlStateHighlighted];
	}
	else {
		[self setImage:[self getDefaultImage] forState:UIControlStateNormal];
        [self setImage:[self getDefaultImage] forState:UIControlStateSelected];
        [self setImage:[self getDefaultImage] forState:UIControlStateHighlighted];
	}

	NSURL* tempUrl = [NSURL URLWithString:iconUrl];
	
	NSURL* finallyUrl = nil;
	if([NSURL isWebURL:tempUrl])
	{
		finallyUrl = tempUrl;
	}
	else {
		finallyUrl = [NSURL URLWithString:iconUrl];
	}
	
	[self setImageWithURL:finallyUrl];
}	

- (void) setBackgroundImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl
{       
	[self setImage:animated withUrl:iconUrl withIsBkg:YES];
}	

- (void) setImageFromUrl:(BOOL) animated withUrl:(NSString *)iconUrl
{       
	
	[self setImage:animated withUrl:iconUrl withIsBkg:NO];
}	

	
- (void)setImageWithURL:(NSURL *)url
{
	[self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
	SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:url options:SDWebImageLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [self setImage:image forState:UIControlStateNormal];
    }];
}

- (void)cancelCurrentImageLoad
{
//#warning 改
    //[[SDWebImageManager sharedManager] cancelForDelegate:self];
}

-(UIImage*) getDefaultImage
{
	CGSize frameSize = self.frame.size;
	if(frameSize.width ==96&&frameSize.height==63)
	{
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	else if(frameSize.width ==100&&frameSize.height==66){
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	else if(frameSize.width ==160&&frameSize.height==106){
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	else if(frameSize.width ==310&&frameSize.height==206){
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	else if(frameSize.width ==94&&frameSize.height==70){
		return [UIImage  imageNamed:@"rr_side.png"];
	}
	return nil;

}



#pragma mark -

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
//	if(_animated)
//	{
//	    [UIView beginAnimations:nil context:nil];
//	    [UIView setAnimationDuration:0.5];
//	    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
//	}
	
	if(_isBackgroundImage)
	{
	    [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setBackgroundImage:image forState:UIControlStateSelected];
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
	}
	else {
		[self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateSelected];
        [self setImage:image forState:UIControlStateHighlighted];
	}

//	if(_animated)
//	{
//		[UIView commitAnimations];
//	}
}

@end
