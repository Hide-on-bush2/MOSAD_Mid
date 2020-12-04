//
//  SetUpViewController.m
//  IOS_mid
//
//

#import <Foundation/Foundation.h>
#import "SetUpViewController.h"
#import "UserInfo.h"
#import "Masonry.h"
#import "AFNetworking.h"

#import "LoginViewController.h"

#import "StorageView.h"
#import "InfoViewController.h"
#import "MessageViewController.h"
#import "PersonalSettingViewController.h"

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"refresh" object:nil];
    
    self.navigationController.navigationBarHidden = YES;
    
    //CGColorRef cgColor = [UIColor redColor].CGColor;
//背景部分
    self.view.backgroundColor = [UserInfo singleInstance].lightColor;
    
    if(_back == nil){
        _back = [[UIView alloc] init];
        _back.backgroundColor = [UserInfo singleInstance].color;
        _back.layer.masksToBounds = YES;
        _back.layer.cornerRadius = 20;
        [self.view addSubview:_back];
    }
    [_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(-5);
        make.right.equalTo(self.view);
        
        make.height.mas_equalTo(200);
    }];
    
 //用户信息部分
#pragma mark - data
    if(_data == nil){
        self.data = [[UIView alloc] init];
        //_data.layer.borderWidth = 1.0;
        //_data.layer.borderColor = cgColor;
        _data.backgroundColor = [UIColor whiteColor];
        _data.layer.masksToBounds = YES;
        _data.layer.cornerRadius = 10;
        //昵称
        if(_name == nil){
            self.name = [[UILabel alloc] init];
            _name.font = [UIFont boldSystemFontOfSize:22];
            //_name.layer.borderWidth = 1.0;
            //_name.layer.borderColor = cgColor;
            [_data addSubview:_name];
        }
        //bio
        if(_bio == nil){
            self.bio = [[UILabel alloc] init];
            _bio.font = [UIFont systemFontOfSize:13];
            _bio.textColor = [UIColor grayColor];
            //_bio.layer.borderWidth = 1.0;
            //_bio.layer.borderColor = cgColor;
            [_data addSubview:_bio];
        }
        
        [self.view addSubview:_data];
    }
    //
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
        _head.backgroundColor = [UIColor whiteColor];
        _head.layer.borderWidth = 10.0;
        _head.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _head.layer.cornerRadius = 60;
        _head.layer.masksToBounds = YES;
        _head.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:_head];
    }
    
    [_data mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(150);
        make.right.equalTo(self.view).with.offset(-15);
        
        make.height.mas_equalTo(100);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_data).with.offset(20);
        make.top.equalTo(_data).with.offset(20);
    }];
    
    [_bio mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name.mas_left);
        make.top.equalTo(_name.mas_bottom).offset(10);
    }];
    
    [_head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_data.mas_right).offset(-40);
        make.bottom.equalTo(_data.mas_bottom).offset(-30);
        
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(120);
    }];
//常用操作
    UILabel* operation = [[UILabel alloc] init];
    operation.text = @"常用操作";
    operation.font = [UIFont systemFontOfSize:15];
    //operation.layer.borderWidth = 1.0;
    //operation.layer.borderColor = cgColor;
    [self.view addSubview:operation];
    
    [operation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_data.mas_left);
        make.top.equalTo(_data.mas_bottom).offset(20);
    }];
#pragma mark - info
//编辑查看资料
    UIView* viewInfo = [[UIView alloc] init];
    //viewInfo.layer.borderWidth = 1.0;
    //viewInfo.layer.borderColor = cgColor;
    viewInfo.backgroundColor = [UIColor whiteColor];
    viewInfo.layer.masksToBounds = YES;
    viewInfo.layer.cornerRadius = 8;
    [self.view addSubview:viewInfo];
    //将UIView设为可交互的：
    viewInfo.userInteractionEnabled = YES;
    //添加tap手势
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserInfo:)];
    //给触发事件传参
    //[viewInfo setTag:i];
    //默认为单击触发，也可通过以下方法设置双击，三击...
    [singleTap setNumberOfTapsRequired:1];
    //设置手指个数：
    [singleTap setNumberOfTouchesRequired:1];
    //将手势添加至UIView中
    [viewInfo addGestureRecognizer:singleTap];
 
    UILabel* viewInfo_label_1 = [[UILabel alloc] init];
    viewInfo_label_1.text = @"编辑资料";
    viewInfo_label_1.font = [UIFont boldSystemFontOfSize:14];
    //viewInfo_label_1.layer.borderWidth = 1.0;
    //viewInfo_label_1.layer.borderColor = cgColor;
    [viewInfo addSubview:viewInfo_label_1];
    
    UILabel* viewInfo_label_2 = [[UILabel alloc] init];
    viewInfo_label_2.text = @"查看个人信息和成就";
    viewInfo_label_2.font = [UIFont systemFontOfSize:11];
    viewInfo_label_2.textColor = [UIColor grayColor];
    //viewInfo_label_2.layer.borderWidth = 1.0;
    //viewInfo_label_2.layer.borderColor = cgColor;
    [viewInfo addSubview:viewInfo_label_2];
    
    
    UIImage *ima = [UIImage imageNamed:@"SettingInfo"];
    UIImageView *imageInfo = [[UIImageView alloc] initWithImage:ima];
    //imageInfo.backgroundColor = [UIColor whiteColor];
    //imageInfo.layer.borderWidth = 1.0;
    //imageInfo.layer.borderColor = [UIColor redColor].CGColor;
    imageInfo.contentMode = UIViewContentModeScaleAspectFit;
    [viewInfo addSubview:imageInfo];
    
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(operation.mas_left);
        make.top.equalTo(operation.mas_bottom).offset(10);
        
        make.height.mas_equalTo(70);
        make.width.mas_equalTo((self.view.frame.size.width-30-10)/2);
    }];
    
    [viewInfo_label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewInfo).with.offset(10);
        make.top.equalTo(viewInfo).with.offset(15);
    }];
    
    [viewInfo_label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewInfo_label_1.mas_left);
        make.top.equalTo(viewInfo_label_1.mas_bottom).offset(10);
    }];
    
    [imageInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo).with.offset(15);
        make.right.equalTo(viewInfo).with.offset(-15);
        
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
#pragma mark - message
//查看消息
    UIView* viewMeg = [[UIView alloc] init];
    //viewMeg.layer.borderWidth = 1.0;
    //viewMeg.layer.borderColor = cgColor;
    viewMeg.backgroundColor = [UIColor whiteColor];
    viewMeg.layer.masksToBounds = YES;
    viewMeg.layer.cornerRadius = 8;
    [self.view addSubview:viewMeg];
    //将UIView设为可交互的：
    viewMeg.userInteractionEnabled = YES;
    //添加tap手势
    UITapGestureRecognizer* meg_singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMessage:)];
    [meg_singleTap setNumberOfTapsRequired:1];
    [meg_singleTap setNumberOfTouchesRequired:1];
    [viewMeg addGestureRecognizer:meg_singleTap];
 
    UILabel* viewMeg_label_1 = [[UILabel alloc] init];
    viewMeg_label_1.text = @"我的消息";
    viewMeg_label_1.font = [UIFont boldSystemFontOfSize:14];
    //viewMeg_label_1.layer.borderWidth = 1.0;
    //viewMeg_label_1.layer.borderColor = cgColor;
    [viewMeg addSubview:viewMeg_label_1];
    
    UILabel* viewMeg_label_2 = [[UILabel alloc] init];
    viewMeg_label_2.text = @"快速查看消息";
    viewMeg_label_2.font = [UIFont systemFontOfSize:11];
    viewMeg_label_2.textColor = [UIColor grayColor];
    //viewMeg_label_2.layer.borderWidth = 1.0;
    //viewMeg_label_2.layer.borderColor = cgColor;
    [viewMeg addSubview:viewMeg_label_2];
    
    UIImage *ima2 = [UIImage imageNamed:@"SettingMeg"];
    UIImageView *imageMeg = [[UIImageView alloc] initWithImage:ima2];
    //imageMeg.backgroundColor = [UIColor whiteColor];
    //imageMeg.layer.borderWidth = 1.0;
    //imageMeg.layer.borderColor = [UIColor redColor].CGColor;
    imageMeg.contentMode = UIViewContentModeScaleAspectFit;
    [viewMeg addSubview:imageMeg];
    
    [viewMeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewInfo.mas_right).offset(10);
        make.top.equalTo(operation.mas_bottom).offset(10);
        
        make.height.mas_equalTo(viewInfo.mas_height);
        make.width.mas_equalTo(viewInfo.mas_width);
    }];
    
    [viewMeg_label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMeg).with.offset(10);
        make.top.equalTo(viewMeg).with.offset(15);
    }];
    
    [viewMeg_label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMeg_label_1.mas_left);
        make.top.equalTo(viewMeg_label_1.mas_bottom).offset(10);
    }];
    
    [imageMeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMeg).with.offset(15);
        make.right.equalTo(viewMeg).with.offset(-15);
        
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    
#pragma mark - storage
//个人存储额度
    UIView* viewStorage = [[UIView alloc] init];
    //viewStorage.layer.borderWidth = 1.0;
    //viewStorage.layer.borderColor = cgColor;
    viewStorage.backgroundColor = [UIColor whiteColor];
    viewStorage.layer.masksToBounds = YES;
    viewStorage.layer.cornerRadius = 8;
    [self.view addSubview:viewStorage];
    //将UIView设为可交互的：
    viewStorage.userInteractionEnabled = YES;
    //添加tap手势
    UITapGestureRecognizer* storage_singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showStorage:)];
    [storage_singleTap setNumberOfTapsRequired:1];
    [storage_singleTap setNumberOfTouchesRequired:1];
    [viewStorage addGestureRecognizer:storage_singleTap];
 
    UILabel* viewStorage_label_1 = [[UILabel alloc] init];
    viewStorage_label_1.text = @"存储额度";
    viewStorage_label_1.font = [UIFont boldSystemFontOfSize:14];
    //viewStorage_label_1.layer.borderWidth = 1.0;
    //viewStorage_label_1.layer.borderColor = cgColor;
    [viewStorage addSubview:viewStorage_label_1];
    
    UILabel* viewStorage_label_2 = [[UILabel alloc] init];
    viewStorage_label_2.text = @"管理个人的存储额度";
    viewStorage_label_2.font = [UIFont systemFontOfSize:11];
    viewStorage_label_2.textColor = [UIColor grayColor];
    //viewStorage_label_2.layer.borderWidth = 1.0;
    //viewStorage_label_2.layer.borderColor = cgColor;
    [viewStorage addSubview:viewStorage_label_2];
    
    UIImage *ima3 = [UIImage imageNamed:@"SettingStorage"];
    UIImageView *imageSto = [[UIImageView alloc] initWithImage:ima3];
    //imageSto.backgroundColor = [UIColor whiteColor];
    //imageSto.layer.borderWidth = 1.0;
    //imageSto.layer.borderColor = [UIColor redColor].CGColor;
    imageSto.contentMode = UIViewContentModeScaleAspectFit;
    [viewStorage addSubview:imageSto];
    
    [viewStorage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewInfo.mas_left);
        make.top.equalTo(viewInfo.mas_bottom).offset(15);
        
        make.height.mas_equalTo(viewInfo.mas_height);
        make.width.mas_equalTo(viewInfo.mas_width);
    }];
    
    [viewStorage_label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewStorage).with.offset(10);
        make.top.equalTo(viewStorage).with.offset(15);
    }];
    
    [viewStorage_label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewStorage_label_1.mas_left);
        make.top.equalTo(viewStorage_label_1.mas_bottom).offset(10);
    }];
    
    [imageSto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewStorage).with.offset(15);
        make.right.equalTo(viewStorage).with.offset(-15);
        
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
#pragma mark - personalSetting
    //个性化设置
    UIView* viewSetting = [[UIView alloc] init];
    //viewSetting.layer.borderWidth = 1.0;
    //viewSetting.layer.borderColor = cgColor;
    viewSetting.backgroundColor = [UIColor whiteColor];
    viewSetting.layer.masksToBounds = YES;
    viewSetting.layer.cornerRadius = 8;
    [self.view addSubview:viewSetting];
    //将UIView设为可交互的：
    viewSetting.userInteractionEnabled = YES;
    //添加tap手势
    UITapGestureRecognizer* setting_singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSetting:)];
    [setting_singleTap setNumberOfTapsRequired:1];
    [setting_singleTap setNumberOfTouchesRequired:1];
    [viewSetting addGestureRecognizer:setting_singleTap];
 
    UILabel* viewSetting_label_1 = [[UILabel alloc] init];
    viewSetting_label_1.text = @"个性化设置";
    viewSetting_label_1.font = [UIFont boldSystemFontOfSize:14];
    //viewSetting_label_1.layer.borderWidth = 1.0;
    //viewSetting_label_1.layer.borderColor = cgColor;
    [viewSetting addSubview:viewSetting_label_1];
    
    UILabel* viewSetting_label_2 = [[UILabel alloc] init];
    viewSetting_label_2.text = @"属于你的独特设计";
    viewSetting_label_2.font = [UIFont systemFontOfSize:11];
    viewSetting_label_2.textColor = [UIColor grayColor];
    //viewSetting_label_2.layer.borderWidth = 1.0;
    //viewSetting_label_2.layer.borderColor = cgColor;
    [viewSetting addSubview:viewSetting_label_2];
    
    UIImage *ima4 = [UIImage imageNamed:@"SettingPer"];
    UIImageView *imagePer = [[UIImageView alloc] initWithImage:ima4];
    //imagePer.backgroundColor = [UIColor whiteColor];
    //imagePer.layer.borderWidth = 1.0;
    //imagePer.layer.borderColor = [UIColor redColor].CGColor;
    imagePer.contentMode = UIViewContentModeScaleAspectFit;
    [viewSetting addSubview:imagePer];
    
    [viewSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMeg.mas_left);
        make.top.equalTo(viewInfo.mas_bottom).offset(15);
        
        make.height.mas_equalTo(viewInfo.mas_height);
        make.width.mas_equalTo(viewInfo.mas_width);
    }];
    
    [viewSetting_label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewSetting).with.offset(10);
        make.top.equalTo(viewSetting).with.offset(15);
    }];
    
    [viewSetting_label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewSetting_label_1.mas_left);
        make.top.equalTo(viewSetting_label_1.mas_bottom).offset(10);
    }];
    
    [imagePer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewSetting).with.offset(15);
        make.right.equalTo(viewSetting).with.offset(-15);
        
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
#pragma mark - button
    //管理员：管理全部用户
    UIButton* manage = [[UIButton alloc] init];
    [manage setTitle:@"管理全部用户" forState:UIControlStateNormal];
    manage.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [manage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    manage.layer.cornerRadius = 8;
    manage.backgroundColor = [UIColor whiteColor];
    //manage.showsTouchWhenHighlighted = YES;
    [manage addTarget:self action:@selector(showManage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:manage];
    
    [manage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_data.mas_left);
        make.top.equalTo(viewStorage.mas_bottom).offset(20);
        make.right.equalTo(_data.mas_right);
        
        make.height.mas_equalTo(60);
    }];
    //manage.hidden = YES;
    NSString* class = [[UserInfo singleInstance].info objectForKey:@"Class"];
    if([class isEqual:@"5"] || [class isEqual:@"6"]){
        manage.hidden = NO;
    }
# pragma mark - log out
//退出登录
    UIButton* logout = [[UIButton alloc] init];
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    logout.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [logout setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    logout.layer.cornerRadius = 8;
    //logout.layer.borderWidth = 1.0;
    //logout.layer.borderColor = cgColor;
    logout.backgroundColor = [UIColor whiteColor];
    //logout.backgroundColor = [UserInfo singleInstance].color;
    logout.showsTouchWhenHighlighted = YES;
    [logout addTarget:self action:@selector(LogOut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout];
    
    [logout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_data.mas_left);
        make.top.equalTo(manage.mas_bottom).offset(20);
        make.right.equalTo(_data.mas_right);
        
        make.height.mas_equalTo(40);
    }];
}
//
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UserInfo singleInstance].lightColor;
    
    [self showUserInfo];
}

- (void)refresh{
    //[self viewDidLoad];
    self.view.backgroundColor = [UserInfo singleInstance].lightColor;
    _back.backgroundColor = [UserInfo singleInstance].color;
}

- (void)showUserInfo{
    self.name.text = [[UserInfo singleInstance].info objectForKey:@"Name"];
    self.bio.text = [[UserInfo singleInstance].info objectForKey:@"Info"][@"Bio"];
    //self.name.text = @"Name";
    //self.bio.text = @"Bio";
}

-(void)showUserInfo:(UITapGestureRecognizer *)sender{
    //获得参数
    //NSInteger index = sender.view.tag;
    //在这里写触发事件
    NSLog(@"showUserInfo");
    InfoViewController* infovc = [[InfoViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infovc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(void)showMessage:(UITapGestureRecognizer *)sender{
    NSLog(@"showMessage");
    MessageViewController* megvc = [[MessageViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:megvc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(void)showStorage:(UITapGestureRecognizer *)sender{
    NSLog(@"showStorage");
    StorageView* view = [[StorageView alloc] init];
    [view showAlert:self.view];
}

-(void)showSetting:(UITapGestureRecognizer *)sender{
    NSLog(@"showSetting");
    PersonalSettingViewController* psvc = [[PersonalSettingViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:psvc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(void)showManage:(UIButton *)sender{
    NSLog(@"showManage");
}

-(void)LogOut:(UIButton *)sender{
    NSString *urlString = @"http://172.18.178.56/api/user/logout";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求体，参数（NSDictionary 类型）
    NSDictionary *rawParams = [UserInfo singleInstance].data;
    //NSLog(@"login %@",rawParams);
    [manager POST:urlString
       parameters:rawParams
          headers:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"LogOut");
                NSLog(@"success %@",responseObject);
                
                if([responseObject[@"State"] isEqual:@"success"]){
                    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
                }
                else{
                    NSLog(@"logout error");
                }
            }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
    }];
    
    
}


@end
