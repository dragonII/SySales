//
//  PTRXDetailForHomePageViewController.m
//  SySales
//
//  Created by Wang Long on 12/4/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXDetailForHomePageViewController.h"

@interface PTRXDetailForHomePageViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

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

@end
