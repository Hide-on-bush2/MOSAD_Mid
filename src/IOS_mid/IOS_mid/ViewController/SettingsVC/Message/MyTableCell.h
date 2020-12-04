//
//  MyTableCell.h
//  ios_mid
//
//  Created by Khynnn on 2020/12/3.
//

#import <UIKit/UIKit.h>

@interface MyTableCell : UITableViewCell

@property (nonatomic, strong)UIImageView *avatar;

@property (nonatomic, strong)NSString *ID;
@property (nonatomic, strong)NSString *read;

@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UILabel *time;
@property (nonatomic, strong)UILabel *content;

- (void)setID:(NSString *)text1
       Avatar:(NSString *)text2
         Name:(NSString *)text3
      Content:(NSString *)text4
         time:(NSString *)text5
         Read:(NSString *)flag;


@end
