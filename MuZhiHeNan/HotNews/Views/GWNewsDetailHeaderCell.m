//
//  GWNewsDetailHeaderCell.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/2.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewsDetailHeaderCell.h"

@interface GWNewsDetailHeaderCell () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (weak, nonatomic) IBOutlet UILabel *lblCopyFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblCatname;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIView *shareView;

@property (nonatomic, assign) CGFloat height;

@end

@implementation GWNewsDetailHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(GWNewsDetailModel *)model
{
    _model = model;
    self.lblTitle.text = model.title;
    self.lblCopyFrom.text = model.copyfrom;
    self.lblTime.text = model.inputtime;
    self.lblCatname.text = model.catname;
    self.webView.delegate = self;
    [self.webView loadHTMLString:model.content baseURL:nil];
}

#pragma mark -UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect webViewRect = webView.frame;
    CGRect shareViewRect = self.shareView.frame;
    self.height = webViewRect.origin.y;
    webViewRect.size.height = webView.scrollView.contentSize.height;
    self.height += webViewRect.size.height;
    self.webView.frame = webViewRect;
    shareViewRect.origin.y = self.height;
    self.shareView.frame = shareViewRect;
    
    [self responds];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    CGRect webViewRect = webView.frame;
    CGRect shareViewRect = self.shareView.frame;
    self.height = webViewRect.origin.y;
    webViewRect.size.height = 0;
    self.height += webViewRect.size.height;
    self.webView.frame = webViewRect;
    shareViewRect.origin.y = self.height;
    self.shareView.frame = shareViewRect;
    
    [self responds];
}

- (void)responds
{
    if (_delegate && [_delegate respondsToSelector:@selector(newsDetailHeaderCell:cellHeight:)]) {
        [_delegate newsDetailHeaderCell:self cellHeight:self.height];
    }
}

@end
