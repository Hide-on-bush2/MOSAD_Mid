

#import "LLSegmentBarConfig.h"

@implementation LLSegmentBarConfig

+ (instancetype)defaultConfig {
    LLSegmentBarConfig *config = [[LLSegmentBarConfig alloc] init];
    config.sBBackColor = [UIColor clearColor];
    config.itemF = [UIFont systemFontOfSize:20];
    config.itemNC = [UIColor whiteColor];
    config.itemSC = [UIColor grayColor];
    config.indicatorC = [UIColor blackColor];
    config.indicatorH = 2;
    config.indicatorW = 10;
    return config;
    
}

- (LLSegmentBarConfig *(^)(UIColor *))segmentBarBackColor{
    return ^(UIColor *color){
        self.sBBackColor = color;
        return self;
    };
}

- (LLSegmentBarConfig *(^)(UIFont *))itemFont{
    return ^(UIFont *font){
        self.itemF = font;
        return self;
    };
}

- (LLSegmentBarConfig *(^)(UIColor *))itemNormalColor{
    return ^(UIColor *color){
        self.itemNC = color;
        return self;
    };
}

- (LLSegmentBarConfig *(^)(UIColor *))itemSelectColor{
    return ^(UIColor *color){
        self.itemSC = color;
        return self;
    };
}

- (LLSegmentBarConfig *(^)(UIColor *))indicatorColor{
    return ^(UIColor *color){
        self.indicatorC = color;
        return self;
    };
}

- (LLSegmentBarConfig *(^)(CGFloat))indicatorHeight{
    return ^(CGFloat H){
        self.indicatorH = H;
        return self;
    };
}

- (LLSegmentBarConfig *(^)(CGFloat))indicatorExtraW{
    return ^(CGFloat W){
        self.indicatorW = W;
        return self;
    };
}


@end
