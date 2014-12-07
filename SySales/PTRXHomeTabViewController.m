//
//  PTRXHomeTabViewController.m
//  SySales
//
//  Created by Wang Long on 12/4/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXHomeTabViewController.h"
#import "PTRXDetailForHomePageViewController.h"
#import "PTRXConstants.h"

#import <AFNetworking/AFNetworking.h>

@interface PTRXHomeTabViewController ()
{
    PTRXConstants *_Constants;
    BOOL _logoutFinished;
}

@end

@implementation PTRXHomeTabViewController

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
    
    _Constants = [PTRXConstants sharedConstants];
    _logoutFinished = NO;
    
    
    
    [self addActionsToButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addActionsToButtons
{
    for(int i = 2001; i <= 2009; i++)
    {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        [button addTarget:self action:@selector(navigationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)navigationButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSLog(@"Button %@ clicked", button.titleLabel.text);
    
    NSInteger tag = button.tag;
    
    if(tag != 2009)
    {
        [self performSegueWithIdentifier:@"ToHomeDetail" sender:sender];
    } else {
        // Logout Button Clicked
        
        NSURL *url = [NSURL URLWithString:_Constants.PTRX_S_LOGIN_URL];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        NSDictionary *parameter = @{@"type": @"logout"};
        NSLog(@"Parameter: %@", parameter);
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        [manager POST:@""
           parameters:parameter
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  //NSLog(@"%@", responseString);
                  NSLog(@"Response: %@", [NSString stringWithString:responseString]);
                  _logoutFinished = YES;
              }failure:^(NSURLSessionDataTask *task, NSError *error) {
                  NSLog(@"Error: %@", [error description]);
              }];
        while(_logoutFinished == NO)
        {
            [NSThread sleepForTimeInterval:0.01];
        }
        [self.navigationController dismissViewControllerAnimated:YES
                                 completion:^{
                                     // Remove saved user and password;
                                 }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIButton *button = (UIButton *)sender;
    PTRXDetailForHomePageViewController *detailVC = (PTRXDetailForHomePageViewController *)segue.destinationViewController;
    NSInteger tag = button.tag;
    
    NSString *urlString;
    
    switch (tag)
    {
        // Clients
        case 2001:
            urlString = @"http://scs3.syslive.cn/mb/customer/customerlist.ds";
            detailVC.urlStringForWebView = urlString;
            break;
        // Projects
        case 2002:
            urlString = @"http://scs3.syslive.cn/mb/projects/projectlist.ds";
            detailVC.urlStringForWebView = urlString;
            break;
        // Settings
        case 2006:
            break;
            
        default:
            break;
    }
}

- (void)backToHome:(UIStoryboardSegue *)segue
{

}

@end
