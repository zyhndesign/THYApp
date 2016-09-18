//
//  ViewController.h
//  NewTD
//
//  Created by 工业设计中意（湖南） on 14-5-8.
//  Copyright (c) 2014年 中意工业设计（湖南）有限责任公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SuperColumnViewController;
@class FooterViewController;
@class MusicViewController;

@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIButton *menuLandscapeBtn;
    IBOutlet UIButton *menuHumanityBtn;
    IBOutlet UIButton *menuStoryBtn;
    IBOutlet UIButton *menuCommunityBtn;
    
    IBOutlet UILabel *menuLandscapeLabel;
    IBOutlet UILabel *menuHumanityLabel;
    IBOutlet UILabel *menuStoryLabel;
    IBOutlet UILabel *menuCommunityLabel;
    
    IBOutlet UIScrollView *mainScrollView;
    IBOutlet UIImageView *logoImageView;
    
    IBOutlet UIImageView *musicBtn;
    
    SuperColumnViewController *homeViewController;
    SuperColumnViewController *landscapeViewController;
    SuperColumnViewController *humanityViewController;
    SuperColumnViewController *storyViewController;
    SuperColumnViewController *communityViewController;
    FooterViewController *footerViewController;

    MusicViewController *musicViewController;
    /**
     *  在ScrollView 中各个栏目Y坐标值
     */
    int landscapeYValue;
    int humanityYValue;
    int storyYValue;
    int communityYValue;
  
}
@property (strong, nonatomic) IBOutlet UIButton *menuLandscapeBtn;
@property (strong, nonatomic) IBOutlet UIButton *menuHumanityBtn;
@property (strong, nonatomic) IBOutlet UIButton *menuStoryBtn;
@property (strong, nonatomic) IBOutlet UIButton *menuCommunityBtn;

@property (strong, nonatomic) IBOutlet UILabel *menuLandscapeLabel;
@property (strong, nonatomic) IBOutlet UILabel *menuHumanityLabel;
@property (strong, nonatomic) IBOutlet UILabel *menuStoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *menuCommunityLabel;

@property (strong, nonatomic) IBOutlet UIImageView *musicBtn;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

/**
 *  风景菜单点击事件，控制ScrollView的滚动条到风景栏目
 *
 *  @param sender <#sender description#>
 */
- (IBAction)menuLandscapeBtnClick:(id)sender;

/**
 *  人文菜单点击事件，控制ScrollView的滚动条到风景栏目
 *
 *  @param sender <#sender description#>
 */
- (IBAction)menuHumanityBtnClick:(id)sender;

/**
 *  物语菜单点击事件，控制ScrollView的滚动条到风景栏目
 *
 *  @param sender <#sender description#>
 */
- (IBAction)menuStoryBtnClick:(id)sender;

/**
 *  社区菜单点击事件，控制ScrollView的滚动条到风景栏目
 *
 *  @param sender <#sender description#>
 */
- (IBAction)menuCommunityBtnClick:(id)sender;

/**
 *  logo的点击事件
 */
-(void)logoOnClick;

/**
 *  设置顶部按钮状态，颜色值
 *
 *  @param landBtnState     当前为风景栏目
 *  @param humanityBtnState 当前为人文栏目
 *  @param storyBtnState    当前为物语栏目
 *  @param communityState   当前为社区栏目
 */
- (void) setNavBtnSelectState:(BOOL)landBtnState Humanity:(BOOL)humanityBtnState Story:(BOOL)storyBtnState Community:(BOOL)communityState;

/**
 *  音乐播放按钮事件
 */
-(void) musicBtnClick;
@end
