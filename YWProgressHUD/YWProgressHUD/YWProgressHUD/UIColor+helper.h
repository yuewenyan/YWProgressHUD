//
//  UIColor+helper.h
//  UIColor+helper
//
//  Created by yanyuewen on 14-2-9.
//  Copyright (c) 2014年 yanyuewen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "colorModel.h"
//@class colorModel;
@interface UIColor (helper)

+ (UIColor *) textGrayColor;
+ (UIColor *) themeColor;
+ (UIColor *) colorWithHexString: (NSString *)color;//完全不透明
+ (UIColor *) colorWithHexString: (NSString *)color withAlpha:(CGFloat)alpha;
+ (colorModel *) RGBWithHexString: (NSString *)color withAlpha:(CGFloat)alpha;

@end
