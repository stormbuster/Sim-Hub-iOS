//
//  SHWebView.m
//  SHWebView
//
//  Created by Robert Kortenoeven on 03.08.21.
//  Copyright © 2021 Robert Kortenoeven. All rights reserved.
//

#import "SHWebView.h"

@implementation SHWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIEdgeInsets)safeAreaInsets {
    return UIEdgeInsetsMake(0,0,0,0);
}

@end
