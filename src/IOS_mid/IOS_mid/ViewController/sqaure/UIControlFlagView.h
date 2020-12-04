//
//  UIControlFlagView.h
//  IOS_mid
//
//  Created by 车春江 on 2020/11/24.
//  Copyright © 2020 车春江. All rights reserved.
//

#ifndef UIControlFlagView_h
#define UIControlFlagView_h
#import <UIKit/UIKit.h>
 
typedef NS_ENUM(NSInteger, UIControlFlagMode) {
    FlagModelNO,
    FlagModelYES,
    FlagModelDefalt
};
 
@interface UIControlFlagView : UIControl
 
 
@property (nonatomic, strong) UIImage*noStateImg;
@property (nonatomic, strong) UIImage*yesStateImg;
@property (nonatomic, strong) UIImage*defaultStateImg;
 
@property (nonatomic, assign) UIControlFlagMode flag;
 
- (void)setFlag:(UIControlFlagMode)flag withAnimation:(BOOL)animation;
 
@end

#endif /* UIControlFlagView_h */
