//
//  HomeViewController.m
//  NewTD
//
//  Created by 工业设计中意（湖南） on 14-5-13.
//  Copyright (c) 2014年 中意工业设计（湖南）有限责任公司. All rights reserved.
//

#import "HomeViewController.h"
#import "../classes/DBUtils.h"
#import "PopupDetailViewController.h"
#import "../classes/FileUtils.h"
#import "../libs/MJPopup/UIViewController+MJPopupViewController.h"
#import "../classes/UILabel+VerticalAlign.h"
#import "../classes/TimeUtil.h"

@interface HomeViewController ()<MJPopupDelegate>

@end

@implementation HomeViewController

@synthesize columnBigBg,firstViewPanel,firstArticleTitle,firstArticleTime;
@synthesize secondViewPanel,secondArticleTimeLabel,secondArticleThumb,secondArticleTitleLabel,secondArticleSummaryLabel;
@synthesize threeViewPanel,threeArticleTimeLabel,threeArticleThumb,threeArticleTitleLabel,threeArticleSummaryLabel;
@synthesize fourViewPanel,fourArticleTimeLabel,fourArticleThumb,fourArticleTitleLabel,fourArticleSummaryLabel;

extern DBUtils *db;
FileUtils *fileUtils;
PopupDetailViewController* detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    fileUtils = [FileUtils new];
    [fileUtils createAppFilesDir];
    
    firstViewPanel.backgroundColor = [UIColor clearColor];
    
    [firstViewPanel addTarget:self action:@selector(panelClick:) forControlEvents:UIControlEventTouchUpInside];
    [secondViewPanel addTarget:self action:@selector(panelClick:) forControlEvents:UIControlEventTouchUpInside];
    [threeViewPanel addTarget:self action:@selector(panelClick:) forControlEvents:UIControlEventTouchUpInside];
    [fourViewPanel addTarget:self action:@selector(panelClick:) forControlEvents:UIControlEventTouchUpInside];
    
    thumbDownQueue = [NSOperationQueue new];
    [thumbDownQueue setMaxConcurrentOperationCount:1];
    
    NSMutableArray *muArray = [db queryHeadline];
        
    NSOperation *downOperation = nil;
    
    if ([muArray count] >= 1)
    {
        NSMutableDictionary *muDict = [muArray objectAtIndex:0];
        [firstArticleTitle setText:[muDict objectForKey:@"title"]];
        firstArticleTime.textAlignment = NSTextAlignmentCenter;
        [firstArticleTime setText:[TimeUtil convertTimeFormat:[muDict objectForKey:@"timestamp"]]];
        firstViewPanel.accessibilityLabel = [muDict objectForKey:@"serverID"];
    }
    
    if ([muArray count] >= 2)
    {
        NSMutableDictionary *muDict = [muArray objectAtIndex:1];
        downOperation = [self loadingImageOperation:muDict andImageView:secondArticleThumb];
        if (downOperation != nil)
        {
            [thumbDownQueue addOperation:downOperation];
        }
        [secondArticleTitleLabel setText:[muDict objectForKey:@"title"]];
        [secondArticleTitleLabel alignTop];
        secondArticleTimeLabel.textAlignment = NSTextAlignmentCenter;
        [secondArticleTimeLabel setText:[TimeUtil convertTimeFormat:[muDict objectForKey:@"timestamp"]]];
        
        [secondArticleSummaryLabel setText:[muDict objectForKey:@"description"]];
        [secondArticleSummaryLabel alignTop];
        
        secondViewPanel.accessibilityLabel = [muDict objectForKey:@"serverID"];
        
        if ([[muDict objectForKey:@"hasVideo"] intValue] == 1)
        {
            [self addVideoImage:secondViewPanel];
        }
    }
    else
    {
        secondViewPanel.hidden = YES;
    }
    
    if ([muArray count] >= 3)
    {
        NSMutableDictionary *muDict = [muArray objectAtIndex:2];
        downOperation = [self loadingImageOperation:muDict andImageView:threeArticleThumb];
        if (downOperation != nil)
        {
            [thumbDownQueue addOperation:downOperation];
        }
        
        [threeArticleTitleLabel setText:[muDict objectForKey:@"title"]];
        [threeArticleTitleLabel alignTop];
        threeArticleTimeLabel.textAlignment = NSTextAlignmentCenter;
        [threeArticleTimeLabel setText:[TimeUtil convertTimeFormat:[muDict objectForKey:@"timestamp"]]];
        [threeArticleSummaryLabel setText:[muDict objectForKey:@"description"]];
        [threeArticleSummaryLabel alignTop];
        
        threeViewPanel.accessibilityLabel = [muDict objectForKey:@"serverID"];
        if ([[muDict objectForKey:@"hasVideo"] intValue] == 1)
        {
            [self addVideoImage:threeViewPanel];
        }
    }
    else
    {
        threeViewPanel.hidden = YES;
    }
    
    if ([muArray count] >= 4)
    {
        NSMutableDictionary *muDict = [muArray objectAtIndex:3];
        downOperation = [self loadingImageOperation:muDict andImageView:fourArticleThumb];
        if (downOperation != nil)
        {
            [thumbDownQueue addOperation:downOperation];
        }
        [fourArticleTitleLabel setText:[muDict objectForKey:@"title"]];
        [fourArticleTitleLabel alignTop];
        fourArticleTimeLabel.textAlignment = NSTextAlignmentCenter;
        [fourArticleTimeLabel setText:[TimeUtil convertTimeFormat:[muDict objectForKey:@"timestamp"]]];
        [fourArticleSummaryLabel setText:[muDict objectForKey:@"description"]];
        [fourArticleSummaryLabel alignTop];
        fourViewPanel.accessibilityLabel = [muDict objectForKey:@"serverID"];
        if ([[muDict objectForKey:@"hasVideo"] intValue] == 1)
        {
            [self addVideoImage:fourViewPanel];
        }
    }
    else
    {
        fourViewPanel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
