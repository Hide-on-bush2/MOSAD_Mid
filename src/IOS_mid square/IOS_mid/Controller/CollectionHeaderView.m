//
//  CollectionHeaderView.m
//  IOS_mid
//
//  Created by 车春江 on 2020/11/23.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionHeaderView.h"

@interface CollectionHeaderView()
//@property(nonatomic,strong) UISearchBar* searchBar;
@end

@implementation CollectionHeaderView

//- (ClockInView*) init{
//    NSLog(@"2");
//    if(self=[super initWithFrame:CGRectMake(10, 50, 100, 60)]){
//        [self setupUI];
//        [self layout];
//    }
//    return self;
//}

- (CollectionHeaderView*)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        [self setupUI:frame];
        [self layout];
    }
    return self;
}

- (void)setupUI:(CGRect)frame{
    self.searchBar = [[UISearchBar alloc]initWithFrame:frame];
//    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入文字...";
}

- (void)layout{
    [self addSubview:self.searchBar];
}


@end

