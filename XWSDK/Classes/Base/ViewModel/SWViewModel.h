////
////  SWViewModel.h
////  SoundWave
////
////  Created by 123 on 2021/8/4.
////
//
//#import "SWModel.h"
//#import "SWBaseVC.h"
//#import "NSString+SWExtension.h"
//#import "NSDictionary+SWJson.h"
//#import "SWAuthServer.h"
//
//NS_ASSUME_NONNULL_BEGIN
//
//typedef NS_ENUM(NSInteger, SWSmsScene) {
//    /// 登录
//    SmsLoginScene = 0,
//    ///注销
//    SmsLogoffScene = 1,
//};
//
//typedef NS_ENUM(NSInteger, SWTableStatus) {
//    Normal        = 1,
//    NoData        = 2,
//    NoMore        = 3,
//    NoNet         = 4,
//    NoNetHasData  = 5
//};
//
//typedef void (^SuccessBlock)(void);
//typedef void (^CodeErrorBlock)(NSInteger code,NSString *message);
//typedef void (^ErrorBlock)(NSString *message);
//typedef void (^UploadSuccessBlock)(SWUploadResponse   *response);
//typedef void (^ScrollViewDidScrollBlock)(UIScrollView *scrollView);
//typedef void (^ListSuccessBlock )(SWTableStatus status);
//typedef void (^ListErrorBlock   )(SWTableStatus status, NSString *message);
//typedef void (^DidSelectRowBlock)(id model);
//typedef void (^LoadSuccessBlock )(id model);
//
//@interface SWViewModel : SWModel
//
//@property (nonatomic,weak) SWBaseVC *_Nullable currentVC;/// controller
//
//@property (nonatomic, readwrite, copy) void (^callback)(id _Nullable);
//
//
//
//- (id)testJsonFileData:(NSString *)file;
//
//+ (instancetype)viewModelForController:(UIViewController *_Nullable)vc;
////子类需重写且需要super调用
//- (instancetype)initWithController:(UIViewController *_Nullable)vc;
//- (void)sendSms:(NSString *)mobile smsScene:(SWSmsScene)smsScene successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
////- (void)uploadImage:(SWFileCategoryType)type file:(NSArray<SWUploadDataModel *> *)file progress:(Progress)progress successBlock:(UploadSuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
//- (void)members:(NSInteger)memberId successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
//- (void)memberFollow:(NSInteger)memberId successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
//- (void)memberUnfollow:(NSInteger)memberId successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;
//@end
//
//NS_ASSUME_NONNULL_END
