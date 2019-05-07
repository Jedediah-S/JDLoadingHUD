//
//  JDLoadingHUD.h
//  JDLoadingHUD
//
//  Created by My Mac on 2019/5/7.
//  Copyright © 2019年 Jedediah. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDLoadingHUD : UIView

@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) NSMutableArray *itemsView;

+ (instancetype)showLoadingView;
+ (instancetype)showLoadingToView:(UIView *__nullable)view;
+ (instancetype)showLoadingToView:(UIView *__nullable)view hadBgView:(BOOL)hadBg;

+ (void)removeLoadingView;
+ (void)removeLoadingToView:(UIView *__nullable)view;

@end

NS_ASSUME_NONNULL_END
