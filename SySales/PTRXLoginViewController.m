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
    //[self testLogin];
    //[self postLogin];
}

- (void)getXML
{
    NSString *URLString = @"http://scs3.syslive.cn/interface_mb/login_mb/login.ds";
    NSDictionary *dict = @{@"USERNAME": @"999", @"PASSWORD": @"123456"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager POST:URLString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"POST --> %@", responseObject);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) postLogin
{
    NSString *URLString = @"http://scs3.syslive.cn/interface_mb/login_mb/login.ds";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSDictionary *dict = @{@"user": @"666", @"password": @"123"};
    
    [manager POST:URLString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"POST --> %@", responseObject);
        
        NSXMLParser *xmlParser = (NSXMLParser *)responseObject;
        [xmlParser setShouldProcessNamespaces:YES];
        NSLog(@"POST --> %@", xmlParser);
        xmlParser.delegate = self;
        [xmlParser parse];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
    [NSThread sleepForTimeInterval:1];
    return YES;
}

- (void)dealloc
{
    NSLog(@"dealloc: %@", self);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Did Start Document");
    self.xmlContent = [NSMutableDictionary dictionary];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.elementName = qName;
    NSLog(@"Start Element: %@", qName);
    self.currentDictionary = [NSMutableDictionary dictionary];
    self.outString = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"Found Characters: %@", string);
    if(!self.elementName)
        return;
    [self.outString appendFormat:@"%@", string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"End Element: %@", qName);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"End Document");
}

@end
