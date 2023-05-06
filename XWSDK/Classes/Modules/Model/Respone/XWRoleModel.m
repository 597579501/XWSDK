//
//  XWRoleModel.m
//  XWSDK
//
//  Created by Seven on 2023/5/3.
//

#import "XWRoleModel.h"

@implementation XWRoleModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"userId" : @"user_id",
        @"serverId" : @"server_id",
        @"serverName" : @"server_name",
        @"roleId" : @"role_id",
        @"roleName" : @"role_name",
        @"roleLevel" : @"role_level",
    };
}


@end
