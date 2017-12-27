//
//  ViewController.m
//  test
//
//  Created by tc on 12/14/17.
//  Copyright © 2017 tttt. All rights reserved.
//

#import "ViewController.h"

#import "CCKeyFrameAnimationView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) CCKeyFrameAnimationView * animationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _animationView = [[CCKeyFrameAnimationView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_animationView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)beginAnimation:(UIButton *)sender {
    
    BOOL isImageViewAnimation = sender.tag == 2;
    __block NSMutableArray * imageArray = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @autoreleasepool{
            for (int i = 1; i<66; i++) {
                
                NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"img%d",i] ofType:@"png"];
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        
                if (image) {
                    [imageArray addObject:image];
                }
            }
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!isImageViewAnimation) {
                //优化的动画
                _animationView.animationImages = imageArray;
                _animationView.animationDuration = 8;
                _animationView.animationRepeatCount = 1;
                [_animationView startAnimating];
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.imageView stopAnimating];
                    self.imageView.animationImages = nil;
                });
                //系统帧动画
                self.imageView.animationImages = imageArray;
                self.imageView.animationDuration = 8;
                self.imageView.animationRepeatCount = 1;
                [self.imageView startAnimating];
            }
            
        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

