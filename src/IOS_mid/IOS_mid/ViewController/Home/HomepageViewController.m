//
//  HomepageViewController.m
//  IOS_mid
//
//  Created by 车春江 on 2020/11/19.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomepageViewController.h"
#import "MineVC.h"
#import "OthersVC.h"
#import "LLSegmentBarVC.h"

@interface HomepageViewController ()
@property (nonatomic,weak) LLSegmentBarVC * segmentVC;

@end

@implementation HomepageViewController

#pragma mark - segmentVC
- (LLSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        LLSegmentBarVC *vc = [[LLSegmentBarVC alloc]init];
            // 添加到到控制器
        [self addChildViewController:vc];
        _segmentVC = vc;
    }
    return _segmentVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavItem];
    
}
#pragma mark - 定制导航条内容
- (void) customNavItem {
    self.navigationItem.title = @"个人主页";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
        // 1 设置segmentBar的frame
    self.segmentVC.segmentBar.frame = CGRectMake(100, 0, UIScreen.mainScreen.bounds.size.width-200, 35);
    self.navigationItem.titleView = self.segmentVC.segmentBar;
        // 2 添加控制器的View
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    NSArray *items = @[@"我的", @"关注"];
    MineVC *mine = [[MineVC alloc] init];
    OthersVC *follow = [[OthersVC alloc] init];
        // 3 添加标题数组和控住器数组
    [self.segmentVC setUpWithItems:items childVCs:@[mine,follow]];
        // 4  配置基本设置  可采用链式编程模式进行设置
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemNormalColor([UIColor whiteColor]).itemSelectColor([UIColor blackColor]).indicatorColor([UIColor purpleColor]);
    }];
}
@end
