//
//  PTRXContactsViewController.m
//  SySales
//
//  Created by Wang Long on 11/30/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXContactsViewController.h"
#import "PTRXParameterFromContentNavigationToTabs.h"

@interface PTRXContactsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UITabBarItem *barButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation PTRXContactsViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
