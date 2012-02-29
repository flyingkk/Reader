//
//  BooknameCell.m
//  Reader
//
//  Created by user on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BooknameCell.h"

@implementation BooknameCell
@synthesize bookid,filename,showname;

-(id)initWithId:(NSNumber*)bookid Name:(NSString*)filename ShowName:(NSString*)showname{
    self.bookid = bookid;
    self.filename = filename;
    self.showname = showname;
    return self;
}


@end
