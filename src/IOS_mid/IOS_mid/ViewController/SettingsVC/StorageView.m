//
//  StorageViewController.m
//  IOS_mid
//
//  Created by Khynnn on 2020/11/24.
//
#import "StorageView.h"
#import "Masonry.h"
#import "UserInfo.h"

@interface StorageView()

@end

@implementation StorageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self ) {
        [self initContent];
    }
    return self;
}
 
- (void)initContent{
    UIWindow *window =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    self.frame = CGRectMake(0, 0, window.frame.size.width, window.frame.size.height);
    //NSLog(@"%f,%f",self.frame.size.height,self.frame.size.width);
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.2;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlert)]];
 
    if (_contentView == nil){
        self.contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 8;
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            
            make.height.mas_equalTo(400);
        }];
        
        [self addElement];
    }
    
}

- (void)addElement{
    //NSLog(@"addElement");
    UILabel *label = [[UILabel alloc] init];
    label.text = @"存储额度(KB)";
    label.font = [UIFont boldSystemFontOfSize:20];
    //label.layer.borderWidth = 1.0;
    //label.layer.borderColor = [UIColor redColor].CGColor;
    [self.contentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.top.equalTo(self.contentView).with.offset(20);
    }];
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setTitle:@"x" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:23];
    [closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //closeBtn.layer.borderWidth = 1.0;
    //closeBtn.layer.borderColor = [UIColor redColor].CGColor;
    [closeBtn addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_top);
        make.left.equalTo(label.mas_right).offset(100);
        make.right.equalTo(self.contentView).with.offset(-15);
        //make.width.mas_equalTo(20);
        make.height.mas_equalTo(label.mas_height);
    }];
    
    UIView* lineView = [[UIView alloc] init];
    //下划线颜色
    UIColor *my_gray_color = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:100];
    lineView.backgroundColor = my_gray_color;
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_left);
        make.top.equalTo(label.mas_bottom).offset(5);
        make.right.equalTo(_contentView.mas_right).with.offset(-15);
        
        make.height.mas_equalTo(1);
    }];
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.text = @"存储库使用最大上限";
    label_1.font = [UIFont systemFontOfSize:18];
    //label_1.layer.borderWidth = 1.0;
    //label_1.layer.borderColor = [UIColor redColor].CGColor;
    [self.contentView addSubview:label_1];
    
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_left);
        make.top.equalTo(lineView.mas_bottom).offset(20);
        
        make.width.mas_equalTo(self.frame.size.width/2);
    }];
    
    if(_MaxSize == nil){
        self.MaxSize = [[UILabel alloc] init];
        _MaxSize.font = [UIFont systemFontOfSize:18];
        //_MaxSize.layer.borderWidth = 1.0;
        //_MaxSize.layer.borderColor = [UIColor redColor].CGColor;
        NSNumber* temp = [[UserInfo singleInstance].info valueForKey:@"MaxSize"];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        NSString* str = [numberFormatter stringFromNumber:temp];
        if([temp isEqual:@"-1"])
            _MaxSize.text = @"无上限";
        else
            _MaxSize.text = str;
        //_MaxSize.text = @"max";
        [self.contentView addSubview:_MaxSize];
    }
    
    [_MaxSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(closeBtn.mas_right);
        make.top.equalTo(label_1.mas_top);
    }];
    
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.text = @"存储库已用大小";
    label_2.font = [UIFont systemFontOfSize:18];
    //label_2.layer.borderWidth = 1.0;
    //label_2.layer.borderColor = [UIColor redColor].CGColor;
    [self.contentView addSubview:label_2];
    
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label_1.mas_left);
        make.top.equalTo(label_1.mas_bottom).offset(20);
        
        make.width.mas_equalTo(self.frame.size.width/2);
    }];
    
    if(_UsedSize == nil){
        self.UsedSize = [[UILabel alloc] init];
        _UsedSize.font = [UIFont systemFontOfSize:18];
        //_UsedSize.layer.borderWidth = 1.0;
        //_UsedSize.layer.borderColor = [UIColor redColor].CGColor;
        NSNumber* temp = [[UserInfo singleInstance].info valueForKey:@"UsedSize"];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        NSString* str = [numberFormatter stringFromNumber:temp];
        self.UsedSize.text = str;
        //_UsedSize.text = @"uesd";
        [self.contentView addSubview:_UsedSize];
    }
    
    [_UsedSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(closeBtn.mas_right);
        make.top.equalTo(label_2.mas_top);
    }];
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.text = @"存储库已用大小";
    label_3.font = [UIFont systemFontOfSize:18];
    //label_3.layer.borderWidth = 1.0;
    //label_3.layer.borderColor = [UIColor redColor].CGColor;
    [self.contentView addSubview:label_3];
    
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label_1.mas_left);
        make.top.equalTo(label_2.mas_bottom).offset(20);
        
        make.width.mas_equalTo(self.frame.size.width/2);
    }];
    
    if(_SingleSize == nil){
        self.SingleSize = [[UILabel alloc] init];
        _SingleSize.font = [UIFont systemFontOfSize:18];
        //_SingleSize.layer.borderWidth = 1.0;
        //_SingleSize.layer.borderColor = [UIColor redColor].CGColor;
        //self.SingleSize.text = [[UserInfo singleInstance].info valueForKey:@"SingleSize"];
        NSNumber* temp = [[UserInfo singleInstance].info valueForKey:@"SingleSize"];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        NSString* str = [numberFormatter stringFromNumber:temp];
        if([temp isEqual:@"-1"])
            _SingleSize.text = @"无上限";
        else
            _SingleSize.text = str;
        //_SingleSize.text = @"single";
        [self.contentView addSubview:_SingleSize];
    }
    
    [_SingleSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(closeBtn.mas_right);
        make.top.equalTo(label_3.mas_top);
    }];
}

- (void)showAlert:(UIView *)view{
    if (!view) {
        return;
    }
    [view addSubview:self];
    //遮罩
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.5;
    }];
    
    [view addSubview:_contentView];
    //NSLog(@"add");
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        
        make.height.mas_equalTo(400);
    }];
    //[self addElement];
    //NSLog(@"test3");
    self.contentView.transform = CGAffineTransformMakeTranslation(0.01, view.frame.size.height);
    [UIView animateWithDuration:0.3
                     animations:^{
        //NSLog(@"test3");
        self.contentView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
    }];
}
 
- (void)dismissAlert {
    UIWindow *window =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0.01, window.frame.size.height);
        self.contentView.alpha = 0.2;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.contentView removeFromSuperview];
    }];
}
 

@end
