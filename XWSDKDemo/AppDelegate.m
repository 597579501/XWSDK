//
//  AppDelegate.m
//  XWSDKDemo
//
//  Created by Seven on 2023/4/25.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *viewController = [ViewController new];
    [self.window setRootViewController:viewController];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor greenColor]];
    return YES;
}






@end
