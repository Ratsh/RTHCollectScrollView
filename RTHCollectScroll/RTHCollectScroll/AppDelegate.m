//
//  AppDelegate.m
//  RTHCollectScroll
//
//  Created by Ratsh on 12.11.14.
//  Copyright (c) 2014 rth. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window                         = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor         = [UIColor whiteColor];
    self.window.rootViewController      = [MainViewController new];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
