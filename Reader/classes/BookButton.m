//
//  VisionButton.m
//  ciic
//
//  Created by Ivan on 11-11-23.
//  Copyright (c) 2011年 SmilingMobile. All rights reserved.
//

#import "BookButton.h"

@implementation BookButton

@synthesize issue = _issue,bookid=_bookid;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [_issue release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
