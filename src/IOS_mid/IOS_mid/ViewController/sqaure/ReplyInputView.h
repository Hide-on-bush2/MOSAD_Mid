//
//  ReplyInputView.h
//  IOS_mid
//
//  Created by 车春江 on 2020/11/24.
//  Copyright © 2020 车春江. All rights reserved.
//

#ifndef ReplyInputView_h
#define ReplyInputView_h

#import <UIKit/UIKit.h>
//改变根据文字改变TextView的高度
typedef void (^ContentSizeBlock)(CGSize contentSize);
//添加评论
typedef void (^replyAddBlock)(NSString *replyText,NSInteger inputTag);
@interface ReplyInputView : UIView
@property (nonatomic,assign)NSInteger replyTag;

-(void)setContentSizeBlock:(ContentSizeBlock) block;
-(void)setReplyAddBlock:(replyAddBlock)block;
-(id)initWithFrame:(CGRect)frame andAboveView:(UIView *)bgView;
@end


#endif /* ReplyInputView_h */
