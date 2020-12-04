//
//  SettingNameViewController.h
//  ios_mid
//
//  Created by Khynnn on 2020/12/1.
//
#import <UIKit/UIKit.h>

@interface SettingNameViewController : UIViewController

@property (nonatomic, strong) UIBarButtonItem *barItem;
@property (nonatomic, strong) UIButton *btn_sava;

@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UILabel *tip;

@property (nonatomic, strong) UILabel *num;
@property(assign,nonatomic)int maxWowdLimit;

@end
