//
//  AlbumModel.m
//  ios_mid
//
//  Created by wl on 2020/12/4.
//


#import "XYAlbumModel.h"

@implementation XYAlbumModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"album" : @"Album",
             @"isPublic" : @"Pubilc",
             @"likeNum":@"LikeNum",
             @"commentNum": @"CommentNum",
             @"detail": @"Detail"
    };
}
@end

@implementation XYAlbum

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"images" : @"Images",
        @"time": @"Time",
        @"title": @"Title",
        @"location": @"Location"
    };
}


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"images": [XYImage class],
    };
}
@end

@implementation XYImage
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"thumb": @"Thumb"
    };
}
@end

@implementation XYFile
@end

@implementation XYApp
@end

@implementation XYMovie
@end
