//
//  MineVC.m
//  IOS_mid
//
//  Created by jinshlin on 2020/11/20.
//  Copyright © 2020 车春江. All rights reserved.
//

#import "MineVC.h"
#import "AlbumVC.h"
#import "MoviesVC.h"

#import "UserInfo.h"

#import "Masonry.h"
#import "AFNetworking.h"

@interface MineVC ()


@end

@implementation MineVC 

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    UIColor *my_gray_color = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:100];
    UIColor *my_purple_color = [UserInfo singleInstance].color;
    
    self.navigationController.navigationBar.barTintColor = my_purple_color;
    
    UIButton *album = [[UIButton alloc] init];
    [album setTitle:@"相册" forState:UIControlStateNormal];
    album.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [album setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [album setBackgroundColor: [UIColor orangeColor]];
    album.layer.cornerRadius = 10;
    
    album.showsTouchWhenHighlighted = YES;
    
    [album addTarget:self action:@selector(AlbumTo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:album];
    
    UIButton *movies = [[UIButton alloc] init];
    [movies setTitle:@"电影" forState:UIControlStateNormal];
    movies.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [movies setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [movies setBackgroundColor: my_gray_color];
    movies.layer.cornerRadius = 10;
    
    movies.showsTouchWhenHighlighted = YES;
    
    [movies addTarget:self action:@selector(MoviesTo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:movies];
    
    
    
    //位置约束
    [album mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30);
        make.top.equalTo(self.view).with.offset(200);
        make.right.equalTo(self.view).with.offset(-20);
        //make.bottom.equalTo(reg.mas_top).offset(-10);
        
        make.height.mas_equalTo(50);
    }];
    
    [movies mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(album.mas_left);
        make.top.equalTo(album.mas_bottom).offset(80);
        make.right.equalTo(album.mas_right);
        
        make.height.mas_equalTo(50);
    }];
    

}

- (void)AlbumTo:(UIButton *)btn{
    AlbumVC *vc = [[AlbumVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)MoviesTo:(UIButton *)btn{
    MoviesVC *vc = [[MoviesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
