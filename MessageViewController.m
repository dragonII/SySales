//
//  PTRXMessageViewController.m
//  SySales
//
//  Created by Wang Long on 1/23/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController () <UIWebViewDelegate>

@property (strong, nonatomic) NSArray *urlArray;

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)showSpinner
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.color = [UIColor grayColor];
    
    //UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    spinner.center = CGPointMake(CGRectGetMidX(self.webView.bounds) + 0.5f, CGRectGetMidY(self.webView.bounds) + 0.5f);
    
    spinner.tag = 1002;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (void)hideSpinner
{
    [[self.view viewWithTag:1002] removeFromSuperview];
}

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
    NSString *urlString = (NSString *)[[self.urlArray objectAtIndex:3] objectForKey:@"url"];
    //NSLog(@"urlString: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    return request;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.webView.delegate = self;
    
    [self.webView loadRequest:[self getURLRequest]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //NSUInteger index = [self.tabBarController.tabBar.items indexOfObject:self.tabBarController.tabBar.selectedItem];
    //NSLog(@"Index: %d", index);
    
    //[self.webView loadRequest:[self getURLRequest]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //[self showSpinner];
    [self showNetworkActivityIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[self hideSpinner];
    [self hideNetworkActivityIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
