//
//  BookCell.h
//  Reader
//
//  Created by user on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookCell : NSObject{
    NSNumber *bookid;    
    NSString *filename,*showname;
    NSString *lasttime,*totaltime;
    NSString *readed;
    NSString *total;
    NSString *filetype;
    NSNumber *bookmarknum;    
}
@property (retain,nonatomic) NSNumber *bookid,*bookmarknum;
@property (retain,nonatomic) NSString *filename,*showname,*lasttime,*totaltime,*readed,*total,*filetype;


-(id)initWithId:(NSNumber*)bookid Name:(NSString*)filename ShowName:(NSString*)showname Lasttime:(NSString*)lasttime Totaltime:(NSString*)totaltime Readed:(NSString*)readed Ttoal:(NSString*)total Filetype:(NSString*)filetype BookmarkNum:(NSNumber*)bookmarknum;

@end
