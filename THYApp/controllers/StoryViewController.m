//
//  StoryViewController.m
//  NewTD
//
//  Created by 工业设计中意（湖南） on 14-5-13.
//  Copyright (c) 2014年 中意工业设计（湖南）有限责任公司. All rights reserved.
//

#import "StoryViewController.h"
#import "../classes/DBUtils.h"
#import "../classes/TimeUtil.h"
#import "Constants.h"
#import "VarUtils.h"
#import "../classes/UILabel+VerticalAlign.h"

@interface StoryViewController ()

@end

@implementation StoryViewController

@synthesize storyTitleLabel;

extern DBUtils *db;

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
    
    [storyTitleLabel setText:NSLocalizedString(@"storyTitle", nil)];
    
    int countArticle = [db countByCategory:STORY_CATEGORY];
    countPage = (countArticle / STORY_PAGE_INSIDE_NUM);
    if ((countArticle % STORY_PAGE_INSIDE_NUM) > 0)
    {
        countPage = countPage + 1;
    }
    
    columnScrollView = (UIScrollView *)[self.view viewWithTag:150];
    pageControl = (UIPageControl *)[self.view viewWithTag:151];
    
    columnScrollView.contentSize = CGSizeMake(columnScrollView.frame.size.width * countPage, columnScrollView.frame.size.height);
    columnScrollView.delegate = self;
    columnScrollView.backgroundColor = [UIColor clearColor];
    
    pageControl.currentPage = 0;
    pageControl.numberOfPages = countPage;
    
    pageControlBeingUsed = NO;
    
    
    muDistionary = [NSMutableDictionary dictionaryWithCapacity:4];
    currentPage = 0;
    
    thumbDownQueue = [NSOperationQueue new];
    [thumbDownQueue setMaxConcurrentOperationCount:2];
    
    for (int i = 0; i < 2; i++)
    {
        if (i <= countPage)
        {
            [self assemblePanel:i];
        }
    }

}

-(void) assemblePanel:(int) pageNum
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSMutableArray * muArray = [db getStoryDataByPage:pageNum];
    
    CGRect frame;
    
    UIView *subview = [[bundle loadNibNamed:@"StoryContentPanel" owner:self options:nil] lastObject];
    frame.origin.x = columnScrollView.frame.size.width * (pageNum);
    frame.origin.y = 0;
    frame.size.width = columnScrollView.frame.size.width;
    frame.size.height = subview.frame.size.height;
    
    NSOperation *downOperation = nil;
    
    if (subview != nil && muArray != nil)
    {
        subview.frame = frame;
        
        //根据数据加载subview
        UIImageView *firstImg = (UIImageView*)[subview viewWithTag:302];
        UILabel* firstLabelTitle = (UILabel*)[subview viewWithTag:303];
        UILabel* firstLabelSummary = (UILabel*)[subview viewWithTag:304];
        
        if (muArray.count >= 1 && [muArray objectAtIndex:0])
        {
            NSMutableDictionary *muDict = [muArray objectAtIndex:0];
            
            //异步加载图片
            downOperation = [self loadingImageOperation:muDict andImageView:firstImg];
            if (downOperation != nil)
            {
                [thumbDownQueue addOperation:downOperation];
            }
            
            [firstLabelTitle setText:[muDict objectForKey:@"title"]];
            
            firstImg.accessibilityLabel = [muDict objectForKey:@"serverID"];
            firstImg.userInteractionEnabled = YES;
            UITapGestureRecognizer *sigTab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panelClick:)];
            [firstImg addGestureRecognizer:sigTab];
            
            [firstLabelSummary setText:[muDict objectForKey:@"description"]];
            [firstLabelSummary alignTop];
            
            firstLabelSummary.lineBreakMode = NSLineBreakByTruncatingTail;
            
            
            if ([[muDict objectForKey:@"hasVideo"] intValue] == 1)
            {
                [self addVideoImage:firstImg];
            }
        }
        else
        {
            firstImg.hidden = YES;
            firstLabelTitle.hidden = YES;
            firstLabelSummary.hidden = YES;
        }
        
        UIImageView *secondImg = (UIImageView*)[subview viewWithTag:306];
        UILabel* secondLabelTitle = (UILabel*)[subview viewWithTag:307];
        UIView *secondView = (UIView *)[subview viewWithTag:322];
        
        if (muArray.count >= 2 && [muArray objectAtIndex:1])
        {
            NSMutableDictionary *muDict = [muArray objectAtIndex:1];
            
            //异步加载图片
            downOperation = [self loadingImageOperation:muDict andImageView:secondImg];
            if (downOperation != nil)
            {
                [thumbDownQueue addOperation:downOperation];
            }
            
            [secondLabelTitle setText:[muDict objectForKey:@"title"]];
            secondLabelTitle.backgroundColor = [UIColor clearColor];
            
            secondImg.accessibilityLabel = [muDict objectForKey:@"serverID"];
            secondImg.userInteractionEnabled = YES;
            UITapGestureRecognizer *sigTab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panelClick:)];
            [secondImg addGestureRecognizer:sigTab];
            
            if ([[muDict objectForKey:@"hasVideo"] intValue] == 1)
            {
                [self addVideoImage:secondImg];
            }
        }
        else
        {
            secondImg.hidden = YES;
            secondLabelTitle.hidden = YES;
            secondView.hidden = YES;
        }
        
        UIImageView *thirdImg = (UIImageView*)[subview viewWithTag:312];
        UILabel* thirdLabelTitle = (UILabel*)[subview viewWithTag:313];
        UIView *thirdView = (UIView *)[subview viewWithTag:324];
        
        if (muArray.count >= 3 && [muArray objectAtIndex:2])
        {
            NSMutableDictionary *muDict = [muArray objectAtIndex:2];
            
            //异步加载图片
            downOperation = [self loadingImageOperation:muDict andImageView:thirdImg];
            if (downOperation != nil)
            {
                [thumbDownQueue addOperation:downOperation];
            }
            
            [thirdLabelTitle setText:[muDict objectForKey:@"title"]];
            thirdLabelTitle.backgroundColor = [UIColor clearColor];
            
            thirdImg.accessibilityLabel = [muDict objectForKey:@"serverID"];
            thirdImg.userInteractionEnabled = YES;
            UITapGestureRecognizer *sigTab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panelClick:)];
            [thirdImg addGestureRecognizer:sigTab];
            
            if ([[muDict objectForKey:@"hasVideo"] intValue] == 1)
            {
                [self addVideoImage:thirdImg];
            }
        }
        else
        {
            thirdImg.hidden = YES;
            thirdLabelTitle.hidden = YES;
            thirdView.hidden = YES;
        }
        
        UIImageView *fourImg = (UIImageView*)[subview viewWithTag:309];
        UILabel* fourLabelTitle = (UILabel*)[subview viewWithTag:310];
        UIView *fourView = (UIView *)[subview viewWithTag:323];
        
        if (muArray.count >= 4 && [muArray objectAtIndex:3])
        {
            NSMutableDictionary *muDict = [muArray objectAtIndex:3];
            
            //异步加载图片
            downOperation = [self loadingImageOperation:muDict andImageView:fourImg];
            if (downOperation != nil)
            {
                [thumbDownQueue addOperation:downOperation];
            }
            
            
            [fourLabelTitle setText:[muDict objectForKey:@"title"]];
            fourLabelTitle.backgroundColor = [UIColor clearColor];
            
            fourImg.accessibilityLabel = [muDict objectForKey:@"serverID"];
            fourImg.userInteractionEnabled = YES;
            UITapGestureRecognizer *sigTab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panelClick:)];
            [fourImg addGestureRecognizer:sigTab];
            
            if ([[muDict objectForKey:@"hasVideo"] intValue] == 1)
            {
                [self addVideoImage:fourImg];
            }
        }
        else
        {
            fourImg.hidden = YES;
            fourLabelTitle.hidden = YES;
            fourView.hidden = YES;
        }
        
        UIImageView *fiveImg = (UIImageView*)[subview viewWithTag:315];
        UILabel* fiveLabelTitle = (UILabel*)[subview viewWithTag:316];
        UIView *fiveView = (UIView *)[subview viewWithTag:325];
        
        if (muArray.count >= 5 && [muArray objectAtIndex:4])
        {
            NSMutableDictionary *muDict = [muArray objectAtIndex:4];
            
            //异步加载图片
            downOperation = [self loadingImageOperation:muDict andImageView:fiveImg];
            if (downOperation != nil)
            {
                [thumbDownQueue addOperation:downOperation];
            }
            
            [fiveLabelTitle setText:[muDict objectForKey:@"title"]];
            fiveLabelTitle.backgroundColor = [UIColor clearColor];
            
            fiveImg.accessibilityLabel = [muDict objectForKey:@"serverID"];
            fiveImg.userInteractionEnabled = YES;
            UITapGestureRecognizer *sigTab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panelClick:)];
            [fiveImg addGestureRecognizer:sigTab];
            
            if ([[muDict objectForKey:@"hasVideo"] intValue] == 1)
            {
                [self addVideoImage:fiveImg];
            }
        }
        else
        {
            fiveImg.hidden = YES;
            fiveLabelTitle.hidden = YES;
            fiveView.hidden = YES;
        }
        
        [columnScrollView addSubview:subview];
        
        [muDistionary setObject:subview forKey:[NSNumber  numberWithInt:(pageNum)]];
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

- (IBAction)changePage:(id)sender
{
    pageControlBeingUsed = YES;
}
@end
