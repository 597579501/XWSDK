//
//  XWDBHelper.h
//  XWSDK
//
//  Created by Seven on 2023/5/6.
//

#import <Foundation/Foundation.h>

@class XWUserLoginRecordModel;

NS_ASSUME_NONNULL_BEGIN

@interface XWDBHelper : NSObject

+ (instancetype)sharedDBHelper;

- (NSMutableArray *)getAllUsers;

- (void)addUser:(XWUserLoginRecordModel *)user;

- (void)deleteUser:(NSString *)username;

- (XWUserLoginRecordModel *)getLastLoginUser;

@end

NS_ASSUME_NONNULL_END
