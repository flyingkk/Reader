//
//  RootViewController.m
//  Reader
//
//  Created by user on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "BookButton.h"
#import "BookCell.h"
#import "BooknameCell.h"
#import "BookContentViewController.h"

#define BookNum 3 //shujia each row has BookNum Books


@implementation RootViewController

@synthesize marray,marrayName,marrayList;
@synthesize tableView =_tableView;
@synthesize orderType;


- (NSString *)bookFilePath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:bookFilename];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)dealloc
{
    _tableview.dataSource=nil;
    _tableview.delegate=nil;
    [_tableview release];
    [marray release];
    [marrayName release];
    [marrayList release];
    [orderType release];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *imgTop = [UIImage imageNamed:@"TopBar.png"];
    UIImageView *imgview;
    if (imgTop) {
        imgview  = [[UIImageView alloc] initWithImage:imgTop];
        [imgview setFrame:CGRectMake(0, 0, 320, 40)];
        [self.view addSubview:imgview ];
        [imgview release];
    }
    _tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 460-40)];
    _tableView.backgroundColor  = [UIColor clearColor];
    _tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
 
    _tableView.dataSource       = self;
    _tableView.delegate         = self;    
 
    //此处读取配置文件plist
    orderType=@"FILENAME";
    
    if (sqlite3_open([[self bookFilePath] UTF8String], &bookDatabase)!=SQLITE_OK)
    {
        sqlite3_close(bookDatabase);
        NSAssert(0, @"Failed to open database");
    }
    
    char *errorMsg;
    NSString *createSQL=@"CREATE TABLE IF NOT EXISTS FIELDS(BOOKID INTEGER PRIMARY KEY AUTOINCREMENT,FILENAME TEXT,SHOWNAME TEXT,LASTTIME TEXT,TOTALTIME TEXT,READED TEXT,TOTAL TEXT,FILETYPE TEXT,BOOKMARKNUM INTEGER);";
    if (sqlite3_exec(bookDatabase, [createSQL UTF8String], NULL, NULL,&errorMsg)!=SQLITE_OK){
        sqlite3_close(bookDatabase);
        NSAssert(0,@"Error creating table:%s",errorMsg);
    }
    [self readDataFromDatabase]; 
}


-(void) readDataFromDatabase 
{    
    self.marrayList=[[NSMutableArray alloc]initWithCapacity:1];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (sqlite3_open([[self bookFilePath] UTF8String], &bookDatabase)==SQLITE_OK){
        
        NSString *selectALL=[[NSString alloc]initWithFormat:@"SELECT BOOKID,FILENAME,SHOWNAME FROM FIELDS ORDER BY %@",self.orderType];
        
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(bookDatabase, [selectALL UTF8String], -1, &statement, nil) == SQLITE_OK)  
        {
            
            while(sqlite3_step(statement) == SQLITE_ROW) 
            {
                NSNumber *bookid = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
                NSString *filename = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *showname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                BooknameCell *booknamecell=[[BooknameCell alloc]initWithId:bookid Name:filename ShowName:showname];
                [array addObject:booknamecell];
                [booknamecell release];                
            }            
        }        
        // Release the compiled statement from memory        
        sqlite3_finalize(statement);
    }
    sqlite3_close(bookDatabase);
    self.marray=array;
    
    NSInteger visionlistCount = [marray count];
    [self.marrayList removeAllObjects];
    //change to 2d array
    NSRange range = NSMakeRange(0, BookNum);
    for (int i = 0; i <= (visionlistCount - 1) / BookNum; i++) {
        if (visionlistCount / BookNum == i ) {
            range.length = visionlistCount % BookNum;
        }
        range.location = i * BookNum;
        NSArray *arrayT = [marray subarrayWithRange:range];
        
        [self.marrayList addObject:arrayT];
        
        NSInteger booklistCount = [self.marrayList count];
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger booklistCount = [self.marrayList count];
    NSInteger rows = 3;
    if (booklistCount <= 3){
        rows = 3;
        _tableView.scrollEnabled = NO;
    } else if (booklistCount > 3){
        rows = booklistCount;
        _tableView.scrollEnabled = YES;
    }
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger row = indexPath.row;
    UIImage *defaultImage=[UIImage imageNamed:@"32.jpg"];
    UITableViewCell *cell;
    static NSString *BookListCell = @"BookList";
    
    cell = [tableView dequeueReusableCellWithIdentifier:BookListCell];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BookListCell] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
        
        //  add shujia background
        UIImage *imgShujia = [UIImage imageNamed:@"shujia.png"];
        UIImageView *imgvBackground;
        if (imgShujia) {
            imgvBackground = [[UIImageView alloc] initWithImage:imgShujia];
            imgvBackground.frame = CGRectMake(0, 0, imgShujia.size.width, imgShujia.size.height+3);
            [cell.contentView addSubview:imgvBackground];
            [imgvBackground release];
        } 
        
        int intDistance = (284 - 75 * BookNum) / (BookNum - 1);
        //add books
        for (int i = 0; i < BookNum; i++ ) {
            
            BookButton *vb;
            vb= [BookButton buttonWithType:UIButtonTypeCustom];
            
            CGFloat PointX = 18 +  i * (intDistance + 75);
            vb.frame = CGRectMake(PointX, 38, 75, 90); 
            vb.tag =  i + 1;
            [cell.contentView addSubview:vb];
            
            UILabel *lblVision;
            lblVision = [[UILabel alloc] initWithFrame:CGRectMake(PointX, 15, 75, 25)];
            lblVision.backgroundColor   = [UIColor clearColor];
            lblVision.textColor         = [UIColor colorWithRed:169.0/255.0 green:102.0/255.0 blue:24.0/255.0 alpha:1.0];  
            lblVision.textAlignment     = UITextAlignmentCenter;
            lblVision.tag               = i + BookNum + 1;
            lblVision.font              = [UIFont fontWithName:@"Helvetica" size:13.0];
            [cell.contentView addSubview:lblVision];
            [lblVision release];
        }
    }
    
    //add shujia data
    if ([marrayList count] > 0 && row < [marrayList count]) {
        //arrayRow为第row行cell的数据
        NSArray *arrayRow = [marrayList objectAtIndex:row];
        
        for (int i = 0 ; i < BookNum; i++) {
            
            BookButton *btnBook = (BookButton *)[cell.contentView viewWithTag:(i + 1)];
            UILabel  *lblBook = (UILabel  *)[cell.contentView viewWithTag:(i + BookNum + 1)];
            
            if (i < [arrayRow count]) {
                [btnBook setHidden:NO];
                [btnBook setHidden:NO];
                
                BooknameCell *dict;
                
                dict = [arrayRow objectAtIndex:i];
                
                NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentDir = [documentPaths objectAtIndex:0];
                NSString *path = [documentDir stringByAppendingPathComponent:dict.filename];
                path = [NSString stringWithFormat:@"%@.png",path];

                
                UIImage *imgVision = [[UIImage alloc] initWithContentsOfFile:path];
                if (imgVision) {
                    [btnBook setBackgroundImage:imgVision forState:UIControlStateNormal];
                }
                else {
                    [btnBook setBackgroundImage:defaultImage forState:UIControlStateNormal];
                }
                [btnBook addTarget:self action:@selector(doSelectBook:) forControlEvents:UIControlEventTouchUpInside];
                btnBook.bookid=dict.bookid;
                btnBook.issue=dict.filename;
                //change button tag, for doSelectBook 
                lblBook.text = dict.showname;
            }else{
                [btnBook setHidden:YES];
                [lblBook setHidden:YES];
            }
            
        }
    }
    
    
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 142;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)doSelectBook:(id)sender{
    BookButton *vb;
    vb = (BookButton *)sender;
    if (vb) {
        BookContentViewController *bookContentController = [[BookContentViewController alloc] init];
        bookContentController.bookid = vb.bookid;
        bookContentController.issue = vb.issue;
        [self.navigationController pushViewController:bookContentController animated:YES];
        [bookContentController release];
    }
}

@end
