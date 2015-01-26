//
//  LoginViewController.m
//  SySales
//
//  Created by Wang Long on 1/26/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *accountBackgroundView;

@property (weak, nonatomic) IBOutlet UIView *passwordBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initViewComponents
{
    self.accountBackgroundView.layer.cornerRadius = 5.0f;
    self.passwordBackgroundView.layer.cornerRadius = 5.0f;
    self.loginButton.layer.cornerRadius = 5.0f;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initViewComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender
{
    [self performSegueWithIdentifier:@"ShowContentTabsSegue" sender:self];
}

- (IBAction)textFieldEndEditing:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    if(textField.tag == 11)
    {
        // name text field
        [sender resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    } else {
        // password text field
        [sender resignFirstResponder];
        //[self performLoginWithUser:self.nameTextField.text andPassword:self.passwdTextField.text];
    }

}
@end
