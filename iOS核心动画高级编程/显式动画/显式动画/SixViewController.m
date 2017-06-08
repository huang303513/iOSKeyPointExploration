//
//  SixViewController.m
//  
//
//  Created by maiyun on 15/6/26.
//
//

#import "SixViewController.h"

@interface SixViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSArray *images;
@end

@implementation SixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.images = @[[UIImage imageNamed:@"Anchor.png"],
                    [UIImage imageNamed:@"Cone.png"],
                    [UIImage imageNamed:@"Igloo.png"],
                    [UIImage imageNamed:@"Spaceship.png"]];

}

- (IBAction)switchImage:(id)sender {
    [UIView transitionWithView:self.imageView duration:1.5 options:UIViewAnimationOptionTransitionFlipFromTop|UIViewAnimationOptionTransitionCrossDissolve animations:^{
        UIImage *currentImage = self.imageView.image;
        NSUInteger index = [self.images indexOfObject:currentImage];
        index = (index + 1)%[self.images count];
        self.imageView.image = self.images[index];
    } completion:^(BOOL finished) {
        
    }];
    
    
}


@end
