//
//  PTRXMainViewController.m
//  SyslivePM
//
//  Created by Wang Long on 11/19/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXMainViewController.h"
#import "PTRXAppDelegate.h"
//#import "PTRXWizardViewController.h"
//#import "PTRXLoginViewController.h"
//#import "PTRXContentNavigationViewController.h"
//#import "PTRXContentTabsViewController.h"
#import "PTRXDataPersistence.h"

@interface PTRXMainViewController ()

@end

@implementation PTRXMainViewController

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
    
    NSString *firstLaunch = [PTRXDataPersistence getFirstLaunchValue];
    
    PTRXAppDelegate *appDelegate = (PTRXAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.mainController = self;
    
    if([firstLaunch isEqualToString:@"YES"])
    {
        appDelegate.wizardController = [self.storyboard instantiateViewControllerWithIdentifier:@"Wizard"];
        //self.wizardController.mainController = self;
        [self.view insertSubview:appDelegate.wizardController.view atIndex:0];
    } else {
        appDelegate.loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        //self.loginController.mainController = self;
        [self.view insertSubview:appDelegate.loginController.view atIndex:0];
    }
    
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
