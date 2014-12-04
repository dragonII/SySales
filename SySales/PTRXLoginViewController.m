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
#import "PTRXConstants.h"
#import "PTRXDataPersistence.h"

#import <AFNetworking/AFNetworking.h>

@interface PTRXLoginViewController () <NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (strong, nonatomic) NSMutableDictionary *xmlContent;
@property (strong, nonatomic) NSString *elementName;
@property (strong, nonatomic) NSMutableString *outString;
@property (strong, nonatomic) NSMutableDictionary *currentDictionary;

- (IBAction)loginPressed:(UIButton *)sender;

@end

@implementation PTRXLoginViewController
{
    BOOL _loginFinished;
    BOOL _loginSuccess;
    PTRXConstants *_Constants;
    NSString *_resultString;
    NSString *_singleKeyString;
    NSDictionary *_userPassDict;
}

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
    _loginFinished = NO;
    _Constants = [PTRXConstants sharedConstants];
    
    _userPassDict = [PTRXDataPersistence getUserPassword];
    if(_userPassDict != nil)
    {
        NSLog(@"_userPassDict != nil");
        NSString *user = [_userPassDict objectForKey:_Constants.userKey];
        NSString *pass = [_userPassDict objectForKey:_Constants.passKey];
        
        [self loginWithUser:user password:pass];
    }
}

- (void)loginWithUser:(NSString *)user password:(NSString *)password
{
    self.nameTextField.text = user;
    self.passwdTextField.text = password;
    [self performLoginWithUser:user andPassword:password];
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
    
    [self performLoginWithUser:self.nameTextField.text
                   andPassword:self.passwdTextField.text];
    //[self postLogin
}


- (void)performLoginWithUser:(NSString *)user andPassword:(NSString *)password
{
    self.loginButton.enabled = NO;
    self.loginButton.alpha = 0.18f;
    self.nameTextField.enabled = NO;
    self.passwdTextField.enabled = NO;
    self.nameTextField.alpha = 0.18f;
    self.passwdTextField.alpha = 0.18f;
    
    self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.spinner.color = [UIColor grayColor];
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
                    [PTRXDataPersistence saveUserName:user
                                          andPassword:password];
                    [self gotoNextView];
                    //NSLog(@"login success");
                    self.loginButton.alpha = 1.0f;
                    self.loginButton.enabled = YES;
                } else {
                    
                        UIAlertView *alertView = [[UIAlertView alloc]
                                                  initWithTitle:NSLocalizedString(@"Login Failed", "Login failed")
                                                  message:[_Constants.PTRX_LOGIN_INFO_DICT objectForKey:_singleKeyString]
                                                  delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                                  otherButtonTitles:nil];
                        
                        [alertView show];
                    
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

- (void)postLogin
{
    NSURL *url = [NSURL URLWithString:_Constants.PTRX_S_LOGIN_URL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    NSDictionary *parameter = @{@"user":self.nameTextField.text, @"password":self.passwdTextField.text};
    NSLog(@"Parameter: %@", parameter);
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager POST:@""
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              //NSLog(@"%@", responseString);
              _resultString = [NSString stringWithString:responseString];
              _loginFinished = YES;
          }failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"Error: %@", [error description]);
              //responseString = nil;
              _loginFinished = YES;
          }];
}

- (BOOL)loginToServer
{
    [NSThread sleepForTimeInterval:2];
    [self postLogin];
    
    while (_loginFinished == NO)
    {
        [NSThread sleepForTimeInterval:0.001];
    }
    
    // Compare substring
    NSString *subString;
    NSInteger index;
    NSRange range = NSMakeRange(26, 1);
    for(index = 0; index < [_Constants.PTRX_LOGIN_STRINGS count]; index++)
    {
        subString = [_Constants.PTRX_LOGIN_STRINGS objectAtIndex:index];
        if([_resultString rangeOfString:subString].location != NSNotFound)
        {
            _singleKeyString = [subString substringWithRange:range];
            NSLog(@"Single: %@", _singleKeyString);
            break;
        }
    }
    
    if([_singleKeyString isEqualToString:@"1"])
    {
        return YES;
    } else {
        return NO;
    }
}

- (IBAction)textFieldDoneEditing:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    if(textField.tag == 3001)
    {
        // name text field
        [sender resignFirstResponder];
        [self.passwdTextField becomeFirstResponder];
    } else {
        // password text field
        [sender resignFirstResponder];
        [self performLoginWithUser:self.nameTextField.text
                       andPassword:self.passwdTextField.text];
    }
}



- (void)dealloc
{
    NSLog(@"dealloc: %@", self);
}


@end
