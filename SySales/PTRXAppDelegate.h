//
//  PTRXAppDelegate.h
//  SySales
//
//  Created by Wang Long on 11/25/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PTRXMainViewController.h"
#import "PTRXWizardViewController.h"
#import "PTRXLoginViewController.h"
//#import "PTRXContentNavigationViewController.h"
//#import "PTRXContentTabsViewController.h"

@interface PTRXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PTRXMainViewController *mainController;
@property (strong, nonatomic) PTRXWizardViewController *wizardController;
@property (strong, nonatomic) PTRXLoginViewController *loginController;
//@property (strong, nonatomic) PTRXContentNavigationViewController *contentNVController;
//@property (strong, nonatomic) PTRXContentTabsViewController *contentTabsController;

@end
