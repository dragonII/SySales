//
//  PTRXWizardViewController.h
//  SyslivePM
//
//  Created by Wang Long on 11/18/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTRXMainViewController;
@class PTRXLoginViewController;

@interface PTRXWizardViewController : UIViewController

@property (strong, nonatomic) PTRXMainViewController *mainController;
@property (strong, nonatomic) PTRXLoginViewController *loginController;

@end
