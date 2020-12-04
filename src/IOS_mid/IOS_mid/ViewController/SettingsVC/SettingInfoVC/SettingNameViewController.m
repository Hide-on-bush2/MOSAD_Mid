//
//  SettingNameViewController.m
//  ios_mid
//
//  Created by Khynnn on 2020/12/1.
//

#import "SettingNameViewController.h"
#import "UserInfo.h"

#import "Masonry.h"
#import "AFNetworking.h"

@interface SettingNameViewController()

@end

@implementation SettingNameViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    //观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"refresh" object:nil];
    
    self.maxWowdLimit = 24;
    
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    self.title = @"修改用户名";
    self.navigationController.view.backgroundColor = [UserInfo singleInstance].lightColor;
    self.view.backgroundColor = [UserInfo singleInstance].lightColor;

    UIBarButtonItem * lef = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    [lef setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = lef;
    
    
    _barItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    [_barItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = _barItem;
    
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    if(_name == nil){
        _name = [[UITextField alloc] init];
       // _name.backgroundColor = [UIColor whiteColor];
        //_name.layer.cornerRadius = 8;
        //_name.layer.masksToBounds = YES;
        _name.text = [[UserInfo singleInstance].info valueForKey:@"Name"];
        _name.font = [UIFont systemFontOfSize:16];
        [_name addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
        [view addSubview:_name];
    }
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(110);
        make.right.equalTo(self.view).with.offset(-15);
        make.height.mas_equalTo(50);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(5);
        make.top.equalTo(view);
        make.right.equalTo(view).with.offset(-5);
        
        make.height.mas_equalTo(50);
    }];
    
    if(_tip == nil){
        _tip = [[UILabel alloc] init];
        _tip.text = @"请设置2-24个字符，不能有空格哦";
        _tip.textColor= [UIColor grayColor];
        _tip.font = [UIFont systemFontOfSize:13];
        
        [self.view addSubview:_tip];
    }
    
    [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name);
        make.top.equalTo(_name.mas_bottom).offset(10);
    }];
    
    if(_num == nil){
        _num = [[UILabel alloc] init];
        _num.textColor= [UIColor grayColor];
        _num.font = [UIFont systemFontOfSize:13];
    
        [self.view addSubview:_num];
    }
    
    NSString *str  = [NSString stringWithFormat:@"%lu", _name.text.length];
    NSString *str2 = [NSString stringWithFormat:@"%d", _maxWowdLimit];
    NSString * str3= [str stringByAppendingString:@"/"];
    NSString * str4= [str3 stringByAppendingString:str2];
    _num.text = str4;
    
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_name);
        make.top.equalTo(_name.mas_bottom).offset(10);
    }];
}

- (void)refresh{
    //[self viewDidLoad];
    self.navigationController.view.backgroundColor = [UserInfo singleInstance].lightColor;
    self.view.backgroundColor = [UserInfo singleInstance].lightColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_name resignFirstResponder]; // 空白处收起
}

- (void)textFieldDidChanged:(UITextField *)textField {
     // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
     UITextRange *selectedRange = textField.markedTextRange;
     UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
     if (position) {
         return;
     }
     // maxWowdLimit 为 0，不限制字数
     if (self.maxWowdLimit == 0) {
         return;
     }
    if(_name.text.length > 2){
       _barItem.enabled = YES;
        _tip.textColor = [UIColor grayColor];
    }
     // 判断是否超过最大字数限制，如果超过就截断
     if (_name.text.length > self.maxWowdLimit) {
         _name.text = [_name.text substringToIndex:self.maxWowdLimit];
         _tip.textColor = [UIColor redColor];
     }
     else if(_name.text.length < 2){
         _tip.textColor = [UIColor redColor];
         _barItem.enabled = NO;
     }
     // 剩余字数显示 UI 更新
    NSString *str  = [NSString stringWithFormat:@"%lu", _name.text.length];
    NSString *str2 = [NSString stringWithFormat:@"%d", _maxWowdLimit];
    NSString * str3= [str stringByAppendingString:@"/"];
    NSString * str4= [str3 stringByAppendingString:str2];
    _num.text = str4;
}

- (void)back:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
    //[self popViewControllerAnimated:YES];
}

- (void)save:(UIBarButtonItem *)item{
    NSString *urlString = @"http://172.18.178.56/api/user/name";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求体，参数（NSDictionary 类型）
    NSDictionary *rawParams = @{@"name":_name.text};
    NSLog(@"setName %@",rawParams);
    [manager POST:urlString
       parameters:rawParams
          headers:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                
                if([responseObject[@"State"] isEqual:@"success"]){
                    [[UserInfo singleInstance].info setValue:self.name.text forKey:@"Name"];
                    //[[[UserInfo singleInstance].info valueForKey:@"Info"] setValue:self.name.text forKey:@"Name"];
                    NSLog(@"%@",[UserInfo singleInstance].info);
                    [self.navigationController popViewControllerAnimated:YES];
                    [self viewDidLoad];
                }
                else{
                    NSLog(@"error");
                }
            }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
    }];
}

@end
