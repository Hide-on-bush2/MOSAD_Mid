//
//  InfoViewController.h
//  IOS_mid
//
//  Created by Khynnn on 2020/11/24.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
//基本信息
@property (nonatomic, strong) UIView *email;
@property (nonatomic, strong) UIView *type;

//个性化信息
@property (nonatomic, strong) UIImageView *head;

@property (nonatomic, strong) UIView *name;
@property (nonatomic, strong) UIView *bio;
@property (nonatomic, strong) UIView *gender;

@end
