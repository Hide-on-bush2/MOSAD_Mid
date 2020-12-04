//
//  ContentCell.h
//  IOS_mid
//
//  Created by 车春江 on 2020/11/23.
//  Copyright © 2020 车春江. All rights reserved.
//

#ifndef ContentCell_h
#define ContentCell_h

#import <UIKit/UIKit.h>

@interface ContentCell : UICollectionViewCell
@property(nonatomic, strong) NSString* username_;
@property(nonatomic, strong) NSString* text_;
@property(nonatomic, strong) NSString* comment_;
@property (strong, nonatomic) NSArray *imageView;
- (void)setupContenWithName:(NSString*)username Text:(NSString*)text Comment:(NSString*)comment  Images:(NSArray*)images;
- (ContentCell*)initWithName:(NSString*)username Text:(NSString*)text Comment:(NSString*)comment Images:(NSArray*)images;
- (void)initWithJson:(NSDictionary*)json_data;
@end

#endif /* ContentCell_h */
