//
//  LBProgressHUD.h
//  LuckyBuy
//
//  Created by huangtie on 16/3/9.
//  Copyright © 2016年 Qihoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWProgressHUD : UIView

@property (nonatomic , copy) NSString *lableText;   ///<  标题文本

@property (nonatomic , assign) BOOL showMask; ///<  灰暗背景

/**
 *  提示框显示
 *
 *  @param animated 是否有动画效果
 */
- (void)show:(BOOL)animated;

/**
 *  提示框隐藏
 *
 *  @param animated 是否有动画效果
 */
- (void)hide:(BOOL)animated;

+ (instancetype)showHUDto:(UIView *)view animated:(BOOL)animated NS_DEPRECATED_IOS(1_0, 1_0, "Use -showHUD:animated:");

+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated NS_DEPRECATED_IOS(1_0, 1_0, "Use -showHUD:text:animated:");

+ (instancetype)showHUDto:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated NS_DEPRECATED_IOS(1_0, 1_0, "Use -hideAllHUD:animated:");

#pragma mark - New Show And Hide
+ (instancetype)showHUD:(UIView *)view animated:(BOOL)animated;

+ (instancetype)showHUD:(UIView *)view text:(NSString *)text animated:(BOOL)animated;

+ (void)hideAllHUD:(UIView *)view animated:(BOOL)animated;

@end
