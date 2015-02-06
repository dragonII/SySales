//
//  AboutMeViewController.m
//  SySales
//
//  Created by Wang Long on 2/6/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSArray *urlArray;

@end

@implementation AboutMeViewController

- (void)showNetworkActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)hideNetworkActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (NSURLRequest *)getURLRequest
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"URLs" ofType:@"plist"];
    self.urlArray = [NSArray arrayWithContentsOfFile:path];
    NSString *urlString = (NSString *)[[self.urlArray objectAtIndex:4] objectForKey:@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [NSURLRequest requestWithURL:url];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    [self.webView loadRequest:[self getURLRequest]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -WebView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showNetworkActivityIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideNetworkActivityIndicator];
}

@end
