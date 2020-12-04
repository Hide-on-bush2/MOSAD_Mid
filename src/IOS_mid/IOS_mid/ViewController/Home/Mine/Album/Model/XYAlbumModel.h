#import <Foundation/Foundation.h>

@class XYAlbumModel;
@class XYAlbum;
@class XYImage;
@class XYFile;
@class XYApp;
@class XYMovie;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface XYAlbumModel : NSObject
@property (nonatomic, copy)   NSArray *files;
@property (nonatomic, assign) NSInteger publishDate;
@property (nonatomic, assign) NSInteger likeNum;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *albumModelID;
@property (nonatomic, assign) NSInteger editDate;
@property (nonatomic, copy)   NSString *subType;
@property (nonatomic, copy)   NSArray *tag;
@property (nonatomic, strong) XYMovie *movie;
@property (nonatomic, strong) XYAlbum *album;
@property (nonatomic, strong) XYApp *app;
@property (nonatomic, assign) NSInteger commentNum;
@property (nonatomic, assign) BOOL isPublic;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *detail;
@property (nonatomic, copy)   NSString *ownID;
@property (nonatomic, copy)   NSArray *image;
@property (nonatomic, assign) BOOL isNative;
@property (nonatomic, copy)   NSString *remarks;
@end

@interface XYAlbum : NSObject
@property (nonatomic, copy)   NSArray<XYImage *> *images;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *location;
@end

@interface XYImage : NSObject
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, strong) XYFile *file;
@property (nonatomic, copy)   NSString *thumb;
@property (nonatomic, assign) BOOL isNative;
@end

@interface XYFile : NSObject
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *file;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger count;
@end

@interface XYApp : NSObject
@property (nonatomic, copy)   NSArray *image;
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, strong) XYFile *file;
@property (nonatomic, copy)   NSString *version;
@property (nonatomic, copy)   NSString *web;
@end

@interface XYMovie : NSObject
@property (nonatomic, copy)   NSString *detail;
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, strong) XYFile *file;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, assign) BOOL isWatched;
@property (nonatomic, copy)   NSArray *image;
@end

NS_ASSUME_NONNULL_END
