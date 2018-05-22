//
//  TabBarController.m
//  EnlargeAniTabBar
//
//  Created by paperclouds on 2018/5/16.
//  Copyright © 2018年 hechang. All rights reserved.
//

#import "TabBarController.h"
#import <objc/runtime.h>
#import "TBCityIconFont.h"
#import "BaseNavigationController.h"
#import "UIImage+TBCityIconFont.h"

#define UIColorFromRGB(rgbValue)    [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UNSelect_Color UIColorFromRGB(0x808080)
#define Selected_Color UIColorFromRGB(0x0099ff)

@interface TabBarController ()

@property (nonatomic, copy) NSArray *titleArray; //按钮标题
@property (nonatomic, copy) NSArray *iconArray; //按钮图标
@property (nonatomic, copy) NSArray *controllersArray; //控制器
@property (nonatomic, assign) NSInteger currentIndex; //当前选中下标

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setViewControllers:[self getViewControllers] animated:YES];
    self.selectedIndex = 0;
}

- (NSArray *)getViewControllers{
    self.titleArray = @[@"首页",@"分类",@"订单",@"我的"];
    self.iconArray = @[@"\U0000e688",@"\U0000e689",@"\U0000e68e",@"\U0000e68a"];
    self.controllersArray = @[@"HomeViewController",@"CategoryViewController",@"OrderViewController",@"MyViewController"];
    NSMutableArray *navArray = [NSMutableArray array];
    for (int i = 0; i < self.controllersArray.count; i++) {
        const char *className = [self.controllersArray[i] cStringUsingEncoding:NSASCIIStringEncoding];
        Class newClass = objc_getClass(className);
        UIViewController *controller = [newClass new];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:controller];
        controller.title = self.titleArray[i];
        
        UITabBarItem *tabbar = [[UITabBarItem alloc]initWithTitle:self.titleArray[i] image:[UIImage iconWithInfo:TBCityIconInfoMake(_iconArray[i], 22, UNSelect_Color)] selectedImage:[UIImage iconWithInfo:TBCityIconInfoMake(_iconArray[i], 22, Selected_Color)]];
    // 设置未选中文字颜色
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UNSelect_Color,NSForegroundColorAttributeName,[UIFont systemFontOfSize:10],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    // 设置选中文字颜色
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Selected_Color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
        controller.tabBarItem = tabbar;
        [navArray addObject:nav];
    }
    return navArray;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != _currentIndex) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (int i = 1; i < self.tabBar.subviews.count-1; i++) {
            UIButton *btn = self.tabBar.subviews[i];
            [arry addObject:btn.subviews.firstObject];
        }
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"transform.scale";
        animation.values = @[@1.0,@1.2,@0.8,@1.0];
        animation.duration = 0.3;
        animation.calculationMode = kCAAnimationCubic;
        
        [[arry[index] layer] addAnimation:animation forKey:nil];
        _currentIndex = index;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
