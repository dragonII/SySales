//
//  PTRXMainViewController.m
//  SyslivePM
//
//  Created by Wang Long on 11/19/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXMainViewController.h"
#import "PTRXWizardViewController.h"
#import "PTRXLoginViewController.h"
#import "PTRXContentNavigationViewController.h"

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
    
    self.wizardController = [self.storyboard instantiateViewControllerWithIdentifier:@"Wizard"];
    self.wizardController.mainController = self;
    [self.view insertSubview:self.wizardController.view atIndex:0];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
