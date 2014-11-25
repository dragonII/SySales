//
//  PTRXLoginViewController.m
//  SyslivePM
//
//  Created by Wang Long on 11/19/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXLoginViewController.h"
#import "PTRXMainViewController.h"
#import "PTRXContentNavigationViewController.h"

@interface PTRXLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (IBAction)loginPressed:(UIButton *)sender;

@end

@implementation PTRXLoginViewController

//PTRXMainViewController *_mainViewController;


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
    
    self.mainController.wizardController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(UIButton *)sender
{
    [self.nameTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
    
    [self performLogin];
}

- (void)performLogin
{
    self.loginButton.enabled = NO;
    self.loginButton.alpha = 0.18f;
    
    [self.spinner startAnimating];
    
    __block BOOL loginSuccess = NO;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            //TODO: Actual login work start here
            loginSuccess = [self loginToServer];
        });
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.spinner stopAnimating];
                if(loginSuccess == YES)
                {
                    [self gotoNextView];
                } else {
                    self.loginButton.enabled = YES;
                    self.loginButton.alpha = 1.0f;
                }
            });
        });
    });
}

- (void)gotoNextView
{
    NSLog(@"In gotoNextView");
    
    if(self.mainController.contentNVController == nil)
    {
        self.mainController.contentNVController = [self.mainController.storyboard instantiateViewControllerWithIdentifier:@"ContentNavigation"];
        self.mainController.contentNVController.mainController = self.mainController;
    }
    
    [self.view removeFromSuperview];
    [self.mainController.view insertSubview:self.mainController.contentNVController.view atIndex:0];
}

- (BOOL)loginToServer
{
    [NSThread sleepForTimeInterval:2];
    return YES;
}

- (void)dealloc
{
    NSLog(@"dealloc: %@", self);
}

@end
