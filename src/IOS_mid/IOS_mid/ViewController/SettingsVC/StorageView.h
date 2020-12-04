//
//  StorageViewController.h
//  IOS_mid
//
//  Created by Khynnn on 2020/11/24.
//
#import <UIKit/UIKit.h>

@interface StorageView : UIView

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *MaxSize;
@property (nonatomic,strong) UILabel *UsedSize;
@property (nonatomic,strong) UILabel *SingleSize;

- (void)showAlert:(UIView *)view;
- (void)dismissAlert;

@end
