//
//  ViewController.m
//  SImHub
//
//  Created by Robert Kortenoeven on 19.04.20.
//  Copyright © 2020 Robert Kortenoeven. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWebView) name:UIApplicationWillEnterForegroundNotification object:nil];
    [self loadWebContent];
}

- (void)loadWebContent {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *url = [defaults objectForKey:@"home_url"];
    
    NSURL *theURL = [[NSURL alloc] initWithString:url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:theURL]];
}

- (void) refreshWebView {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    bool *homeButtonRight = [defaults boolForKey:@"home_button_right"];
//    NSNumber *value = [NSNumber numberWithInt:homeButtonRight ? UIInterfaceOrientationLandscapeLeft : UIInterfaceOrientationLandscapeRight];
//    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    [self loadWebContent];
}


@end
