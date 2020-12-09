//
//  SetUpViewController.h
//  IOS_mid
//
//  Created by 车春江 on 2020/11/19.
//  Copyright © 2020 车春江. All rights reserved.
//

#ifndef SetUpViewController_h
#define SetUpViewController_h
#import <UIKit/UIKit.h>

@interface SetUpViewController : UIViewController

@property (nonatomic,strong) UIView *back;
@property (nonatomic,strong) UIView *data;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *bio;
@property (nonatomic, strong) UIImageView *head;

@property (nonatomic, strong)UILabel *unread;

@end

#endif /* SetUpViewController_h */
