//
//  BookContentViewController.m
//  Reader
//
//  Created by user on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BookContentViewController.h"
#import "DWLabel.h"

@implementation BookContentViewController
@synthesize issue,bookid;
@synthesize _contentLabel;

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

- (void)dealloc {
    [issue release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    NSRange textRange;
    textRange.location=1250;
    textRange.length=7;
    CGPoint content;
    content.x=0;
    content.y=488;
    NSValue *value2 = [[NSValue valueWithCGPoint:content]retain];
    //_contentLabel.selectedRange=textRange;
    NSValue *value = [[NSValue valueWithRange:textRange] retain]; 
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(doScroll:) userInfo:value repeats:NO];
    [super viewWillAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    UIImage *imgTop = [UIImage imageNamed:@"TopBar.png"];
    UIImageView *imgview;
    if (imgTop) {
        imgview  = [[UIImageView alloc] initWithImage:imgTop];
        [imgview setFrame:CGRectMake(0, 0, 320, 40)];
        [self.view addSubview:imgview ];
        [imgview release];
    }
    UIImage *imgreturn = [UIImage imageNamed:@"btnBack.png"];
    UIButton *btnReturn;
    if (imgreturn) {
        btnReturn = [[UIButton alloc] init];
        btnReturn.frame = CGRectMake(8, 4, imgreturn.size.width, imgreturn.size.height);
        [btnReturn setBackgroundImage:imgreturn forState:UIControlStateNormal];
        [btnReturn addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnReturn];
        [btnReturn release];
    }
    
    UIButton *btnNext;
    btnNext=[[UIButton alloc]initWithFrame:CGRectMake(280, 4, 40, 40)];
    btnNext.backgroundColor=[UIColor redColor];
    [btnNext addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNext];
    [btnNext release];

    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSError *error = nil;
    NSString *path = [documentDir stringByAppendingPathComponent:@"41"];
    path = [NSString stringWithFormat:@"%@.txt",path];
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];

    
    UIScrollView *_scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, 320, 460-40)];
    _scrollView.delegate=self;
    [_scrollView setPagingEnabled:NO];//不按页翻
    [_scrollView setShowsVerticalScrollIndicator:YES];//显示垂直滚动条
    [_scrollView setShowsHorizontalScrollIndicator:NO];//不显示水平滚动条
    _scrollView.backgroundColor=[UIColor yellowColor];
    
    //UITextView *_contentLabel=[[UITextView alloc]init];
    _contentLabel=[[UITextView alloc]init];
    UIFont *font = _contentLabel.font;
    CGSize size = [text sizeWithFont:font];
    _contentLabel.frame=CGRectMake(0, 40, 320, 460-40);
    CGSize newSize = _contentLabel.frame.size;
    [_scrollView setContentSize:newSize];
    //_contentLabel.numberOfLines=0;   
    _contentLabel.editable=NO;
    _contentLabel.textAlignment=UITextAlignmentLeft;
    _contentLabel.backgroundColor=[UIColor clearColor];
    _contentLabel.text=text;
    _contentLabel.dataDetectorTypes=UIDataDetectorTypeLink;
    _contentLabel.font=[UIFont systemFontOfSize:50];
    
    [self.view addSubview:_contentLabel];
    //[_scrollView addSubview:_contentLabel];    
    //[self.view addSubview:_scrollView];
    [_scrollView release]; 
    
    
    
    UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"test" action:@selector(changeColor:)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObject:menuItem]];
    [menuItem release];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    //[self.view addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    [singleTap release];

    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];
    NSString *test=[[NSString alloc]initWithFormat:@"handleSingleTap!pointx:%f,y:%f",point.x,point.y];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:test delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

-(void)nextPage
{
    CGPoint content =_contentLabel.contentOffset;
    content.y = content.y-400;
    [_contentLabel scrollRectToVisible:CGRectMake(content.x, content.y, 320, 460-40) animated:YES];
    
}
-(void)doReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) changeColor: (id) sender{
    CGPoint content =_contentLabel.contentOffset;
    

    NSRange textRange=[_contentLabel selectedRange];
    
    NSInteger location= content.x;
    NSInteger length =content.y;
    NSString *test=[_contentLabel.text substringWithRange:textRange];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:test delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];

}
- (void)doScroll:(NSTimer*)theTimer {
    NSValue *value = [theTimer userInfo];
    CGPoint range = [value CGPointValue];
    NSRange range2 = [value rangeValue];
    [_contentLabel scrollRangeToVisible:range2];
    range.y = _contentLabel.contentSize.height*0.8;
    //[_contentLabel setContentOffset:CGPointMake(range.x, range.y) animated:YES];
    //[_contentLabel scrollRectToVisible:CGRectMake(range.x, range.y,320,460-40) animated:YES];
    [value release];
    [theTimer invalidate];
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(action == @selector(changeColor:))
    {
        return YES;
    }
    else if (action == @selector(copy:))
    {
        return NO;
    }
    else if (action == @selector(select:)){
        return NO;
    }
    return NO;
}


@end
