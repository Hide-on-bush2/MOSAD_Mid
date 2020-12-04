//
//  CommentCell.m
//  IOS_mid
//
//  Created by 车春江 on 2020/11/24.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentCell.h"
#import <Masonry.h>

@interface CommentCell()

@end

@implementation CommentCell

- (CommentCell*)initWithFrame:(CGRect)frame{
    NSLog(@"1");
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        [self setupUI:frame];
        [self layout];
    }
    return self;
}

- (CommentCell*)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.accessoryType = 1;//右箭头
//        //让cell的分割线 去掉左边距
//        self.separatorInset = UIEdgeInsetsZero;
        [self setupUI:CGRectMake(0, 0, 0, 0)];
        [self layout];
    }
    return self;
}

- (void)setupUI:(CGRect)frame{
    self.comment_text = [[UILabel alloc]init];
    self.comment_text.text = @"text";
    self.comment_text.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.comment_text];
}

- (void)layout{
    [self.comment_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).mas_offset(5);
        make.left.equalTo(self.mas_left).mas_offset(5);
        make.right.equalTo(self.mas_right).mas_offset(5);
    }];
}


@end
