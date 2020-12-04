//
//  Login.m
//  IOS_mid
//
//  Created by Khynnn on 2020/11/20.
//

#import "LoginViewController.h"
#import "UserInfo.h"
#import "TabBarController.h"
#import "RegisterViewController.h"

#import "Masonry.h"
#import "AFNetworking.h"

@interface LoginViewController()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad{
    [super.navigationController setNavigationBarHidden:YES animated:TRUE];
}

- (void)viewWillAppear:(BOOL)animated{
    
    //下划线颜色
    UIColor *my_gray_color = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:100];
    //登录按钮颜色
    UIColor *my_purple_color = [UserInfo singleInstance].color;
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"欢迎登录";
    title.font = [UIFont boldSystemFontOfSize:25];
    //title.layer.borderWidth = 1.0;
    //title.layer.borderColor = colorRef;
    [self.view addSubview:title];
    
    UILabel *info = [[UILabel alloc] init];
    info.text = @"这里写APP简单介绍";
    info.font = [UIFont systemFontOfSize:12];
    info.textColor = [UIColor grayColor];
    //info.layer.borderWidth = 1.0;
    //info.layer.borderColor = colorRef;
    [self.view addSubview:info];
    
    _name.text = nil;
    if(self.name == nil){
        self.name = [[UITextField alloc] init];
        _name.delegate = self;
        [_name setPlaceholder:@"请输入邮箱"];
        _name.font = [UIFont systemFontOfSize:13];
        //_name.layer.borderWidth = 1.0;
        //_name.layer.borderColor = colorRef;
        
        [self.view addSubview:_name];
    }
    
    UIView *name_lineView = [[UIView alloc] init];
    name_lineView.backgroundColor = my_gray_color;
    [self.view addSubview:name_lineView];
    
    _password.text = nil;
    if(self.password == nil){
        self.password = [[UITextField alloc] init];
        _password.delegate = self;
        [_password setPlaceholder:@"请输入密码"];
        _password.secureTextEntry = YES;
        _password.font = [UIFont systemFontOfSize:13];
        //_password.layer.borderWidth = 1.0;
        //_password.layer.borderColor = colorRef;
        
        [self.view addSubview:_password];
    }
    
    UIView *password_lineView = [[UIView alloc] init];
    password_lineView.backgroundColor = my_gray_color;
    [self.view addSubview:password_lineView];
    
    if(_tip == nil){
        self.tip = [[UILabel alloc] init];
        _tip.font = [UIFont systemFontOfSize:13];
        _tip.textColor = [UIColor redColor];
        //_tip.text = @"test";
        //_tip.layer.borderWidth = 1.0;
        //_tip.layer.borderColor = [UIColor redColor].CGColor;
        
        [self.view addSubview:_tip];
    }
    _tip.hidden = YES;
    
    UIButton *login = [[UIButton alloc] init];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    login.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login setBackgroundColor: my_purple_color];
    login.layer.cornerRadius = 10;
    
    login.showsTouchWhenHighlighted = YES;
    
    [login addTarget:self action:@selector(LogIn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    UIButton *reg = [[UIButton alloc] init];
    [reg setTitle:@"注册" forState:UIControlStateNormal];
    reg.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [reg setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[reg setBackgroundColor:[UIColor blackColor]];
    reg.layer.cornerRadius = 10;
    
    reg.showsTouchWhenHighlighted = YES;
    
    [reg addTarget:self action:@selector(Register:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reg];
    
 // 位置约束
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.view).with.offset(100);
        make.right.equalTo(self.view).with.offset(-20);
        //make.bottom.equalTo(info.mas_top).offset(-10);
        
        //make.height.mas_equalTo(30);
    }];
    
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_left);
        make.top.equalTo(title.mas_bottom).offset(10);
        make.right.equalTo(title.mas_right);
        //make.bottom.equalTo(_name.mas_top).offset(-30);
        
        //make.height.mas_equalTo(20);
    }];

    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(info.mas_left);
        make.top.equalTo(info.mas_bottom).offset(30);
        make.right.equalTo(self.view).with.offset(-20);
        //make.bottom.equalTo(_password.mas_top).offset(-15);
        
        make.height.mas_equalTo(30);
    }];
    
    [name_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name.mas_left);
        make.top.equalTo(_name.mas_bottom);
        make.right.equalTo(_name.mas_right);
        
        make.height.mas_equalTo(1);
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name.mas_left);
        make.top.equalTo(_name.mas_bottom).offset(15);
        make.right.equalTo(_name.mas_right);
        //make.bottom.equalTo(login.mas_top).offset(-20);
        
        make.height.mas_equalTo(30);
    }];
    
    [password_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_password.mas_left);
        make.top.equalTo(_password.mas_bottom);
        make.right.equalTo(_password.mas_right);
        
        make.height.mas_equalTo(1);
    }];
    
    [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(password_lineView.mas_left);
        make.top.equalTo(password_lineView.mas_bottom).offset(5);
    }];
    
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_password.mas_left);
        make.top.equalTo(_tip.mas_bottom).offset(15);
        make.right.equalTo(_password.mas_right);
        //make.bottom.equalTo(reg.mas_top).offset(-10);
        
        make.height.mas_equalTo(40);
    }];
    
    [reg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(login.mas_left);
        make.top.equalTo(login.mas_bottom).offset(10);
        make.right.equalTo(login.mas_right);
        
        //make.height.mas_equalTo(30);
    }];
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

- (void)LogIn:(UIButton *)btn{
    
    //先登录，成功后，获取用户信息存入UserInfo，避免多次get
    if([self validateEmail:_name.text]){
        //[self test:_name.text withPass:_password.text];
        
        NSString *urlString = @"http://172.18.178.56/api/user/login/pass";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //设置请求体数据为json类型
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //设置响应体数据为json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //请求体，参数（NSDictionary 类型）
        NSDictionary *rawParams = @{@"name":_name.text,
                                    @"password":_password.text};
        NSLog(@"login %@",rawParams);
        [manager POST:urlString
           parameters:rawParams
              headers:nil
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"success %@",responseObject);
                    
                    if([responseObject[@"State"] isEqual:@"success"]){
                        self.tip.hidden = YES;
                        [UserInfo singleInstance].data = [rawParams mutableCopy];
                        [self getInfo];
                        [self viewWillAppear:YES];
                    }
                    else{
                        self.tip.hidden = NO;
                        self.tip.text = @"邮箱或密码错误！";
                    }
                }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"%@",error);
        }];
    }
    else{
        self.tip.hidden = NO;
        self.tip.text = @"邮箱格式错误！";
    }
}

- (void)Register:(UIButton *)btn{
    RegisterViewController *reg = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:reg animated:YES];
}

- (void)getInfo{
    NSString *urlString = @"http://172.18.178.56/api/user/info/self";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:urlString
       parameters:nil
          headers:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"getInfo success %@",responseObject);
                [UserInfo singleInstance].info = [responseObject mutableCopy];
            }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
    }];
    
    TabBarController *home = [[TabBarController alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_name resignFirstResponder]; // 空白处收起
    [_password resignFirstResponder];
}

@end
