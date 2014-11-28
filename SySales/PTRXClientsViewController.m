//
//  PTRXClientsViewController.m
//  SySales
//
//  Created by Wang Long on 11/28/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXClientsViewController.h"

@interface PTRXClientsViewController ()

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
