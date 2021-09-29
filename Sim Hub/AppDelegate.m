//
//  AppDelegate.m
//  SImHub
//
//  Created by Robert Kortenoeven on 19.04.20.
//  Copyright © 2020 Robert Kortenoeven. All rights reserved.
//

#import "AppDelegate.h"

#import <AppCenter/AppCenter.h>
#import <AppCenterAnalytics/AppCenterAnalytics.h>
#import <AppCenterCrashes/AppCenterCrashes.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self loadSettings];
    [self setupMSAppCenter];

    return YES;
}


- (void)loadSettings {
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString * server_preference = [standardUserDefaults objectForKey:@"home_url"];

    if (!server_preference) {
        [self registerDefaultsFromSettingsBundle];
    }
}

- (void) setupMSAppCenter {
    [MSACAppCenter start:@"b0d6e87a-da32-40ac-a87f-b2751c9a5795" withServices:@[
      [MSACAnalytics class],
      [MSACCrashes class]
    ]];
}


#pragma NSUserDefaults
- (void)registerDefaultsFromSettingsBundle {
    // this function writes default settings as settings
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }

    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];

    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
            NSLog(@"writing as default %@ to the key %@",[prefSpecification objectForKey:@"DefaultValue"],key);
        }
    }
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults registerDefaults:defaultsToRegister];
}

@end
