//
//  VisionButton.h
//  ciic
//
//  Created by Ivan on 11-11-23.
//  Copyright (c) 2011年 SmilingMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookButton : UIButton {
    NSNumber *_bookid;
    NSString *_issue;
}

@property (nonatomic, retain) NSString *issue;
@property NSNumber *bookid;

@end
