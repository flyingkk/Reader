//
//  BookContentViewController.h
//  Reader
//
//  Created by user on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookContentViewController : UIViewController<UITextViewDelegate,UIGestureRecognizerDelegate>
{
    NSNumber *bookid;
    NSString *issue;
    UITextView *_contentLabel;
}
@property (nonatomic, retain) UITextView *_contentLabel;
@property (nonatomic, retain) NSString *issue;
@property NSNumber *bookid;
@end
