//
//  HomeViewController.h
//  NewTD
//
//  Created by 工业设计中意（湖南） on 14-5-13.
//  Copyright (c) 2014年 中意工业设计（湖南）有限责任公司. All rights reserved.
//

#import "SuperColumnViewController.h"

@interface HomeViewController : SuperColumnViewController
{

    IBOutlet UIImageView *columnBigBg;
    IBOutlet UIControl *firstViewPanel;
    IBOutlet UILabel *firstArticleTitle;
    IBOutlet UILabel *firstArticleTime;
    
    
    IBOutlet UIControl *secondViewPanel;
    IBOutlet UILabel *secondArticleTimeLabel;
    IBOutlet UIImageView *secondArticleThumb;
    IBOutlet UILabel *secondArticleTitleLabel;
    IBOutlet UILabel *secondArticleSummaryLabel;
    
    IBOutlet UIControl *threeViewPanel;
    IBOutlet UILabel *threeArticleTimeLabel;
    IBOutlet UIImageView *threeArticleThumb;
    IBOutlet UILabel *threeArticleTitleLabel;
    IBOutlet UILabel *threeArticleSummaryLabel;
    
    IBOutlet UIControl *fourViewPanel;
    IBOutlet UILabel *fourArticleTimeLabel;
    IBOutlet UIImageView *fourArticleThumb;
    IBOutlet UILabel *fourArticleTitleLabel;
    IBOutlet UILabel *fourArticleSummaryLabel;
}

@property (nonatomic, strong) IBOutlet UIImageView *columnBigBg;
@property (nonatomic, strong) IBOutlet UIView *firstViewPanel;
@property (nonatomic, strong) IBOutlet UILabel *firstArticleTitle;
@property (nonatomic, strong) IBOutlet UILabel *firstArticleTime;


@property (nonatomic, strong) IBOutlet UIView *secondViewPanel;
@property (nonatomic, strong) IBOutlet UILabel *secondArticleTimeLabel;
@property (nonatomic, strong) IBOutlet UIImageView *secondArticleThumb;
@property (nonatomic, strong) IBOutlet UILabel *secondArticleTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondArticleSummaryLabel;

@property (nonatomic, strong) IBOutlet UIView *threeViewPanel;
@property (nonatomic, strong) IBOutlet UILabel *threeArticleTimeLabel;
@property (nonatomic, strong) IBOutlet UIImageView *threeArticleThumb;
@property (nonatomic, strong) IBOutlet UILabel *threeArticleTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *threeArticleSummaryLabel;

@property (nonatomic, strong) IBOutlet UIView *fourViewPanel;
@property (nonatomic, strong) IBOutlet UILabel *fourArticleTimeLabel;
@property (nonatomic, strong) IBOutlet UIImageView *fourArticleThumb;
@property (nonatomic, strong) IBOutlet UILabel *fourArticleTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *fourArticleSummaryLabel;
@end
