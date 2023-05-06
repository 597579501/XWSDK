//
//  XWRoleModel.h
//  XWSDK
//
//  Created by Seven on 2023/5/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWRoleModel : NSObject
@property (nonatomic ,strong) NSString *userId;
@property (nonatomic ,strong) NSString *serverId;
@property (nonatomic ,strong) NSString *serverName;
@property (nonatomic ,strong) NSString *roleId;
@property (nonatomic ,strong) NSString *roleName;
@property (nonatomic ,strong) NSString *roleLevel;

@end

NS_ASSUME_NONNULL_END
