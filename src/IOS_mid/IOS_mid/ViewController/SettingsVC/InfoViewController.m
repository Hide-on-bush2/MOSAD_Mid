//
//  InfoViewController.m
//  IOS_mid
//
//  Created by Khynnn on 2020/11/24.
//

#import "InfoViewController.h"
#import "UserInfo.h"
#import "SettingNameViewController.h"

#import "Masonry.h"
#import "AFNetworking.h"

@interface InfoViewController()

@end

@implementation InfoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //观察者
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"refresh" object:nil];

    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    self.title = @"编辑资料";
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [self initView];
}
/*
- (void)refresh{
    //[self viewDidLoad];
    self.navigationController.view.backgroundColor = [UserInfo singleInstance].lightColor;
}
*/
- (void)initView{
    //下划线颜色
    UIColor *my_gray_color = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:100];
    
    if(_head == nil){
        UIImage *ima;
        
        NSString *fileURL = [[[UserInfo singleInstance].info valueForKey:@"Info"] valueForKey:@"Avatar"];
        if([fileURL isEqual:@""] || fileURL == nil){
            ima = [UIImage imageNamed:@"DefaultAvatar"];
        }
        else{
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
            ima = [UIImage imageWithData:data];
        }
        
        self.head = [[UIImageView alloc] initWithImage:ima];
        
        _head.layer.borderWidth = 1.0;
        _head.layer.borderColor = my_gray_color.CGColor;
        
        _head.layer.cornerRadius = 70;
        _head.layer.masksToBounds = YES;
        _head.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:_head];
    }
    
    [_head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(self.view.frame.size.width/2-70);
        make.top.equalTo(self.view).with.offset(120);
        
        make.height.mas_equalTo(140);
        make.width.mas_equalTo(140);
    }];
#pragma mark - name
    if(_name == nil){
        _name = [[UIView alloc] init];
        //_name.layer.borderWidth = 1.0;
        //_name.layer.borderColor = [UIColor redColor].CGColor;
        
        UILabel *label_name = [[UILabel alloc] init];
        UILabel *str_name = [[UILabel alloc] init];
        UIButton *changeName = [[UIButton alloc] init];
        
        label_name.text = @"名字";
        label_name.font = [UIFont systemFontOfSize:15];
        label_name.textColor = [UIColor darkGrayColor];
        
        //label_name.layer.borderWidth = 1.0;
        //label_name.layer.borderColor = [UIColor redColor].CGColor;
        [_name addSubview:label_name];
        
        str_name.text = [[UserInfo singleInstance].info valueForKey:@"Name"];
        //str_name.text = @"name";
        str_name.font = [UIFont systemFontOfSize:15];
        
        //str_name.layer.borderWidth = 1.0;
        //str_name.layer.borderColor = [UIColor redColor].CGColor;
        [_name addSubview:str_name];
        
        [changeName setTitle:@">" forState:UIControlStateNormal];
        changeName.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [changeName setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //changeName.layer.borderWidth = 1.0;
        //changeName.layer.borderColor = [UIColor redColor].CGColor;
        changeName.showsTouchWhenHighlighted = YES;
        [changeName addTarget:self action:@selector(ChangeUserName) forControlEvents:UIControlEventTouchUpInside];
        [_name addSubview:changeName];
        
        [self.view addSubview:_name];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(15);
            make.top.equalTo(_head.mas_bottom).offset(40);
            make.right.equalTo(self.view).with.offset(-15);
            
            make.height.mas_equalTo(30);
        }];
        
        [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_name).with.offset(0);
            make.top.equalTo(_name);
            make.bottom.equalTo(_name);
        }];
        
        [str_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_name).with.offset(-10);
            make.top.equalTo(_name);
        }];
        
        [changeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(str_name.mas_right).offset(3);
            
            make.height.mas_equalTo(str_name.mas_height);
            make.width.mas_equalTo(10);
        }];
    }
    
    UIView *name_lineView = [[UIView alloc] init];
    name_lineView.backgroundColor = my_gray_color;
    [self.view addSubview:name_lineView];
    [name_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name.mas_left);
        make.top.equalTo(_name.mas_bottom);
        make.right.equalTo(_name.mas_right);
        
        make.height.mas_equalTo(1);
    }];
    
#pragma mark - email
    
    if(_email == nil){
        _email = [[UIView alloc] init];
        
        UILabel *label_email = [[UILabel alloc] init];
        UILabel *str_email = [[UILabel alloc] init];
        
        label_email.text = @"邮箱";
        label_email.font = [UIFont systemFontOfSize:15];
        label_email.textColor = [UIColor darkGrayColor];
        
        //label_email.layer.borderWidth = 1.0;
        //label_email.layer.borderColor = [UIColor redColor].CGColor;
        [_email addSubview:label_email];
        
        str_email.text = [[UserInfo singleInstance].info valueForKey:@"Email"];
        //str_email.text = @"Email";
        str_email.font = [UIFont systemFontOfSize:15];
        
        //str_email.layer.borderWidth = 1.0;
        //str_email.layer.borderColor = [UIColor redColor].CGColor;
        [_email addSubview:str_email];
        
        [self.view addSubview:_email];
        
        [_email mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_name.mas_left);
            make.top.equalTo(_name.mas_bottom).offset(20);
            make.right.equalTo(_name.mas_right);
            
            make.height.mas_equalTo(30);
        }];
        
        [label_email mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_email).with.offset(0);
            make.top.equalTo(_email);
            make.bottom.equalTo(_email);
        }];
        
        [str_email mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_email).with.offset(-10);
            make.top.equalTo(_email);
            make.bottom.equalTo(_email);
        }];
    }
    
    UIView *email_lineView = [[UIView alloc] init];
    email_lineView.backgroundColor = my_gray_color;
    [self.view addSubview:email_lineView];
    [email_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_email.mas_left);
        make.top.equalTo(_email.mas_bottom);
        make.right.equalTo(_email.mas_right);
        
        make.height.mas_equalTo(1);
    }];
    
#pragma mark - class
    if(_type == nil){
        _type = [[UIView alloc] init];
        
        UILabel *label_type = [[UILabel alloc] init];
        UILabel *str_type = [[UILabel alloc] init];
        
        label_type.text = @"用户类型";
        label_type.font = [UIFont systemFontOfSize:15];
        label_type.textColor = [UIColor darkGrayColor];
        
        //label_type.layer.borderWidth = 1.0;
        //label_type.layer.borderColor = [UIColor redColor].CGColor;
        [_type addSubview:label_type];
        
        NSNumber *class = [[UserInfo singleInstance].info valueForKey:@"Class"];
        if([class intValue] == 1)
            str_type.text = @"受限用户";
        else if([class intValue] == 2)
            str_type.text = @"普通用户";
        else if([class intValue] == 3)
            str_type.text = @"认证用户";
        else if([class intValue] == 4)
            str_type.text = @"VIP用户";
        else if([class intValue] == 5)
            str_type.text = @"管理员";
        else if([class intValue] == 6)
            str_type.text = @"超级管理员";
        str_type.font = [UIFont systemFontOfSize:15];
        
        //str_type.layer.borderWidth = 1.0;
        //str_type.layer.borderColor = [UIColor redColor].CGColor;
        [_type addSubview:str_type];
        
        [self.view addSubview:_type];
        
        [_type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_name.mas_left);
            make.top.equalTo(_email.mas_bottom).offset(20);
            make.right.equalTo(_name.mas_right);
            
            make.height.mas_equalTo(30);
        }];
        
        [label_type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_type).with.offset(0);
            make.top.equalTo(_type);
            make.bottom.equalTo(_type);
        }];
        
        [str_type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_type).with.offset(-10);
            make.top.equalTo(_type);
            make.bottom.equalTo(_type);
        }];
    }
    
    UIView *type_lineView = [[UIView alloc] init];
    type_lineView.backgroundColor = my_gray_color;
    [self.view addSubview:type_lineView];
    [type_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_type.mas_left);
        make.top.equalTo(_type.mas_bottom);
        make.right.equalTo(_type.mas_right);
        
        make.height.mas_equalTo(1);
    }];

#pragma mark - gender
    if(_gender == nil){
        _gender = [[UIView alloc] init];
        
        UILabel *label_gender = [[UILabel alloc] init];
        UILabel *str_gender = [[UILabel alloc] init];
        
        label_gender.text = @"性别";
        label_gender.font = [UIFont systemFontOfSize:15];
        label_gender.textColor = [UIColor darkGrayColor];
        
        //label_gender.layer.borderWidth = 1.0;
        //label_gender.layer.borderColor = [UIColor redColor].CGColor;
        [_gender addSubview:label_gender];
        
        NSNumber *class = [[[UserInfo singleInstance].info valueForKey:@"Info"] valueForKey:@"Gender"];
        if([class intValue] == 0)
            str_gender.text = @"女";
        else
            str_gender.text = @"男";
        str_gender.font = [UIFont systemFontOfSize:15];
        
        //str_gender.layer.borderWidth = 1.0;
        //str_gender.layer.borderColor = [UIColor redColor].CGColor;
        [_gender addSubview:str_gender];
        
        [self.view addSubview:_gender];
        
        [_gender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_name.mas_left);
            make.top.equalTo(_type.mas_bottom).offset(20);
            make.right.equalTo(_name.mas_right);
            
            make.height.mas_equalTo(30);
        }];
        
        [label_gender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_gender).with.offset(0);
            make.top.equalTo(_gender);
            make.bottom.equalTo(_gender);
        }];
        
        [str_gender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_gender).with.offset(-10);
            make.top.equalTo(_gender);
            make.bottom.equalTo(_gender);
        }];
    }
    
    UIView *gender_lineView = [[UIView alloc] init];
    gender_lineView.backgroundColor = my_gray_color;
    [self.view addSubview:gender_lineView];
    [gender_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gender.mas_left);
        make.top.equalTo(_gender.mas_bottom);
        make.right.equalTo(_gender.mas_right);
        
        make.height.mas_equalTo(1);
    }];

#pragma mark - bio
    if(_bio == nil){
        _bio = [[UIView alloc] init];
        
        UILabel *label_bio = [[UILabel alloc] init];
        UILabel *str_bio = [[UILabel alloc] init];
        
        label_bio.text = @"个人简介";
        label_bio.font = [UIFont systemFontOfSize:15];
        label_bio.textColor = [UIColor darkGrayColor];
        
        //label_bio.layer.borderWidth = 1.0;
        //label_bio.layer.borderColor = [UIColor redColor].CGColor;
        [_bio addSubview:label_bio];
        
        str_bio.text = [[[UserInfo singleInstance].info valueForKey:@"Info"] valueForKey:@"Bio"];
        //str_bio.text = @"bio";
        str_bio.font = [UIFont systemFontOfSize:15];
        
        //str_bio.layer.borderWidth = 1.0;
       //str_bio.layer.borderColor = [UIColor redColor].CGColor;
        [_bio addSubview:str_bio];
        
        [self.view addSubview:_bio];
        
        [_bio mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_name.mas_left);
            make.top.equalTo(_gender.mas_bottom).offset(20);
            make.right.equalTo(_name.mas_right);
            
            make.height.mas_equalTo(30);
        }];
        
        [label_bio mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bio).with.offset(0);
            make.top.equalTo(_bio);
            make.bottom.equalTo(_bio);
        }];
        
        [str_bio mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_bio).with.offset(-10);
            make.top.equalTo(_bio);
            make.bottom.equalTo(_bio);
        }];
    }
    
    UIView *bio_lineView = [[UIView alloc] init];
    bio_lineView.backgroundColor = my_gray_color;
    [self.view addSubview:bio_lineView];
    [bio_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bio.mas_left);
        make.top.equalTo(_bio.mas_bottom);
        make.right.equalTo(_bio.mas_right);
        
        make.height.mas_equalTo(1);
    }];
    
}

- (void)ChangeUserName{
    NSLog(@"ChangeUserName");
    
    SettingNameViewController* snvc = [[SettingNameViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:snvc animated:YES];
    //self.hidesBottomBarWhenPushed=NO;
}

@end
