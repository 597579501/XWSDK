////
////  SWViewModel.m
////  SoundWave
////
////  Created by 123 on 2021/8/4.
////
//
//#import "SWViewModel.h"
//#import "SWAuthServer.h"
//
//
//@implementation SWViewModel
//+ (instancetype)viewModelForController:(UIViewController *_Nullable)vc {
//    return [[self alloc] initWithController:vc];
//}
//
//- (instancetype)initWithController:(UIViewController *_Nullable)vc {
//    if (self = [super init]) {
//        self.currentVC = (SWBaseVC *)vc;
//    }
//    return self;
//}
//
//
//- (id)testJsonFileData:(NSString *)file
//{
//    // TODO : 测试数据 后期删除
//    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:file ofType:@"geojson"];
//    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
//    id responseObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
//    return responseObject;
//}
//
//- (void)members:(NSInteger)memberId successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
//{
//    NSDictionary *param = @{
//        @"member_id" : [NSNumber numberWithInteger:memberId],
//    };
//    [SWAuthServer getMember:param success:^(id data) {
//        if (memberId == SWUserManager.sharedInstance.userInfo.member.memberId)
//        {
//            SWMember *member = [SWMember yy_modelWithJSON:data];
//            SWUser *user = [[SWUserManager sharedInstance] userInfo];
//            user.member = member;
//            [[SWUserManager sharedInstance] synchronizeLocalUser:user];
//        }
//        successBlock();
//    } failure:^(NSString *errorMessage) {
//        errorBlock(errorMessage);
//    }];
//}
//
//- (void)sendSms:(NSString *)mobile smsScene:(SWSmsScene)smsScene successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
//{
//    NSDictionary *param = @{
//        @"mobile" : mobile,
//        @"scene" : smsScene == SmsLoginScene ? @"LOGIN" : @"LOGOFF"
//    };
//    [SWAuthServer sendSms:param success:^(id data) {
//        SWUser *user = [SWUser yy_modelWithJSON:data];
//        [[SWUserManager sharedInstance] setUserInfo:user];
//        
//        successBlock();
//    } failure:^(NSString *errorMessage) {
//        errorBlock(errorMessage);
//    }];
//}
//
//
//- (void)memberFollow:(NSInteger)memberId successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock
//{
//    NSDictionary *dictionary = @{
//        @"follow_member_id" : [NSNumber numberWithInteger:memberId]
//    };
//    [SWAuthServer memberFollow:dictionary success:^(id data) {
//      [SIGNAL_SHARE.followChangedSubj sendNext:@(YES)];
//        successBlock();
//    } failure:^(NSString *errorMessage) {
//        errorBlock(errorMessage);
//    }];
//}
//
//- (void)memberUnfollow:(NSInteger)memberId successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock
//{
//    NSDictionary *dictionary = @{
//        @"follow_member_id" : [NSNumber numberWithInteger:memberId]
//    };
//    [SWAuthServer memberUnfollow:dictionary success:^(id data) {
//      [SIGNAL_SHARE.followChangedSubj sendNext:@(YES)];
//        successBlock();
//    } failure:^(NSString *errorMessage) {
//        errorBlock(errorMessage);
//    }];
//}
//
////- (void)uploadImage:(SWFileCategoryType)type file:(NSArray<SWUploadDataModel *> *)file progress:(Progress)progress successBlock:(UploadSuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock
////{
////    [SWAuthServer uploadImageWithCategory:type files:file progress:progress success:^(id data) {
////        SWUploadResponse *uploadResponse = [SWUploadResponse yy_modelWithJSON:data];
////        successBlock(uploadResponse);
////    } failure:^(NSString *errorMessage) {
////        errorBlock(errorMessage);
////    }];
////
////}
//
//
//
////+ (NSURLSessionDataTask *)uploadImageWithParameters:(id)params
////                                              files:(NSArray<SWUploadDataModel *> *)files
////                                           progress:(void (^)(NSProgress *progress))progress
////                                            success:(Success)success
////                                            failure:(Failure)failure
//
//
//
//
//@end
