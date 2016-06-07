//
//  UIView+Frame.h
//  UIView+Frame
//
//  Created by 闫跃文 on 15/12/7.
//  Copyright © 2015年 yanyuewen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// 如果@property在分类里面使用只会自动声明get,set方法,不会实现,并且不会帮你生成成员属性
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign, readonly, getter = rightX) CGFloat rightX;
@property (nonatomic, assign, readonly, getter = bottomY) CGFloat bottomY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat cornerRadius;

@end
