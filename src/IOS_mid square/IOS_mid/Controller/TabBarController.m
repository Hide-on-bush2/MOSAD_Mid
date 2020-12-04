//
//  TabBarController.m
//  IOS_mid
//
//  Created by 车春江 on 2020/11/19.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabBarController.h"
#import "HomepageViewController.h"
#import "SetUpViewController.h"
#import "SquareViewController.h"


@interface TabBarController()
@property (strong, nonatomic) SquareViewController* view1;
@property (strong, nonatomic) HomepageViewController* view2;
@property (strong, nonatomic) SetUpViewController* view3;
//- (id)init;
@end

@implementation TabBarController

//- (id)init{
//    self = [super init];
//    return self;
//}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _view1 = [[SquareViewController alloc]init];
    UINavigationController* view1 = [[UINavigationController alloc]initWithRootViewController:_view1];
    view1.title = @"广场";
    view1.tabBarItem.image = [UIImage imageNamed:@"square"];
    [view1.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,20)];
    view1.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    [self addChildViewController:view1];


    _view2 = [[HomepageViewController alloc]init];
    UINavigationController* view2 = [[UINavigationController alloc]initWithRootViewController:_view2];
    view2.tabBarItem.title = @"个人主页";
    view2.tabBarItem.image = [UIImage imageNamed:@"homepage"];
    [view2.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,20)];
    view2.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
//    view1.tabBarItem.image = [UIImage imageNamed:@"apple"];
    [self addChildViewController:view2];
    
    _view3 = [[SetUpViewController alloc]init];
    UINavigationController* view3 = [[UINavigationController alloc]initWithRootViewController:_view3];
    view3.tabBarItem.title = @"设置中心";
    view3.tabBarItem.image = [UIImage imageNamed:@"setup"];
    [view3.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,20)];
    view3.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
//    view1.tabBarItem.image = [UIImage imageNamed:@"apple"];
    [self addChildViewController:view3];
    

    
}

@end
