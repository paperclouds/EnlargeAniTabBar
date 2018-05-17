//
//  TBCityIconInfo.h
//  NeiSha
//
//  Created by paperclouds on 2017/10/23.
//  Copyright © 2017年 neisha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TBCityIconInfo : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color;
+ (instancetype)iconInfoWithText:(NSString *)text size:(NSInteger)size color:(UIColor *)color;

@end

