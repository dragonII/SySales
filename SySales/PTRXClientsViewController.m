//
//  PTRXClientsViewController.m
//  SySales
//
//  Created by Wang Long on 11/28/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXClientsViewController.h"
#import "PTRXMainViewController.h"
#import "PTRXParameterFromContentNavigationToTabs.h"

//static NSString * const ClientLinkAddress = @"http://scs3.syslive.cn/mb/customer/customerlist.ds";

@interface PTRXClientsViewController ()

@property (weak, nonatomic) IBOutlet UITabBarItem *barButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PTRXClientsViewController

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
    PTRXParameterFromContentNavigationToTabs *parameter = [PTRXParameterFromContentNavigationToTabs sharedParameter];
    
    self.barButton.title = parameter.barButtonOneName;
    NSURL *url = [NSURL URLWithString:parameter.urlStringForWebView];
    NSLog(@"urlString: %@", parameter.urlStringForWebView);
    //NSURL *url = [NSURL URLWithString:ClientLinkAddress];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
