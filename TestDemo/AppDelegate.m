//
//  AppDelegate.m
//  TestDemo
//
//  Created by DTiOS on 2021/1/25.
//

#import "AppDelegate.h"
#import "AutoPlayGifViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[AutoPlayGifViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
