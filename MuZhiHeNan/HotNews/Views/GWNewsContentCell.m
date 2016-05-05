//
//  GWNewsContentCell.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewsContentCell.h"

@interface GWNewsContentCell () <UIWebViewDelegate>
{
    NSUInteger _percent;
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) CGFloat height;

@end

@implementation GWNewsContentCell

- (void)awakeFromNib
{
    _percent = -1;
}

- (void)setModel:(GWNewsDetailModel *)model
{
    _model = model;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 2, kScreenSize.width - 20, 30)];
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    webView.userInteractionEnabled = NO;
    model.content = kNSString(@"<head><style>img{width:%fpx !important;}</style></head>%@",webView.frame.size.width,model.content);
    [webView loadHTMLString:model.content baseURL:nil];
    [self addSubview:webView];
    self.webView = webView;
}


#pragma mark -UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect webViewRect = webView.frame;
    webViewRect.size.height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];
    self.height = webViewRect.size.height;
    self.webView.frame = webViewRect;
    [self responds];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    CGRect webViewRect = webView.frame;
    self.height = webViewRect.origin.y;
    webViewRect.size.height = 0;
    self.height += webViewRect.size.height;
    self.webView.frame = webViewRect;
    [self responds];
}

- (void)responds
{
    if (_delegate && [_delegate respondsToSelector:@selector(newsContentCell:cellHeight:)]) {
        [_delegate newsContentCell:self cellHeight:self.height];
    }
}


@end
