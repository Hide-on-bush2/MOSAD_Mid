//
//  MessageViewController.m
//  IOS_mid
//
//  Created by Khynnn on 2020/11/27.
//

#import "MessageViewController.h"
#import "UserInfo.h"
#import "MessageData.h"

#import "MegLikeViewController.h"
#import "MegReplyViewController.h"
#import "MegFollowViewController.h"
#import "MegSystemViewController.h"

#import "Masonry.h"
#import "AFNetworking.h"

@interface MessageViewController()

@end

@implementation MessageViewController

- (void)viewDidLoad{
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    self.title = @"消息";
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated{
    [[MessageData singleInstance] getMeg];
    [self getLike];
    
}

- (void)initView{
    if(_btnView == nil){
        _btnView = [[UIView alloc] init];
        //_btnView.layer.borderWidth = 1.0;
        //_btnView.layer.borderColor = [UIColor redColor].CGColor;
        [self.view addSubview:_btnView];
        
        [_btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_top).with.offset(200);
        }];
    }
    
    if(_likeBtn == nil){
        _likeBtn = [[UIButton alloc] init];
        UIImage *image = [UIImage imageNamed:@"MegLike"];
        [_likeBtn setImage:image forState:UIControlStateNormal];
        _likeBtn.backgroundColor = [UserInfo singleInstance].colorArr[0];
        
        [_likeBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        _likeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _likeBtn.layer.cornerRadius = 6.0;
        _likeBtn.layer.masksToBounds = YES;
       
        [_likeBtn addTarget:self action:@selector(showLike:) forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:_likeBtn];
        
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_btnView).with.offset(40);
            make.bottom.equalTo(_btnView).with.offset(-40);
            
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
    }
    
    UILabel* label_1 = [[UILabel alloc] init];
    label_1.text = @"赞";
    label_1.font = [UIFont systemFontOfSize:13];
    label_1.textAlignment = NSTextAlignmentCenter;
    [_btnView addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeBtn);
        make.right.equalTo(_likeBtn);
        make.top.equalTo(_likeBtn.mas_bottom).offset(10);
    }];
    
    if(_followBtn == nil){
        _followBtn = [[UIButton alloc] init];
        UIImage *image = [UIImage imageNamed:@"MegFollow"];
        [_followBtn setImage:image forState:UIControlStateNormal];
        _followBtn.backgroundColor = [UserInfo singleInstance].colorArr[1];
        
        [_followBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        _followBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _followBtn.layer.cornerRadius = 6.0;
        _followBtn.layer.masksToBounds = YES;
       
        [_followBtn addTarget:self action:@selector(showFollow:) forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:_followBtn];
        
        [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_likeBtn.mas_right).offset((self.view.frame.size.width - 230)/2);
            make.bottom.equalTo(_likeBtn.mas_bottom);
            
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
    }
    
    UILabel* label_2 = [[UILabel alloc] init];
    label_2.text = @"新增关注";
    label_2.font = [UIFont systemFontOfSize:13];
    label_2.textAlignment = NSTextAlignmentCenter;
    [_btnView addSubview:label_2];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_followBtn).offset(-5);
        make.right.equalTo(_followBtn).offset(5);
        make.top.equalTo(_followBtn.mas_bottom).offset(10);
    }];
    
    if(_replyBtn == nil){
        _replyBtn = [[UIButton alloc] init];
        UIImage *image = [UIImage imageNamed:@"MegReply"];
        [_replyBtn setImage:image forState:UIControlStateNormal];
        _replyBtn.backgroundColor = [UserInfo singleInstance].colorArr[2];
        
        [_replyBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        _replyBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _replyBtn.layer.cornerRadius = 6.0;
        _replyBtn.layer.masksToBounds = YES;
       
        [_replyBtn addTarget:self action:@selector(showReply:) forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:_replyBtn];
        
        [_replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_btnView).with.offset(-40);
            make.bottom.equalTo(_likeBtn.mas_bottom);
            
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
    }
    
    UILabel* label_3 = [[UILabel alloc] init];
    label_3.text = @"评论";
    label_3.font = [UIFont systemFontOfSize:13];
    label_3.textAlignment = NSTextAlignmentCenter;
    [_btnView addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_replyBtn);
        make.right.equalTo(_replyBtn);
        make.top.equalTo(_replyBtn.mas_bottom).offset(10);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    UIColor *gray_color = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:100];
    lineView.backgroundColor = gray_color;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_btnView.mas_bottom);
        make.right.equalTo(self.view);
        
        make.height.mas_equalTo(10);
    }];
    
//#pragma mark - system
    UIView* sysView = [[UIView alloc] init];
    sysView.backgroundColor = [UIColor whiteColor];
    //将UIView设为可交互的：
    sysView.userInteractionEnabled = YES;
    //添加tap手势
    UITapGestureRecognizer* setting_singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSyetem:)];
    [setting_singleTap setNumberOfTapsRequired:1];
    [setting_singleTap setNumberOfTouchesRequired:1];
    [sysView addGestureRecognizer:setting_singleTap];
    
    //sysView.layer.borderWidth = 1.0;
    //sysView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:sysView];
    [sysView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_btnView.mas_bottom).offset(10);
        make.right.equalTo(self.view);
        
        make.height.mas_equalTo(70);
    }];
    
    UIImage *image = [UIImage imageNamed:@"MegSystem"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIView *ivView = [[UIView alloc] init];
    UIColor *orange = [UIColor colorWithRed:231.0/255.0 green:101.0/255.0 blue:26.0/255.0 alpha:100];
    ivView.backgroundColor = orange;
    ivView.layer.cornerRadius = 25;
    ivView.layer.masksToBounds = YES;
    
    [sysView addSubview:ivView];
    [ivView addSubview:imageView];
    
    [ivView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sysView).with.offset(15);
        make.top.equalTo(sysView).with.offset(10);
        make.bottom.equalTo(sysView).with.offset(-10);
        
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivView).with.offset(10);
        make.top.equalTo(ivView).with.offset(10);
        
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 3;
    
    NSString *str = @"系统通知\n快来查看系统通知！";
    NSMutableAttributedString *richStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSDictionary *attributedDict = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0],
                                     NSForegroundColorAttributeName:[UIColor blackColor]
                                         };
    [richStr addAttributes:attributedDict
                     range:NSMakeRange(0, 4)];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 20;
    NSDictionary *attributedDict2 = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                                     NSForegroundColorAttributeName:[UIColor grayColor],
                                      NSParagraphStyleAttributeName:paragraphStyle
                                         };
    [richStr addAttributes:attributedDict2
                     range:NSMakeRange(5, 9)];
    
    [label setAttributedText:richStr];
    [sysView addSubview:label];
    
    //label.layer.borderWidth = 1.0;
    //label.layer.borderColor = [UIColor redColor].CGColor;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivView.mas_right).offset(15);
        make.top.equalTo(ivView).offset(10);
    }];
    
    UIView *line = [[UIView alloc] init];
    //下划线颜色
    UIColor *my_gray_color = [UIColor colorWithRed:196.0/255.0 green:196.0/255.0 blue:196.0/255.0 alpha:100];
    line.backgroundColor = my_gray_color;
    [sysView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_left);
        make.top.equalTo(sysView.mas_bottom);
        make.right.equalTo(sysView.mas_right);
        
        make.height.mas_equalTo(1);
    }];
}

- (void)showLike:(UIButton *)btn{
    //NSLog(@"Like");
    
    MegLikeViewController* vc = [[MegLikeViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showFollow:(UIButton *)btn{
    //NSLog(@"Follow");
    MegFollowViewController* vc = [[MegFollowViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showReply:(UIButton *)btn{
    //NSLog(@"Reply");
    MegReplyViewController* vc = [[MegReplyViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSyetem:(UIButton *)btn{
    //NSLog(@"System");
    MegSystemViewController* vc = [[MegSystemViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getLike{
    NSString *urlString = @"http://172.18.178.56/api/like";
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
                NSLog(@"getLike %@",responseObject);
            }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
    }];
}

@end
