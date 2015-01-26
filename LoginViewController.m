//
//  LoginViewController.m
//  SySales
//
//  Created by Wang Long on 1/26/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import "LoginViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "AppPreference.h"


static NSString *WrongUserOrPassword = @"<rest name=\"rest\">2</rest>";
static NSString *NoSuchUser = @"<rest name=\"rest\">0</rest>";
static NSString *LoginOK = @"<rest name=\"rest\">1</rest>";
static NSString *LockedAccount = @"<rest name=\"rest\">3</rest>";


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *accountBackgroundView;

@property (weak, nonatomic) IBOutlet UIView *passwordBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property dispatch_group_t globalGroup;
@property (strong, nonatomic) AFHTTPSessionManager *httpSessionManager;

@property (strong, nonatomic) NSDictionary *loginStatusDict;

@property int loginStatusCode;

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
    
    NSDictionary *dict = [AppPreference loadUserNameAndPassword];
    if(dict != nil)
    {
        self.accountTextField.text = dict[@"username"];
    }
}

- (NSString *)getLoginURLString
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"URLs" ofType:@"plist"];
    NSArray *urlArray = [NSArray arrayWithContentsOfFile:path];
    NSString *urlString = (NSString *)[[urlArray objectAtIndex:0] objectForKey:@"url"];
    
    return urlString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViewComponents];
    
    NSURL *url = [NSURL URLWithString:[self getLoginURLString]];
    self.httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    self.httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.httpSessionManager.responseSerializer.acceptableContentTypes = [self.httpSessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"html/text"];
    
    self.loginStatusDict = @{LoginOK: @0,
                             WrongUserOrPassword: @1,
                             NoSuchUser: @2,
                             LockedAccount: @3};
    self.loginStatusCode = -2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)showSpinner
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.color = [UIColor grayColor];
    
    spinner.center = CGPointMake(CGRectGetMidX(self.view.bounds) + 0.5f, self.loginButton.frame.origin.y + 90);
    
    spinner.tag = 1000;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (void)hideSpinner
{
    [[self.view viewWithTag:1000] removeFromSuperview];
}

- (void)disableInput
{
    self.loginButton.enabled = NO;
    self.loginButton.alpha = 0.18f;
    self.accountTextField.enabled = NO;
    self.passwordTextField.enabled = NO;
    self.accountTextField.alpha = 0.18f;
    self.passwordTextField.alpha = 0.18f;
    
    [self showSpinner];
}

- (void)enableInput
{
    self.loginButton.enabled = YES;
    self.loginButton.alpha = 1.0f;
    self.accountTextField.enabled = YES;
    self.passwordTextField.enabled = YES;
    self.accountTextField.alpha = 1.0f;
    self.passwordTextField.alpha = 1.0f;
    
    [self hideSpinner];
}

- (void)performLoginWithUsername:(NSString *)username Password:(NSString *)password
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"user"] = username;
    params[@"password"] = password;
    
    dispatch_group_enter(_globalGroup);
    
    [self.httpSessionManager POST:@""
                       parameters:params
                          success:^(NSURLSessionDataTask *task, id responseObject) {
                              NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                              //NSLog(@"responseString: %@", responseString);
                              [self getResultByString:responseString];
                              NSLog(@"Login Status Code: %ld", (long)_loginStatusCode);
                              if(_loginStatusCode == 0)
                              {
                                  //[self.appDelegate updateLastOperationTimeStamp];
                                  [AppPreference saveUserName:self.accountTextField.text withPassword:self.passwordTextField.text];
                              }
                              dispatch_group_leave(_globalGroup);
                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                              _loginStatusCode = -2;
                              NSLog(@"Error: %@", [error localizedDescription]);
                              dispatch_group_leave(_globalGroup);
                          }];
}

- (void)getResultByString:(NSString *)responseString
{
    NSString *keyString;
    for( keyString in [self.loginStatusDict allKeys])
    {
        if([responseString rangeOfString:keyString].location != NSNotFound)
        {
            _loginStatusCode = [self.loginStatusDict[keyString] intValue];
            return;
        }
    }
    _loginStatusCode = -1;
}

- (void)showAlert
{
    NSString *message;
    switch (_loginStatusCode)
    {
        case -2:
            message = [NSString stringWithFormat:@"%@", @"未连接到服务器"];
            break;
        case 1:
            message = [NSString stringWithFormat:@"%@", @"密码错误"];
            break;
        case 2:
            message = [NSString stringWithFormat:@"%@", @"账户名不存在"];
            break;
        case 3:
            message = [NSString stringWithFormat:@"%@", @"账户已冻结"];
            break;
            
        default:
            message = nil;
            break;
    }
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"登录失败"
                              message:message
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                              otherButtonTitles:nil];
    
    [alertView show];
}

- (void)batchTasks
{
    [self disableInput];
    
    _globalGroup = dispatch_group_create();
    
    [self performLoginWithUsername:self.accountTextField.text Password:self.passwordTextField.text];
    
    // Here we wait for all the requests to finish
    dispatch_group_notify(_globalGroup, dispatch_get_main_queue(), ^{
        // Do whatever you need to do when all requests are finished
        [self enableInput];
        if(_loginStatusCode == 0)
        {
            NSLog(@"Status Code: %ld", (long)_loginStatusCode);
            [self performSegueWithIdentifier:@"ShowContentTabsSegue" sender:nil];
        } else {
            NSLog(@"failed");
            [self showAlert];
        }
    });
}

- (IBAction)clickLoginButton:(id)sender
{
    [self batchTasks];
    
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
        [self batchTasks];
    }

}
@end
