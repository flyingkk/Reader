//
//  RootViewController.h
//  Reader
//
//  Created by user on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"

#define bookFilename @"books"
#define bookmarkFilename @"bookMarks"

@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    sqlite3 *bookDatabase;
    UITableView *_tableview;
    NSMutableArray *marray;
    NSMutableArray *marrayList,*marrayName;
    NSString *orderType;//排序方式
    
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *marray,*marrayList,*marrayName;
@property (nonatomic, retain) NSString *orderType;

- (NSString *)bookFilePath;
-(IBAction)doSelectBook:(id)sender;
-(void) readDataFromDatabase;

@end
