//
//  CollectionFooterView.m
//  IOS_mid
//
//  Created by 车春江 on 2020/11/23.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionFooterView.h"

@interface CollectionFooterView()

@end

@implementation CollectionFooterView

//- (ClockInView*) init{
//    NSLog(@"2");
//    if(self=[super initWithFrame:CGRectMake(10, 50, 100, 60)]){
//        [self setupUI];
//        [self layout];
//    }
//    return self;
//}

- (CollectionFooterView*)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        [self setupUI:frame];
        [self layout];
    }
    return self;
}

- (void)setupUI:(CGRect)frame{
    
}

- (void)layout{
 
}


@end

