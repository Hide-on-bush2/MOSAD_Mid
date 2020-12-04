//
//  MyTableCell.m
//  ios_mid
//
//  Created by Khynnn on 2020/12/3.
//
#import "MyTableCell.h"

#import "Masonry.h"

@interface MyTableCell ()

@end

@implementation MyTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   if (self) {
       [self setLabel];
   }
   return self;
}

- (void)setID:(NSString *)text1
       Avatar:(NSString *)text2
         Name:(NSString *)text3
      Content:(NSString *)text4
         time:(NSString *)text5
         Read:(NSString *)flag{
    self.ID = text1;
    self.url = text2;
    self.name.text = text3;
    self.content.text = text4;
    self.time.text = [self ConvertStrToTime:text5];
    self.read = flag;
}

- (void)setLabel{
    UIImage* image;
    if([_url isEqual:@""] || _url == nil){
        image = [UIImage imageNamed:@"DefaultAvatar"];
    }
    else{
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_url]];
        image = [UIImage imageWithData:data];
    }
    _avatar = [[UIImageView alloc] initWithImage:image];
    _avatar.layer.cornerRadius = 25;
    _avatar.layer.masksToBounds = YES;
    _avatar.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_avatar];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.top.equalTo(self.contentView).with.offset(15);
        
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    _name = [[UILabel alloc] init];
    _name.text = @"";
    _name.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(10);
        make.top.equalTo(_avatar);
    }];
    
    _content = [[UILabel alloc] init];
    _content.text = @"";
    _content.font = [UIFont boldSystemFontOfSize:13];
    _content.textColor = [UIColor grayColor];
    [self.contentView addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name);
        make.top.equalTo(_name.mas_bottom).offset(10);
    }];
    
    _time = [[UILabel alloc] init];
    _time.text = @"";
    _time.font = [UIFont boldSystemFontOfSize:13];
    _time.textColor = [UIColor grayColor];
    [self.contentView addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-10);
        make.top.equalTo(_name);
    }];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSString *)ConvertStrToTime:(NSString *)timeStr{

    long long time=[timeStr longLongValue];
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;

    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString*timeString=[formatter stringFromDate:date];

    return timeString;

}


@end
