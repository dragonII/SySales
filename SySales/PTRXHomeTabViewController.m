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
                         

@interface PTRXHomeTabViewController () <UIScrollViewDelegate>
{
    PTRXConstants *_Constants;
    BOOL _logoutFinished;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    
    //[self addActionsToButtons];
    self.scrollView.delegate = self;
    [self addButtons];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initScrollViewContentSize];
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initScrollViewContentSize
{
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height * 1.05f);
    self.scrollView.showsVerticalScrollIndicator = NO;
}

- (void)addButtons
{
    UIColor *colorForColumn1 = [UIColor colorWithRed:252/255.0f green:98/255.0f blue:117/255.0f alpha:1.0f];
    UIColor *colorForColumn2 = [UIColor colorWithRed:67/255.0f green:154/255.0f blue:252/255.0f alpha:1.0f];
    UIColor *colorForColumn3 = [UIColor colorWithRed:139/255.0f green:152/255.0f blue:252/255.0f alpha:1.0f];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"300x60"]];
    imageView.frame = CGRectMake(9, 20, 300, 60);
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 90.0f, 93.0f, 144.0f)];
    [button1 setBackgroundColor:colorForColumn1];
    button1.tag = 2001;
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 244.0f, 93.0f, 144.0f)];
    [button2 setBackgroundColor:colorForColumn1];
    button1.tag = 2002;
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 398.0f, 93.0f, 72.0f)];
    [button3 setBackgroundColor:colorForColumn1];
    button1.tag = 2003;
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(113.0f, 90.0f, 93.0f, 72.0f)];
    [button4 setBackgroundColor:colorForColumn2];
    button1.tag = 2004;
    
    UIButton *button5 = [[UIButton alloc] initWithFrame:CGRectMake(113.0f, 172.0f, 93.0f, 144.0f)];
    [button5 setBackgroundColor:colorForColumn2];
    button1.tag = 2005;
    
    UIButton *button6 = [[UIButton alloc] initWithFrame:CGRectMake(113.0f, 326.0f, 93.0f, 144.0f)];
    [button6 setBackgroundColor:colorForColumn2];
    button1.tag = 2006;
    
    UIButton *button7 = [[UIButton alloc] initWithFrame:CGRectMake(216.0f, 90.0f, 93.0f, 144.0f)];
    [button7 setBackgroundColor:colorForColumn3];
    button1.tag = 2007;
    
    UIButton *button8 = [[UIButton alloc] initWithFrame:CGRectMake(216.0f, 244.0f, 93.0f, 72.0f)];
    [button8 setBackgroundColor:colorForColumn3];
    button1.tag = 2008;
    
    UIButton *button9 = [[UIButton alloc] initWithFrame:CGRectMake(216.0f, 326.0f, 93.0f, 144.0f)];
    [button9 setBackgroundColor:colorForColumn3];
    button1.tag = 2009;
    
    [self.scrollView addSubview:imageView];
    [self.scrollView addSubview:button1];
    [self.scrollView addSubview:button2];
    [self.scrollView addSubview:button3];
    [self.scrollView addSubview:button4];
    [self.scrollView addSubview:button5];
    [self.scrollView addSubview:button6];
    [self.scrollView addSubview:button7];
    [self.scrollView addSubview:button8];
    [self.scrollView addSubview:button9];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    self.tabBarController.tabBar.hidden = NO;
}

@end
