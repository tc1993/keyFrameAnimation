//
//  CCKeyFrameAnimationView.h
//  oupai
//
//  Created by tc on 12/26/17.
//  Copyright © 2017 yizhibo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 关键帧动画 view
 */
@interface CCKeyFrameAnimationView : UIView
@property (nullable, nonatomic, copy) NSArray<UIImage *> *animationImages;
@property (nonatomic) NSTimeInterval animationDuration;
@property (nonatomic) NSInteger      animationRepeatCount;

@property(nonatomic, readonly, getter=isAnimating) BOOL animating;

- (void)startAnimating;
- (void)stopAnimating;
@end
