//
//  RootViewController.h
//  Reader
//
//  Created by user on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableview;
    NSMutableArray *marrayListData,*marrayData;
    NSString *pageIndex;
    BOOL    isHaveMore;
    UIActivityIndicatorView *_activityIndicatorView; 
    
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *marrayListData,*marrayData;
@property (nonatomic, retain) UIActivityIndicatorView *_activityIndicatorView;
@property (nonatomic,retain) NSString *pageIndex;
@property (nonatomic, assign) BOOL isHaveMore;
-(IBAction)doSelectVision:(id)sender;
@end
