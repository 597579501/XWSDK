//
//  XWUserModel.m
//  XWSDK
//
//  Created by Seven on 2023/4/28.
//

#import "XWUserModel.h"

@implementation XWUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"isBindphone" : @"is_bindphone",
        @"isAdult" : @"is_adult",
        @"userId" : @"user_id",
        @"userPhone" : @"user_phone",
        @"isIdauth" : @"is_idauth",
        @"idAuth" : @"id_auth",
        @"isPhonePop" : @"is_phone_pop",
        @"userName" : @"user_name",
        @"noticePopup" : @"notice_popup",
        @"noticeNoPopup" : @"notice_no_popup",
        @"auditVersion" : @"ios_audit_version",
        @"remainingTime" : @"remaining_time",
        @"sessionId" : @"session_id",
    };
}

@end

