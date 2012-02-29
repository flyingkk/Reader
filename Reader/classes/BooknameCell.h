//
//  BooknameCell.h
//  Reader
//
//  Created by user on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BooknameCell : NSObject{
    NSNumber *bookid;    
    NSString *filename,*showname;
}
@property (retain,nonatomic) NSNumber *bookid;
@property (retain,nonatomic) NSString *filename,*showname;

-(id)initWithId:(NSNumber*)bookid Name:(NSString*)filename ShowName:(NSString*)showname;
@end
