//
//  ContentCell.m
//  IOS_mid
//
//  Created by 车春江 on 2020/11/23.
//  Copyright © 2020 车春江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentCell.h"
#import <Masonry.h>
#import "UIControlFlagView.h"
#import "YMOpenAnimation.h"
#import "CommentCell.h"
#import "FBYImageZoom.h"
#import "CommentInfo.h"
#import <AFNetworking.h>
#import <SDWebImage.h>

@interface ContentCell()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UIImageView* headView;
@property(nonatomic, strong) UILabel* username;
@property(nonatomic, strong) UILabel* text;
@property(nonatomic, strong) UIControlFlagView* flag;
@property(nonatomic, strong) UIButton* like;
@property(nonatomic, strong) UIButton* addCommentButton;
@property(nonatomic, strong) NSMutableArray* commentList;
@property(nonatomic, strong) NSMutableArray* imagesView;
@property(nonatomic, strong) UITableView* commentView;
@property(nonatomic, strong) NSString* content_id;
@property(strong, nonatomic) NSString* user_id;
@property(strong, nonatomic) NSString* user_name;
@property int like_num;
@end

NSString *base_url;
NSString *comment_url = @"http://172.18.178.56/api/comment";
AFHTTPSessionManager *manage;
NSString *cellIdentifier = @"CommentCell";

@implementation ContentCell


- (ContentCell*) initWithName:(NSString*)username Text:(NSString*)text Comment:(NSString*)comment Images:(NSArray*)images{
    if(self=[super initWithFrame:CGRectMake(10, 50, 100, 60)]){
        self.username_ = username;
        self.text_ = text;
        self.imageView = images;
    }
    return self;
}

- (ContentCell*)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        [self setupUI];
        [self layout];
    }
    return self;
}

- (void)setupUI{
    
    self.like_num = 0;
    
    self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.headView.image = [UIImage imageNamed:@"faker"];

    self.username = [[UILabel alloc] init];
    self.username.text = @"昵称";

    self.text = [[UILabel alloc] init];
    self.text.text = @"文本内容";
    
    self.flag = [[UIControlFlagView alloc]initWithFrame:CGRectMake(10, 50, 30, 30)];
    self.flag.flag = FlagModelNO;
    self.flag.yesStateImg = [UIImage imageNamed:@"heart2"];
    self.flag.noStateImg = [UIImage imageNamed:@"heart1"];
    [self.flag setFlag:FlagModelNO withAnimation:nil];
    
    
    self.like = [[UIButton alloc]init];
    [self.like setTitle:@"点赞" forState:UIControlStateNormal];
    [self.like addTarget:self action:@selector(Like) forControlEvents:UIControlEventTouchUpInside];
    self.like.layer.borderColor = [[UIColor blackColor] CGColor];
    self.like.layer.borderWidth = 1;
    [self.like setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    

    self.addCommentButton = [[UIButton alloc]init];
    [self.addCommentButton setTitle:@"评论" forState:UIControlStateNormal];
    [self.addCommentButton addTarget:self action:@selector(AddComment:) forControlEvents:UIControlEventTouchUpInside];
    self.addCommentButton.layer.borderColor = [[UIColor blackColor] CGColor];
    self.addCommentButton.layer.borderWidth = 1;
    [self.addCommentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.commentList = [[NSMutableArray alloc]initWithObjects:nil];
    
//    UILabel* comment2 = [[UILabel alloc] init];
//    comment2.text = @"A: I am Faker";
//    [self.commentList addObject:comment2];
//
//    UILabel* comment3 = [[UILabel alloc] init];
//    comment3.text = @"B: I am Theshy";
//    [self.commentList addObject:comment3];
//
//    UILabel* comment4 = [[UILabel alloc] init];
//    comment4.text = @"C: I am Nugury";
//    [self.commentList addObject:comment4];
    
//    UIImageView* img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
//    UIImageView* img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2"]];
//    UIImageView* img3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3"]];
//    UIImageView* img4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"4"]];
//    UIImageView* img5 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"5"]];
//    UIImageView* img6 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"6"]];
//    self.imagesView = [[NSMutableArray alloc]initWithObjects:img1,img2,img3,img4,img5,img6,nil];
    self.imagesView = [[NSMutableArray alloc]initWithObjects:nil];
    
//    NSLog(@"%d", self.commentList.count);
    
    //创建布局对象
    
    self.commentView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
//    self.commentView.backgroundColor = [UIColor redColor];
    //注册
    [self.commentView registerClass:[CommentCell class]
    forCellReuseIdentifier:cellIdentifier];
    //指定数据源和代理
    self.commentView.delegate = self;
    self.commentView.dataSource = self;
    
    
//    for(int i = 0;i < self.imagesView.count;i++){
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
//        [self.imagesView[i] addGestureRecognizer:tapGestureRecognizer];
//        [self.imagesView[i] setUserInteractionEnabled:YES];
////        NSLog(@"%d", i);
//    }
    
    manage = [AFHTTPSessionManager manager];
    manage.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    base_url = @"http://172.18.178.56/api/";
    
    [self addSubview:self.headView];
    [self addSubview:self.username];
    [self addSubview:self.text];
//    [self addSubview:self.comment];
    [self addSubview:self.flag];
    [self addSubview:self.like];
    [self addSubview:self.addCommentButton];
//    for(int i = 0;i < self.commentList.count;i++){
//        [self addSubview:self.commentList[i]];
//    }
//    for(int i = 0;i < self.imagesView.count;i++){
//        [self addSubview:self.imagesView[i]];
//    }
    [self addSubview:self.commentView];
    
}

//浏览大图点击事件
-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [FBYImageZoom ImageZoomWithImageView:clickedImageView];
}

- (void)layout{
//    [self addSubview:self.username];
//    [self addSubview:self.text];
////    [self addSubview:self.comment];
//    [self addSubview:self.flag];
//    [self addSubview:self.like];
//    [self addSubview:self.addComment];
//    [self addSubview:self.addCommentButton];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).mas_offset(10);
        make.left.equalTo(self.mas_left).mas_offset(10);
        make.right.equalTo(self.mas_left).mas_offset(60);
        make.bottom.equalTo(self.mas_top).mas_offset(60);
    }];
    
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).mas_offset(10);
        make.left.equalTo(self.headView.mas_right).mas_offset(10);
        make.right.equalTo(self.mas_right).mas_offset(-10);
        make.bottom.equalTo(self.mas_top).mas_offset(60);
    }];
    
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.username.mas_bottom).mas_offset(10);
        make.left.equalTo(self.mas_left).mas_offset(10);
        make.right.equalTo(self.mas_right).mas_offset(-10);
//        make.bottom.equalTo(self.username.mas_bottom).mas_offset(100);
    }];
    
    for(int i = 0;i < self.imagesView.count;i++){
        if(i==0){
            [self.imagesView[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.text.mas_bottom).mas_offset(10);
                make.left.equalTo(self.mas_left).mas_offset(40);
                make.right.equalTo(self.mas_left).mas_offset(140);
                make.bottom.equalTo(self.text.mas_bottom).mas_offset(110);
            }];
        }else if(i==3){
            UIImageView* tmp = self.imagesView[0];
            [self.imagesView[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tmp.mas_bottom).mas_offset(10);
                make.left.equalTo(tmp.mas_left).mas_offset(0);
                make.right.equalTo(tmp.mas_right).mas_offset(0);
                make.bottom.equalTo(tmp.mas_bottom).mas_offset(110);
            }];
        }else if(i < 3){
            UIImageView* tmp = self.imagesView[i-1];
            [self.imagesView[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.text.mas_bottom).mas_offset(10);
                make.left.equalTo(tmp.mas_right).mas_offset(10);
                make.right.equalTo(tmp.mas_right).mas_offset(110);
                make.bottom.equalTo(self.text.mas_bottom).mas_offset(110);
            }];
        }else{
            UIImageView* tmp = self.imagesView[i-1];
            UIImageView* tmp0 = self.imagesView[0];
            [self.imagesView[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tmp0.mas_bottom).mas_offset(10);
                make.left.equalTo(tmp.mas_right).mas_offset(10);
                make.right.equalTo(tmp.mas_right).mas_offset(110);
                make.bottom.equalTo(tmp0.mas_bottom).mas_offset(110);
            }];
        }
    }
//    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.text.mas_bottom).mas_offset(10);
//        make.left.equalTo(self.mas_left).mas_offset(10);
//        make.right.equalTo(self.mas_right).mas_offset(-10);
//    }];
//    UILabel* front_comment = [[UILabel alloc] init];
//    for(int i = 0;i < self.commentList.count && i < 3;i++){
//        UILabel* t_comment = self.commentList[i];
////        [self addSubview:t_comment];
//        if(i == 0){
//            [t_comment mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.text.mas_bottom).mas_offset(10);
//                make.left.equalTo(self.mas_left).mas_offset(10);
//                make.right.equalTo(self.mas_right).mas_offset(-10);
//            }];
//        }
//        else{
//            [t_comment mas_makeConstraints:^(MASConstraintMaker *make) {
//
//                make.top.equalTo(front_comment.mas_bottom).mas_offset(10);
//                make.left.equalTo(self.mas_left).mas_offset(10);
//                make.right.equalTo(self.mas_right).mas_offset(-10);
//            }];
//        }
//        front_comment = t_comment;
//    }
    if(self.imagesView.count){
        UIImageView* front_img = self.imagesView[self.imagesView.count-1];
        [self.flag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(front_img.mas_bottom).mas_offset(10);
            make.left.equalTo(self.mas_left).mas_offset(10);
            make.right.equalTo(self.mas_left).mas_offset(60);
            make.bottom.equalTo(front_img.mas_bottom).mas_offset(50);
        }];
        
        [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(front_img.mas_bottom).mas_offset(10);
            make.left.equalTo(self.mas_right).mas_offset(-120);
            make.right.equalTo(self.mas_right).mas_offset(-70);
            make.bottom.equalTo(front_img.mas_bottom).mas_offset(50);
        }];
        
        
        [self.addCommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(front_img.mas_bottom).mas_offset(10);
            make.left.equalTo(self.mas_right).mas_offset(-60);
            make.right.equalTo(self.mas_right).mas_offset(-10);
            make.bottom.equalTo(front_img.mas_bottom).mas_offset(50);
        }];
    }
    else{
        [self.flag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.text.mas_bottom).mas_offset(10);
            make.left.equalTo(self.mas_left).mas_offset(10);
            make.right.equalTo(self.mas_left).mas_offset(60);
            make.bottom.equalTo(self.text.mas_bottom).mas_offset(50);
        }];
        
        [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.text.mas_bottom).mas_offset(10);
            make.left.equalTo(self.mas_right).mas_offset(-120);
            make.right.equalTo(self.mas_right).mas_offset(-70);
            make.bottom.equalTo(self.text.mas_bottom).mas_offset(50);
        }];
        
        
        [self.addCommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.text.mas_bottom).mas_offset(10);
            make.left.equalTo(self.mas_right).mas_offset(-60);
            make.right.equalTo(self.mas_right).mas_offset(-10);
            make.bottom.equalTo(self.text.mas_bottom).mas_offset(50);
        }];
    }
    
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addCommentButton.mas_bottom).mas_offset(10);
        make.left.equalTo(self.mas_left).mas_offset(10);
        make.right.equalTo(self.mas_right).mas_offset(-10);
        make.bottom.equalTo(self.mas_bottom).mas_offset(-10);
    }];
    
    
//    self.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.layer.borderWidth = 1;
}

- (void)setupContenWithName:(NSString*)username Text:(NSString*)text Comment:(NSString *)comment Images:(NSArray *)images{
    
    self.username_ = username;
    self.text_ = text;
    self.imageView = images;
    
    self.username.text = username;
    self.text.text = text;
}

- (void)Like{
    NSDictionary *parameters = @{@"isContent":@YES};
    NSString *like_url = [base_url stringByAppendingFormat:@"%@%@", @"like/", self.content_id];
    if(self.flag.flag){
        [self.flag setFlag:FlagModelNO withAnimation:nil];
        [manage PATCH:like_url parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"patch like failure");
        }];
    }
    else{
        [self.flag setFlag:FlagModelYES withAnimation:nil];
        [manage POST:like_url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            //
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"like failure");
        }];
    }
}

- (void)AddComment:(NSString*)com{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"添加评论"
                                                                       message:@""
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  //响应事件
                                                                  //得到文本信息
    //                                                              for(UITextField *text in alert.textFields){
    //                                                                  NSLog(@"text = %@", text.text);
    //                                                              }
            UITextField *text = alert.textFields[0];
//            UILabel* comment3 = [[UILabel alloc] init];
//            comment3.text = [@"评论: " stringByAppendingFormat:@"%@",text.text];
            CommentInfo* comment = [[CommentInfo alloc]initWithFrom:self.user_name To:@"publisher" Content:text.text ID:nil];
            NSDictionary* comment_param = @{@"contentID":self.content_id,@"fatherID":self.user_id,@"content":text.text,@"reply":@NO};

            [manage POST:comment_url parameters:comment_param headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                //
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"comment failure");
            }];
            [self.commentList addObject:comment];
        //    [self addSubview:comment3];
        //    [self DeleteMasonry];
        //    [self layout];
            [self.commentView reloadData];
//            NSLog(@"text = %@", text.text);
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 NSLog(@"action = %@", alert.textFields);
                                                             }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"回复内容";
        }];
    //    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    //        textField.placeholder = @"密码";
    //        textField.secureTextEntry = YES;
    //    }];
        
        [alert addAction:okAction];
        [alert addAction:cancelAction];
    //    [self presentViewController:alert animated:YES completion:nil]; //以模态弹出的方式让弹出框出现
        UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        if ( viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed ) {
            viewController = viewController.presentedViewController;
        }

        NSLayoutConstraint *constraint = [NSLayoutConstraint
            constraintWithItem:alert.view
            attribute:NSLayoutAttributeHeight
            relatedBy:NSLayoutRelationLessThanOrEqual
            toItem:nil
            attribute:NSLayoutAttributeNotAnAttribute
            multiplier:1
            constant:viewController.view.frame.size.height*2.0f];

        [alert.view addConstraint:constraint];
        [viewController presentViewController:alert animated:YES completion:^{}];
}

- (void)initWithJson:(NSDictionary*)json_data{
    [self.commentList removeAllObjects];
    [self.imagesView removeAllObjects];
//    for(int i = 0;i < self.imagesView.count;i++){
//        [self.imagesView[i] removeFromSuperview];
//    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupUI];
    self.user_name = @"faker";
    self.content_id = json_data[@"Data"][@"ID"];
    self.user_id = @"5fc7ac2af5beb2def128d8ec";
    self.username.text = json_data[@"User"][@"Name"];
    self.text.text = json_data[@"Data"][@"Detail"];
    NSMutableArray* images = json_data[@"Data"][@"Album"][@"Images"];
    self.like_num = (int)json_data[@"Data"][@"LikeNum"];
    NSLog(@"%d",self.like_num);
    [self DeleteMasonry];
    [self getImages:images];
    [self getComment:json_data[@"Data"][@"ID"]];
    [self layout];
}

- (void)getComment:(NSString*)content_ID{
    NSString *getcomments_url = [base_url stringByAppendingFormat:@"%@%@",@"comment/",content_ID];
//    NSLog(@"%@",getcomments_url);
    [manage GET:getcomments_url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray* comments = responseObject[@"Data"];
//        NSLog(@"%@",comments);
        if([comments isKindOfClass:[NSNull class]]){
            return;
        }
        for(int i = 0;i < comments.count;i++){
            NSDictionary* comment = comments[i];
            NSDictionary* comment_user = comment[@"User"];
            NSDictionary* comment_text = comment[@"Comment"];
            NSString* user = comment_user[@"Name"];
            NSString* text = comment_text[@"Content"];
//            UILabel* curr_comment = [[UILabel alloc]init];
            CommentInfo* comment_info = [[CommentInfo alloc]initWithFrom:user To:@"publisher" Content:text ID:comment_text[@"ID"]];
//            curr_comment.text = [user stringByAppendingFormat:@": %@",text];
//            [self.commentList addObject:comment_info];
            [self.commentList addObject:comment_info];
            
            NSMutableArray* replies = comment[@"Replies"];
            if(![replies isKindOfClass:[NSNull class]]){
                for(int i = 0;i < replies.count;i++){
                    NSDictionary* reply = replies[i];
                    CommentInfo* comment_info = [[CommentInfo alloc]initWithFrom:reply[@"Father"][@"Name"] To:reply[@"User"][@"Name"] Content:reply[@"Reply"][@"Content"] ID:reply[@"Reply"][@"ID"]];
                    [self.commentList addObject:comment_info];
                }
            }
            [self.commentView reloadData];
        }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];

}

- (void)getImages:(NSMutableArray*)images{
    NSString *getimages_url = [base_url stringByAppendingFormat:@"%@",@"thumb/"];
    // 设置请求体为JSON
//    manage.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置响应体为JSON
//    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    for(int i = 0;i < images.count;i++){
//        NSString* curr_url = [getimages_url stringByAppendingFormat:@"%@", images[i][@"Thumb"]];
//        NSLog(@"%@",curr_url);
//        [manage GET:curr_url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                [self.imagesView addObject:responseObject];
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"%@",error);
//            }];
        NSString* curr_url = [getimages_url stringByAppendingFormat:@"%@", images[i][@"Thumb"]];
//        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:curr_url]]];
//        UIImageView* image_view = [[UIImageView alloc]initWithImage:image];
        UIImageView* image_view = [[UIImageView alloc]init];
        [image_view sd_setImageWithURL:[NSURL URLWithString:curr_url]];
        [self.imagesView addObject:image_view];
        
    }
    for(int i = 0;i < self.imagesView.count;i++){
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
        [self.imagesView[i] addGestureRecognizer:tapGestureRecognizer];
        [self.imagesView[i] setUserInteractionEnabled:YES];
//        NSLog(@"%d", i);
    }
    for(int i = 0;i < self.imagesView.count;i++){
        [self addSubview:self.imagesView[i]];
    }

}


- (void)DeleteMasonry{
    NSArray *array = [MASViewConstraint installedConstraintsForView:self.headView];
    for (MASConstraint *constraint in array) {
        [constraint uninstall];
    }
    
    array = [MASViewConstraint installedConstraintsForView:self.username];
    for (MASConstraint *constraint in array) {
        [constraint uninstall];
    }
    
    array = [MASViewConstraint installedConstraintsForView:self.text];
    for (MASConstraint *constraint in array) {
        [constraint uninstall];
    }
    
//    for(int i = 0;i < self.imagesView.count;i++){
//        array = [MASViewConstraint installedConstraintsForView:self.imagesView[i]];
//        for (MASConstraint *constraint in array) {
//            [constraint uninstall];
//        }
//    }
    
    for(int i = 0;i < self.commentList.count;i++){
        array = [MASViewConstraint installedConstraintsForView:self.commentList[i]];
        for (MASConstraint *constraint in array) {
            [constraint uninstall];
        }
    }
    
    array = [MASViewConstraint installedConstraintsForView:self.flag];
    for (MASConstraint *constraint in array) {
        [constraint uninstall];
    }
    
    array = [MASViewConstraint installedConstraintsForView:self.like];
    for (MASConstraint *constraint in array) {
        [constraint uninstall];
    }
    
    
    array = [MASViewConstraint installedConstraintsForView:self.addCommentButton];
    for (MASConstraint *constraint in array) {
        [constraint uninstall];
    }
    
    array = [MASViewConstraint installedConstraintsForView:self.commentView];
    for (MASConstraint *constraint in array) {
        [constraint uninstall];
    }
}

#pragma delegate

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    NSLog(@"将要编辑");
//
//
//
//    CGFloat offset = self.frame.size.height - (textField.frame.origin.y + textField.frame.size.height + 216 + 150);//150  是越大 文本框向上移动的距离越大 自己可以改变数值试一下
//
//    NSLog(@"offset %f",offset);
//
//
//
//    if (offset <= 0) {
//        [UIView animateWithDuration:0.3 animations:^{
//
//            CGRect frame = self.frame;
//
//            frame.origin.y = offset;
//
//            self.frame = frame;
//
//        }];
//
//    }
//
//    return YES;
//
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self endEditing:YES];
//}

#pragma UITableViewDataSource

 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     
     return self.commentList.count;//返回的数值是数组的个数
 }
 //cell
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     CommentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//     NSUInteger size = self.commentList.count;
     CommentInfo* content = self.commentList[indexPath.row];
//     UILabel* content = self.commentList[indexPath.row];
 //    [cell setupContenWithDate:[content date_] Dest:[content dest_] Mood:[content expr_]];
     
//     cell.backgroundColor = [UIColor redColor];
//     NSLog(@"%@ %@ %@",content.from,content.to,content.content);
     if([content.to  isEqual: @"publisher"]){
         cell.comment_text.text = [(NSString*)content.from stringByAppendingFormat:@": %@", content.content];
     }
     else{
         cell.comment_text.text = [(NSString*)content.from stringByAppendingFormat:@" 回复 %@: %@", content.to, content.content];
     }
//     cell.comment_text.text = content.text;
     cell.layer.borderWidth=1.0f;
     cell.layer.borderColor = [[UIColor blackColor] CGColor];
     cell.layer.cornerRadius = 5;
     return cell;
 }
 //行高
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"回复评论"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              //得到文本信息
//                                                              for(UITextField *text in alert.textFields){
//                                                                  NSLog(@"text = %@", text.text);
//                                                              }
        UITextField *text = alert.textFields[0];
        CommentInfo* comment = self.commentList[indexPath.row];
            NSDictionary* comment_param = @{@"contentID":comment.comment_id,@"fatherID":self.content_id,@"content":text.text,@"isReply":@YES};

            [manage POST:comment_url parameters:comment_param headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                //
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"comment failure");
            }];
        CommentInfo* reply = [[CommentInfo alloc]initWithFrom:self.user_name To:comment.from Content:text.text ID:nil];
            [self.commentList addObject:reply];
        //    [self addSubview:comment3];
        //    [self DeleteMasonry];
        //    [self layout];
            [self.commentView reloadData];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", alert.textFields);
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"回复内容";
    }];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"密码";
//        textField.secureTextEntry = YES;
//    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil]; //以模态弹出的方式让弹出框出现
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if ( viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed ) {
        viewController = viewController.presentedViewController;
    }

    NSLayoutConstraint *constraint = [NSLayoutConstraint
        constraintWithItem:alert.view
        attribute:NSLayoutAttributeHeight
        relatedBy:NSLayoutRelationLessThanOrEqual
        toItem:nil
        attribute:NSLayoutAttributeNotAnAttribute
        multiplier:1
        constant:viewController.view.frame.size.height*2.0f];

    [alert.view addConstraint:constraint];
    [viewController presentViewController:alert animated:YES completion:^{}];
}

@end
