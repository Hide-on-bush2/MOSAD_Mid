//
//  MessageData.h
//  ios_mid
//
//  Created by Khynnn on 2020/12/3.
//

@interface MessageData:NSObject

@property(nonatomic, strong)NSMutableArray *like;
@property(nonatomic, strong)NSMutableArray *reply;
@property(nonatomic, strong)NSMutableArray *system;
@property(nonatomic, strong)NSMutableArray *follow;

+(instancetype)singleInstance;
-(void)getMeg;

-(void)readAction:(NSString *)ID;
-(void)deleteAction:(NSString *)ID;
@end
