//
//  AppDelegate.m
//  XWSDKDemo
//
//  Created by Seven on 2023/4/25.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <VideoToolbox/VideoToolbox.h>
#import <AVKit/AVKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSArray *supportedArray = AVAssetExportSession.allExportPresets;
    BOOL hardwareEncoderSupported = [supportedArray containsObject:AVAssetExportPresetHEVCHighestQuality];
    BOOL hardwareDecoderSupported = VTIsHardwareDecodeSupported(kCMVideoCodecType_HEVC);
    NSLog(@"AppDelegate p_initThirdSDKWithApplication 设备H265 %@编码 %@解码 ", hardwareEncoderSupported ? @"能" : @"不能", hardwareDecoderSupported ? @"能" : @"不能");
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *viewController = [ViewController new];
    [self.window setRootViewController:viewController];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor greenColor]];
    
    
    return YES;
}






@end
