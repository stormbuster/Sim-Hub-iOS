//
//  ViewController.m
//  SImHub
//
//  Created by Robert Kortenoeven on 19.04.20.
//  Copyright © 2020 Robert Kortenoeven. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "SHWebView.h"

#import "Masonry.h"


@interface ViewController () <WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) SHWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
    [self registerNotifications];
}
 
- (void)setupWebView {
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);document.body.style.zoom = 1.0;";

    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];

    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    self.webView = [[SHWebView alloc] initWithFrame:self.view.frame configuration:wkWebConfig];
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *url = [defaults objectForKey:@"home_url"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appBecameActive)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)appBecameActive {
    [self.webView setNeedsLayout];
    [self.webView reload];
}


#pragma mark WebViewDelegate

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"finished nav...");
    [[NSUserDefaults standardUserDefaults] setValue:self.webView.URL.absoluteString forKey:@"lastPageViewed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"finished nav for webView: %@", webView);
}


@end
