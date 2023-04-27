//
//  XWSDKViewModel.m
//  XWSDK
//
//  Created by Seven on 2023/4/27.
//

#import "XWSDKViewModel.h"
#import "XWApiDomainServer.h"
#import "XWGwDomainServer.h"
#import "SWConfModel.h"


@implementation XWSDKViewModel

- (void)conf:(NSString *)appId appKey:(NSString *)appKey
{
    [XWCommonModel sharedInstance].appId = appId;
    [XWCommonModel sharedInstance].appKey = appKey;
//    self.commonModel.appKey = appKey;
    
    
    
    
    [XWGwDomainServer conf:^(id data) {
        SWConfModel *confModel = [SWConfModel yy_modelWithJSON:data];
        
    } failure:^(NSString *errorMessage) {
        
    }];
}

- (void)reg:(NSString *)name password:(NSString *)password code:(NSString *)code
{
    [XWGwDomainServer reg:name password:password code:code success:^(id data) {
        NSString *userId = data[@"user_id"];

    } failure:^(NSString *errorMessage) {
        
    }];
//    [XWGwDomainServer reg:^(id data) {
//        SWConfModel *confModel = [SWConfModel yy_modelWithJSON:data];
//        
//    } failure:^(NSString *errorMessage) {
//        
//    }];
    
}


- (void)login
{
    
}

- (void)p
{
    
}


@end
