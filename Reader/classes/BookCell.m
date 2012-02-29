//
//  BookCell.m
//  Reader
//
//  Created by user on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell
@synthesize bookid,filename,showname,lasttime,totaltime,filetype,readed,total,bookmarknum;

-(id)initWithId:(NSNumber*)bookid Name:(NSString*)filename ShowName:(NSString*)showname Lasttime:(NSString*)lasttime Totaltime:(NSString*)totaltime Readed:(NSString*)readed Ttoal:(NSString*)total Filetype:(NSString*)filetype BookmarkNum:(NSNumber*)bookmarknum{
    self.bookid = bookid;
    self.filename = filename;
    self.showname = showname;
    self.lasttime = lasttime;
    self.totaltime = totaltime;
    self.readed = readed;
    self.total = total;
    self.filetype = filetype;
    self.bookmarknum = bookmarknum;
    return self;
}

@end
