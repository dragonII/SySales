//
//  PTRXMainViewController.h
//  SyslivePM
//
//  Created by Wang Long on 11/19/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTRXLoginViewController;
@class PTRXWizardViewController;
@class PTRXContentNavigationViewController;

@interface PTRXMainViewController : UIViewController

@property (strong, nonatomic) PTRXLoginViewController *loginController;
@property (strong, nonatomic) PTRXWizardViewController *wizardController;
@property (strong, nonatomic) PTRXContentNavigationViewController *contentNVController;

@end
