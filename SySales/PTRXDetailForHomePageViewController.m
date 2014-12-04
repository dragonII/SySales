//
//  PTRXDetailForHomePageViewController.m
//  SySales
//
//  Created by Wang Long on 12/4/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXDetailForHomePageViewController.h"

@interface PTRXDetailForHomePageViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation PTRXDetailForHomePageViewController

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
    
    self.webView.delegate = self;
    //self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    //self.spinner.color = [UIColor grayColor];
    [self initSpinner];
}

- (void)initSpinner
{
    CGFloat x = CGRectGetMidX(self.webView.frame);
    CGFloat y = CGRectGetMinY(self.webView.frame);
    
    self.spinner.center = CGPointMake(x, y);
    NSLog(@"x = %f, y = %f", x, y);
    self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.spinner.color = [UIColor grayColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.urlStringForWebView != nil && [self.urlStringForWebView length] != 0)
    {
        NSURL *url = [NSURL URLWithString:self.urlStringForWebView];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}

@end
