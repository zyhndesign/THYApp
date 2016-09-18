//
//  ViewController.m
//  NewTD
//
//  Created by 工业设计中意（湖南） on 14-5-8.
//  Copyright (c) 2014年 中意工业设计（湖南）有限责任公司. All rights reserved.
//

#import "ViewController.h"
#import "controllers/HomeViewController.h"
#import "controllers/LandscapeViewController.h"
#import "controllers/HumanityViewController.h"
#import "controllers/StoryViewController.h"
#import "controllers/FooterViewController.h"
#import "controllers/CommunityViewController.h"
#import "controllers/MusicViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize menuCommunityBtn, menuStoryBtn,menuLandscapeBtn,menuHumanityBtn;

@synthesize menuCommunityLabel, menuHumanityLabel, menuLandscapeLabel, menuStoryLabel;
@synthesize mainScrollView, logoImageView;

@synthesize musicBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //set full screen
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    mainScrollView.backgroundColor = [UIColor blackColor];
    
    CGRect screenBounds = [[UIScreen mainScreen]bounds];
    
    NSBundle* mainBundle = [NSBundle mainBundle];
    
    CGFloat originHeight = 0.0;
    
    homeViewController = [[HomeViewController new] initWithNibName:@"HomeBoard" bundle:mainBundle];
    CGSize homeCGSize = homeViewController.view.frame.size;
    [mainScrollView addSubview:homeViewController.view];
    [self addChildViewController:homeViewController];
    
    
    landscapeViewController = [[LandscapeViewController new] initWithNibName:@"LandscapeBoard" bundle:mainBundle];
    CGSize landscapeCGSize = landscapeViewController.view.frame.size;
    originHeight = originHeight + homeCGSize.height;
    landscapeViewController.view.frame = CGRectMake(0, originHeight,landscapeCGSize.width,landscapeCGSize.height);
    landscapeYValue = originHeight;
    [mainScrollView addSubview:landscapeViewController.view];
    [self addChildViewController:landscapeViewController];
    
    humanityViewController = [[HumanityViewController new] initWithNibName:@"HumanityBoard" bundle:mainBundle];
    CGSize humanityCGSize = humanityViewController.view.frame.size;
    
    originHeight = originHeight + landscapeCGSize.height;
    humanityViewController.view.frame = CGRectMake(0, originHeight,humanityCGSize.width,humanityCGSize.height);
    humanityYValue = originHeight;
    [mainScrollView addSubview:humanityViewController.view];
    [self addChildViewController:humanityViewController];
    
    storyViewController = [[StoryViewController new] initWithNibName:@"StoryBoard" bundle:mainBundle];
    CGSize storyCGSize = storyViewController.view.frame.size;
    
    originHeight = originHeight + humanityCGSize.height;
    storyViewController.view.frame = CGRectMake(0, originHeight,storyCGSize.width,storyCGSize.height);
    storyYValue = originHeight;
    [mainScrollView addSubview:storyViewController.view];
    [self addChildViewController:storyViewController];
    
    communityViewController = [[CommunityViewController new] initWithNibName:@"CommunityBoard" bundle:mainBundle];
    CGSize communityCGSize = communityViewController.view.frame.size;
    
    originHeight = originHeight + storyCGSize.height;
    communityViewController.view.frame = CGRectMake(0, originHeight,communityCGSize.width,communityCGSize.height);
    communityYValue = originHeight;
    [mainScrollView addSubview:communityViewController.view];
    [self addChildViewController:communityViewController];
    
    //NSArray *nibFooterView = [mainBundle loadNibNamed:@"Footer" owner:self options:nil];
    //UIView *footerView = [nibFooterView objectAtIndex:0];
    
    footerViewController = [[FooterViewController new] initWithNibName:@"Footer" bundle:mainBundle];
    CGSize footerCGSize = footerViewController.view.frame.size;
    
    originHeight = originHeight + communityCGSize.height;
    footerViewController.view.frame = CGRectMake(0, originHeight,footerCGSize.width,footerCGSize.height);
    [mainScrollView addSubview:footerViewController.view];
    [self addChildViewController:footerViewController];
    
    CGFloat contentSizeHeight = homeCGSize.height +  landscapeCGSize.height + humanityCGSize.height +  storyCGSize.height + communityCGSize.height + footerCGSize.height;
    
    mainScrollView.contentSize = CGSizeMake(screenBounds.size.width, contentSizeHeight);
    //mainScrollView.bounces = NO;
    mainScrollView.delegate = self;

    logoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoOnClick)];
    [logoImageView addGestureRecognizer:singleTap];
    
    [menuCommunityBtn setTitle:NSLocalizedString(@"Community", nil) forState:UIControlStateNormal];
    [menuLandscapeBtn setTitle:NSLocalizedString(@"Landscape", nil) forState:UIControlStateNormal];
    [menuHumanityBtn setTitle:NSLocalizedString(@"Humanity", nil) forState:UIControlStateNormal];
    [menuStoryBtn setTitle:NSLocalizedString(@"Story", nil) forState:UIControlStateNormal];
    [menuLandscapeLabel setHidden:YES];
    [menuCommunityLabel setHidden:YES];
    [menuHumanityLabel setHidden:YES];
    [menuStoryLabel setHidden:YES];
        
    musicViewController = [[MusicViewController new] initWithNibName:@"MusicPlayerView" bundle:mainBundle];
    [musicViewController.view setFrame:CGRectMake(1024, 718, musicViewController.view.frame.size.width, musicViewController.view.frame.size.height)];
    [self.view addSubview:musicViewController.view];
    
    musicBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *sigTab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(musicBtnClick)];
    [musicBtn addGestureRecognizer:sigTab];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    
    CGFloat offsetY = _scrollView.contentOffset.y;
    
    if (offsetY >= landscapeYValue && offsetY < humanityYValue)
    {
        [self setNavBtnSelectState:true Humanity:false Story:false Community:false];
    }
    else if (offsetY >= humanityYValue && offsetY < storyYValue)
    {
        [self setNavBtnSelectState:false Humanity:true Story:false Community:false];
    }
    else if (offsetY >= storyYValue && offsetY < communityYValue)
    {
        [self setNavBtnSelectState:false Humanity:false Story:true Community:false];
    }
    else if (offsetY >= communityYValue)
    {
        [self setNavBtnSelectState:false Humanity:false Story:false Community:true];
    }
    else if (offsetY < landscapeYValue)
    {
        [self setNavBtnSelectState:false Humanity:false Story:false Community:false];
    }
    
}

-(void)logoOnClick
{
    [mainScrollView setContentOffset:CGPointMake(mainScrollView.frame.origin.x, 0) animated:YES];
    [self setNavBtnSelectState:NO Humanity:NO Story:NO Community:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuLandscapeBtnClick:(id)sender
{
    [mainScrollView setContentOffset:CGPointMake(mainScrollView.frame.origin.x, landscapeYValue) animated:YES];
    [self setNavBtnSelectState:YES Humanity:NO Story:NO Community:NO];
}

- (IBAction)menuHumanityBtnClick:(id)sender
{
    [mainScrollView setContentOffset:CGPointMake(mainScrollView.frame.origin.x, humanityYValue) animated:YES];
    [self setNavBtnSelectState:NO Humanity:YES Story:NO Community:NO];
}

- (IBAction)menuStoryBtnClick:(id)sender
{
    [mainScrollView setContentOffset:CGPointMake(mainScrollView.frame.origin.x, storyYValue) animated:YES];
    [self setNavBtnSelectState:NO Humanity:NO Story:YES Community:NO];
}

- (IBAction)menuCommunityBtnClick:(id)sender
{
    [mainScrollView setContentOffset:CGPointMake(mainScrollView.frame.origin.x, communityYValue) animated:YES];
    [self setNavBtnSelectState:NO Humanity:NO Story:NO Community:YES];
}

- (void) setNavBtnSelectState:(BOOL)landBtnState Humanity:(BOOL)humanityBtnState Story:(BOOL)storyBtnState Community:(BOOL)communityState
{
    if (landBtnState && menuLandscapeBtn != nil)
    {
        [menuLandscapeBtn setTitleColor:[UIColor colorWithRed:251/255.0 green:25/255.0 blue:5/255.0 alpha:1] forState:UIControlStateNormal];
        [menuHumanityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuStoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuCommunityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [menuLandscapeLabel setHidden:NO];
        [menuCommunityLabel setHidden:YES];
        [menuHumanityLabel setHidden:YES];
        [menuStoryLabel setHidden:YES];
    }
    
    if (humanityBtnState && menuHumanityBtn != nil)
    {
        [menuHumanityBtn setTitleColor:[UIColor colorWithRed:251/255.0 green:25/255.0 blue:5/255.0 alpha:1] forState:UIControlStateNormal];
        [menuLandscapeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuStoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuCommunityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuLandscapeLabel setHidden:YES];
        [menuCommunityLabel setHidden:YES];
        [menuHumanityLabel setHidden:NO];
        [menuStoryLabel setHidden:YES];
    }
    
    if (storyBtnState && menuStoryBtn != nil)
    {
        [menuStoryBtn setTitleColor:[UIColor colorWithRed:251/255.0 green:25/255.0 blue:5/255.0 alpha:1] forState:UIControlStateNormal];
        [menuHumanityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuLandscapeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuCommunityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuLandscapeLabel setHidden:YES];
        [menuCommunityLabel setHidden:YES];
        [menuHumanityLabel setHidden:YES];
        [menuStoryLabel setHidden:NO];
    }
    
    if (communityState && menuCommunityBtn != nil)
    {
        [menuCommunityBtn setTitleColor:[UIColor colorWithRed:251/255.0 green:25/255.0 blue:5/255.0 alpha:1] forState:UIControlStateNormal];
        [menuHumanityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuStoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuLandscapeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuLandscapeLabel setHidden:YES];
        [menuCommunityLabel setHidden:NO];
        [menuHumanityLabel setHidden:YES];
        [menuStoryLabel setHidden:YES];
    }
    
    if (!landBtnState && !humanityBtnState && !storyBtnState && !communityState)
    {
        [menuCommunityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuHumanityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuStoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuLandscapeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuLandscapeLabel setHidden:YES];
        [menuCommunityLabel setHidden:YES];
        [menuHumanityLabel setHidden:YES];
        [menuStoryLabel setHidden:YES];
    }
}

-(void) musicBtnClick
{
    [self.view bringSubviewToFront:musicBtn];
    if(musicViewController != nil)
    {
        if (musicViewController.view.frame.origin.x == 0)
        {
            [UIView animateWithDuration:0.3
                             animations:^(void){
                                 [musicViewController.view setCenter:CGPointMake(1024 + 512, musicViewController.view.center.y)];
                             }
                             completion:^(BOOL finish){
                             }];
        }
        else
        {
            [UIView animateWithDuration:0.3
                             animations:^(void){
                                 [musicViewController.view setCenter:CGPointMake( 512, musicViewController.view.center.y)];
                             }
                             completion:^(BOOL finish){
                             }];
        }
    }
   
}
@end
