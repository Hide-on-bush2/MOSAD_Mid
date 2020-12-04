//
//  ContentDetailsController.h
//  IOS_mid
//
//  Created by 车春江 on 2020/11/23.
//  Copyright © 2020 车春江. All rights reserved.
//

#ifndef ContentDetailsController_h
#define ContentDetailsController_h
#import <UIKit/UIKit.h>

@interface ContentDetailsController : UIViewController<UINavigationControllerDelegate>
- (ContentDetailsController*)initWithName:(NSString*)username Text:(NSString*)text Comment:(NSString*)comment Images:(NSArray*)images;
@end


#endif /* ContentDetailsController_h */
