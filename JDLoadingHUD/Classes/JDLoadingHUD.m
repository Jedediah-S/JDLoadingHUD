//
//  JDLoadingHUD.m
//  JDLoadingHUD
//
//  Created by My Mac on 2019/5/7.
//  Copyright © 2019年 Jedediah. All rights reserved.
//

#import "JDLoadingHUD.h"

#define loadingDuration 0.2
#define loadingColor [UIColor colorWithRed:84/255.0 green:117/255.0 blue:207/255.0 alpha:1]

@implementation JDLoadingHUD

#pragma mark - Class methods
+ (instancetype)showLoadingView{
    
    return [self showLoadingToView:nil];
}
+ (instancetype)showLoadingToView:(UIView *)view{
    
    return [self showLoadingToView:view hadBgView:YES];
}
+ (instancetype)showLoadingToView:(UIView *)view hadBgView:(BOOL)hadBg{
    
    if(view == nil){
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    JDLoadingHUD *hud = [[self alloc] initWithFrame:CGRectMake(0, 0, 90, 80)];
    hud.center = view.center;
    hud.backgroundView.hidden = !hadBg;
    hud.alpha = 0;
    [UIView animateWithDuration:loadingDuration animations:^{
        hud.alpha = 1;
    }];
    [view addSubview:hud];
    return hud;
}

+ (void)removeLoadingView{
    
    [self removeLoadingToView:nil];
}
+ (void)removeLoadingToView:(UIView *)view{
    
    if(view == nil){
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    JDLoadingHUD *hud;
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            hud = (JDLoadingHUD *)subview;
        }
    }
    
    [UIView animateWithDuration:loadingDuration animations:^{
        hud.alpha = 0;
    } completion:^(BOOL finished) {
        [hud removeFromSuperview];
    }];
}

#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.itemsView = [NSMutableArray array];
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.layer.cornerRadius = 10;
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroundView];
        
        self.contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.contentView];
        
        CGSize selfSize = self.bounds.size;
        UIView *aniView = [self addAnimationItemViewWithCenter:CGPointMake(selfSize.width/2-16, selfSize.height/2)];
        [aniView.layer addAnimation:[self getAnimationWithFromValue:@(40) toValue:@(10) duration:0.3] forKey:@"kLoadingAnimationLeft"];
        [self.contentView addSubview:aniView];
        [self.itemsView addObject:aniView];
        
        UIView *aniView1 = [self addAnimationItemViewWithCenter:CGPointMake(selfSize.width/2, selfSize.height/2)];
        [self.contentView addSubview:aniView1];
        [self.itemsView addObject:aniView1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [aniView1.layer addAnimation:[self getAnimationWithFromValue:@(10) toValue:@(35) duration:0.3] forKey:@"kLoadingAnimationMiddle"];
        });
        
        UIView *aniView2 = [self addAnimationItemViewWithCenter:CGPointMake(selfSize.width/2+16, selfSize.height/2)];
        [aniView2.layer addAnimation:[self getAnimationWithFromValue:@(10) toValue:@(40) duration:0.3] forKey:@"kLoadingAnimationRight"];
        [self.contentView addSubview:aniView2];
        [self.itemsView addObject:aniView2];
    }
    return self;
}

// 添加view
- (UIView *)addAnimationItemViewWithCenter:(CGPoint)center{
    
    UIView *aniView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
    aniView.backgroundColor = loadingColor;
    aniView.layer.cornerRadius  = 1.5;
    aniView.layer.masksToBounds = YES;
    aniView.center = center;
    return aniView;
}

// 创建动画
- (CABasicAnimation *)getAnimationWithFromValue:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration{
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
    basicAnimation.fromValue = fromValue;
    basicAnimation.toValue = toValue;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];;
    basicAnimation.duration = duration;
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.autoreverses = YES;
    basicAnimation.removedOnCompletion = NO;
    return basicAnimation;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
