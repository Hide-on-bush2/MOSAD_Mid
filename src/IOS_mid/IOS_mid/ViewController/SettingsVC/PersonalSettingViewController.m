//
//  PersonalSettingViewController.m
//  IOS_mid
//
//  Created by Khynnn on 2020/11/27.
//

#import "PersonalSettingViewController.h"
#import "UserInfo.h"

#import "Masonry.h"
#import "AFNetworking.h"

@interface PersonalSettingViewController()

@end

@implementation PersonalSettingViewController

- (void)viewDidLoad{
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    self.title = @"个性设置";
    
    [self initView];
    
}

- (void)initView{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"主题颜色";
    label.font = [UIFont systemFontOfSize:18];
    //label.textColor = [UIColor darkGrayColor];
//    label.textAlignment = UIListContentTextAlignmentCenter;
    label.textAlignment = NSTextAlignmentCenter;
    //label.layer.borderWidth = 1.0;
    //label.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.top.equalTo(self.view).with.offset(120);
    }];
    
    UIView *line = [[UIView alloc] init];
    //下划线颜色
    UIColor *my_gray_color = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:100];
    line.backgroundColor = my_gray_color;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_left);
        make.top.equalTo(label.mas_bottom).offset(5);
        make.right.equalTo(label.mas_right);
        
        make.height.mas_equalTo(1);
    }];
    
    if(_btn_1 == nil){
        _btn_1 = [[UIButton alloc] init];
        [_btn_1 setTitle:@"紫色" forState:UIControlStateNormal];
        _btn_1.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        _btn_1.layer.cornerRadius = 8;
        
        UIColor *temp = [[UserInfo singleInstance].colorArr objectAtIndex:0];
        [_btn_1 setTitleColor:temp forState:UIControlStateNormal];
        _btn_1.backgroundColor = [UIColor whiteColor];
        _btn_1.layer.borderWidth = 1.0;
        _btn_1.layer.borderColor = temp.CGColor;
        
        //_btn_1.showsTouchWhenHighlighted = YES;
        [_btn_1 addTarget:self action:@selector(event_1:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btn_1];
    }
    
    [_btn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label);
        make.top.equalTo(label.mas_bottom).offset(30);
        make.right.equalTo(label);
        
        make.height.mas_equalTo(50);
    }];
    
    if(_btn_2 == nil){
        _btn_2 = [[UIButton alloc] init];
        [_btn_2 setTitle:@"蓝色" forState:UIControlStateNormal];
        _btn_2.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        _btn_2.layer.cornerRadius = 8;
        
        UIColor *temp = [[UserInfo singleInstance].colorArr objectAtIndex:1];
        [_btn_2 setTitleColor:temp forState:UIControlStateNormal];
        _btn_2.backgroundColor = [UIColor whiteColor];
        _btn_2.layer.borderWidth = 1.0;
        _btn_2.layer.borderColor = temp.CGColor;
        
        //_btn_2.showsTouchWhenHighlighted = YES;
        [_btn_2 addTarget:self action:@selector(event_2:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btn_2];
    }
    
    [_btn_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label);
        make.top.equalTo(_btn_1.mas_bottom).offset(20);
        make.right.equalTo(label);
        
        make.height.mas_equalTo(50);
    }];
    
    if(_btn_3 == nil){
        _btn_3 = [[UIButton alloc] init];
        [_btn_3 setTitle:@"蓝色" forState:UIControlStateNormal];
        _btn_3.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        _btn_3.layer.cornerRadius = 8;
        
        UIColor *temp = [[UserInfo singleInstance].colorArr objectAtIndex:2];
        [_btn_3 setTitleColor:temp forState:UIControlStateNormal];
        _btn_3.backgroundColor = [UIColor whiteColor];
        _btn_3.layer.borderWidth = 1.0;
        _btn_3.layer.borderColor = temp.CGColor;
        
        //_btn_3.showsTouchWhenHighlighted = YES;
        [_btn_3 addTarget:self action:@selector(event_3:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btn_3];
    }
    
    [_btn_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label);
        make.top.equalTo(_btn_2.mas_bottom).offset(20);
        make.right.equalTo(label);
        
        make.height.mas_equalTo(50);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self check];
}

- (void)check{
    UIColor *now = [UserInfo singleInstance].color;
    NSArray *color = [UserInfo singleInstance].colorArr;
    if(now == [color objectAtIndex:0]){
        [_btn_1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_1.backgroundColor = now;
    }
    else if(now == [color objectAtIndex:1]){
        [_btn_2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_2.backgroundColor = now;
    }
    else if(now == [color objectAtIndex:1]){
        [_btn_3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_3.backgroundColor = now;
    }
    
}

- (void)event_1:(UIButton *)sender{
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [[UserInfo singleInstance].colorArr objectAtIndex:0];
    [_btn_2 setTitleColor:[[UserInfo singleInstance].colorArr objectAtIndex:1] forState:UIControlStateNormal];
    _btn_2.backgroundColor = [UIColor whiteColor];
    [_btn_3 setTitleColor:[[UserInfo singleInstance].colorArr objectAtIndex:2] forState:UIControlStateNormal];
    _btn_3.backgroundColor = [UIColor whiteColor];
    
    [[UserInfo singleInstance] changeColor:0];
    
    [self notificate];
}

- (void)event_2:(UIButton *)sender{
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [[UserInfo singleInstance].colorArr objectAtIndex:1];
    [_btn_1 setTitleColor:[[UserInfo singleInstance].colorArr objectAtIndex:0] forState:UIControlStateNormal];
    _btn_1.backgroundColor = [UIColor whiteColor];
    [_btn_3 setTitleColor:[[UserInfo singleInstance].colorArr objectAtIndex:2] forState:UIControlStateNormal];
    _btn_3.backgroundColor = [UIColor whiteColor];
    
    [[UserInfo singleInstance] changeColor:1];
    
    [self notificate];
}

- (void)event_3:(UIButton *)sender{
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [[UserInfo singleInstance].colorArr objectAtIndex:2];
    [_btn_2 setTitleColor:[[UserInfo singleInstance].colorArr objectAtIndex:1] forState:UIControlStateNormal];
    _btn_2.backgroundColor = [UIColor whiteColor];
    [_btn_1 setTitleColor:[[UserInfo singleInstance].colorArr objectAtIndex:0] forState:UIControlStateNormal];
    _btn_1.backgroundColor = [UIColor whiteColor];
    
    [[UserInfo singleInstance] changeColor:2];
    
    [self notificate];
    
}

- (void)notificate{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
}

@end
