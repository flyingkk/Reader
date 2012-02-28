//
//  RootViewController.m
//  Reader
//
//  Created by user on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "VisionButton.h"

#define MagazineNum 3 //shujia each row has MagazineNum magazines


@implementation RootViewController

@synthesize marrayData,marrayListData;
@synthesize tableView =_tableView;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)dealloc
{
    //[dictData release];
    //[pageIndex release];
    [marrayData release];
    [marrayListData release];
    [_activityIndicatorView release];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *imgTop = [UIImage imageNamed:@"mediatop.png"];
    UIImageView *imgview;
    if (imgTop) {
        imgview  = [[UIImageView alloc] initWithImage:imgTop];
        [imgview setFrame:CGRectMake(0, 0, 320, 40)];
        [self.view addSubview:imgview ];
        [imgview release];
    }
    _tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 320, 460-35)];
    _tableView.backgroundColor  = [UIColor clearColor];
    _tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
 
    _tableView.dataSource       = self;
    _tableView.delegate         = self;    
 
    //self.pageIndex = @"1";
 
    NSMutableArray *marray1 = [[NSMutableArray alloc] initWithCapacity:1];
    self.marrayListData = marray1;
    [marray1 release];
 
    NSMutableArray *marray2 = [[NSMutableArray alloc] initWithCapacity:1];
    self.marrayData = marray2;
    [marray2 release];
 /*
    UIActivityIndicatorView *anIndicator;
    anIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    anIndicator.frame = CGRectMake(145,200, anIndicator.frame.size.width,anIndicator.frame.size.height);
    anIndicator.hidesWhenStopped = YES;
    self._activityIndicatorView = anIndicator;
    [anIndicator release];
    [self.view addSubview:_activityIndicatorView];*/
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
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger row = indexPath.row;
    
    UITableViewCell *cell;
    static NSString *VisionListCell = @"VisonList";
    
    cell = [tableView dequeueReusableCellWithIdentifier:VisionListCell];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VisionListCell] autorelease];
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
        
        int intDistance = (284 - 75 * MagazineNum) / (MagazineNum - 1);
        //add qikan
        for (int i = 0; i < MagazineNum; i++ ) {
            
            VisionButton *vb;
            vb= [VisionButton buttonWithType:UIButtonTypeCustom];
            
            CGFloat PointX = 18 +  i * (intDistance + 75);
            vb.frame = CGRectMake(PointX, 38, 75, 90); 
            vb.tag =  i + 1;
            [cell.contentView addSubview:vb];
            
            UILabel *lblVision;
            lblVision = [[UILabel alloc] initWithFrame:CGRectMake(PointX, 15, 75, 25)];
            lblVision.backgroundColor   = [UIColor clearColor];
            lblVision.textColor         = [UIColor colorWithRed:169.0/255.0 green:102.0/255.0 blue:24.0/255.0 alpha:1.0];  
            lblVision.textAlignment     = UITextAlignmentCenter;
            lblVision.tag               = i + MagazineNum + 1;
            lblVision.font              = [UIFont fontWithName:@"Helvetica" size:13.0];
            [cell.contentView addSubview:lblVision];
            [lblVision release];
        }
    }
    
    if (row < 4) {
        NSArray *arrayImg = [NSArray arrayWithObjects:@"201111241306458391.jpg",@"201111231610235016.jpg",@"39.jpg",@"38.jpg",@"37.jpg",@"36.jpg",@"35.jpg",@"34.jpg",@"33.jpg",@"32.jpg",@"31.jpg",@"30.jpg", nil];
        NSArray *arrayIssue = [NSArray arrayWithObjects:@"41",@"40",@"39",@"38",@"37",@"36",@"35",@"34",@"33",@"32",@"31",@"30", nil];
        
        for (int i = 0 ; i < MagazineNum; i++) {
            
            VisionButton *btnMagazine = (VisionButton *)[cell.contentView viewWithTag:(i + 1)];
            UILabel  *lblMagazine = (UILabel  *)[cell.contentView viewWithTag:(i + MagazineNum + 1)];
            
            [btnMagazine setHidden:NO];
            
            NSString *strImgPath = [arrayImg objectAtIndex:row * 3 + i];
            UIImage *imgVision = [UIImage imageNamed:strImgPath];
            if (imgVision) {
                [btnMagazine setBackgroundImage:imgVision forState:UIControlStateNormal];
            }
            [btnMagazine addTarget:self action:@selector(doSelectVision:) forControlEvents:UIControlEventTouchUpInside];
            btnMagazine.issue = [arrayIssue objectAtIndex:row * 3 + i];//change button tag, for doSelectVision 
            
            NSMutableString *vision = [[NSMutableString alloc] initWithString:@""];
            [vision appendString:@"第"];
            [vision appendString:[arrayIssue objectAtIndex:row * 3 + i]];
            [vision appendString:@"期"];
            lblMagazine.text = vision;
            [vision release];
        }
    } else if (row == 4){
        NSArray *arrayImg = [NSArray arrayWithObjects:@"29.jpg",@"28.jpg",nil];
        NSArray *arrayIssue = [NSArray arrayWithObjects:@"29",@"28",nil];
        
        for (int i = 0 ; i < 3; i++) {
            
            VisionButton *btnMagazine = (VisionButton *)[cell.contentView viewWithTag:(i + 1)];
            UILabel  *lblMagazine = (UILabel  *)[cell.contentView viewWithTag:(i + MagazineNum + 1)];
            
            if (i < 2) {
                NSString *strImgPath = [arrayImg objectAtIndex:i];
                UIImage *imgVision = [UIImage imageNamed:strImgPath];
                if (imgVision) {
                    [btnMagazine setBackgroundImage:imgVision forState:UIControlStateNormal];
                }
                [btnMagazine addTarget:self action:@selector(doSelectVision:) forControlEvents:UIControlEventTouchUpInside];
                btnMagazine.issue = [arrayIssue objectAtIndex:i];//change button tag, for doSelectVision 
                
                NSMutableString *vision = [[NSMutableString alloc] initWithString:@""];
                [vision appendString:@"第"];
                [vision appendString:[arrayIssue objectAtIndex:i]];
                [vision appendString:@"期"];
                lblMagazine.text = vision;
                [vision release];
            }else{
                [btnMagazine setHidden:YES];
                lblMagazine.text = @"";
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

-(IBAction)doSelectVision:(id)sender{
}

@end
