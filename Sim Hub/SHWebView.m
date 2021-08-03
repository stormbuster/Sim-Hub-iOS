//
//  SHWebView.m
//  SHWebView
//
//  Created by Robert Kortenoeven on 03.08.21.
//  Copyright © 2021 Robert Kortenoeven. All rights reserved.
//

#import "SHWebView.h"


static const float defaultMargin = 34;

@implementation SHWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIEdgeInsets)safeAreaInsets {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bool shouldFill = [defaults boolForKey:@"should_fill_screen"];
    return shouldFill ? UIEdgeInsetsMake(0,0,0,0) : UIEdgeInsetsMake(0,defaultMargin,0,defaultMargin);
}

@end
