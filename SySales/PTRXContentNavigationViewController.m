//
//  PTRXContentNavigationViewController.m
//  SyslivePM
//
//  Created by Wang Long on 11/20/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXContentNavigationViewController.h"
#import "PTRXMainViewController.h"
#import "PTRXContentTabsViewController.h"
#import "PTRXParameterFromContentNavigationToTabs.h"

@interface PTRXContentNavigationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;

@end

@implementation PTRXContentNavigationViewController

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

    self.mainController.loginController = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    self.view.backgroundColor = [UIColor whiteColor];
    //[self initContentNavigationButtons];
    [self addActionsToButtons];
}

/*
 Buttons Layout chart
 +-------+----+----+
 |       |    |    |
 |   B0  | B3 | B6 |
 |-------+----+----+
 |       |    |    |
 |   B1  | B4 | B7 |
 |       |    |    |
 |-------+----+----+
 |       |    |    |
 |       |    |    |
 |   B2  | B5 | B8 |
 |       |    |    |
 |       |    |    |
 +-------+----+----+
 */

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
    
    if(self.mainController.contentTabsController == nil)
    {
        self.mainController.contentTabsController = [self.mainController.storyboard instantiateViewControllerWithIdentifier:@"ContentTabs"];
        self.mainController.contentTabsController.mainController = self.mainController;
    }
    
    NSInteger tag = button.tag;
    PTRXParameterFromContentNavigationToTabs *parameter = [PTRXParameterFromContentNavigationToTabs sharedParameter];
    switch (tag)
    {
        // 客户
        case 2001:
            parameter.barButtonOneName = NSLocalizedString(@"Clients", @"Clients");
            parameter.barButtonTwoName = NSLocalizedString(@"Contacts", @"Contacts");
            parameter.urlStringForWebView = @"http://scs3.syslive.cn/mb/customer/customerlist.ds";
            break;
            
        default:
            break;
    }
    
    [self.view removeFromSuperview];
    [self.mainController.view insertSubview:self.mainController.contentTabsController.view atIndex:0];
}


- (void)initContentNavigationButtons
{
    CGFloat topMargin = 20.0f;
    //CGFloat bottomMargin = 20.0f;
    CGFloat margin = 10.0f;
    //CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    //CGFloat itemWidth = 70.0f;
    CGFloat itemWidth = 56.0f;
    //CGFloat itemHeight = 100.0f;
    CGFloat itemHeight = 80.0f;
    if(height > 480)
    {
        //itemHeight = 122.0f;
        itemHeight = 97.0f;
    }
    
    //NSInteger totalRows = 3;
    //NSInteger totalCols = 3;
    NSInteger totalButs = 9;
    
    
    //NSInteger rowIndex = 0;
    //NSInteger colIndex = 0;
    
    CGFloat x, y, w, h;
    
    for(int butIndex = 0; butIndex < totalButs; butIndex++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 2000 + butIndex;
        
        button.backgroundColor = [UIColor whiteColor];
        //[button setTitle:[NSString stringWithFormat:@"%d", butIndex] forState:UIControlStateNormal];
        switch(butIndex)
        {
            case 0:
                x = margin;
                y = topMargin + margin;
                w = itemWidth * 2;
                h = itemHeight;
                [button setTitle:NSLocalizedString(@"Clients", @"Entry name for clients") forState:UIControlStateNormal];
                [button addTarget:self action:@selector(moveToClientsTabsController:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                x = margin;
                y = topMargin + margin * 2 + itemHeight;
                w = itemWidth * 2;
                h = itemHeight * 2;
                [button setTitle:NSLocalizedString(@"Projects", @"Entry name for projects") forState:UIControlStateNormal];
                break;
            case 2:
                x = margin;
                y = topMargin + margin * 3 + itemHeight * 3;
                w = itemWidth * 2;
                h = itemHeight * 2;
                [button setTitle:NSLocalizedString(@"Team", @"Entry name for team") forState:UIControlStateNormal];
                break;
            case 3:
                x = itemWidth * 2 + margin * 2;
                y = topMargin + margin;
                w = itemWidth * 1.5f;
                h = itemHeight;
                [button setTitle:NSLocalizedString(@"Message", @"Entry name for message") forState:UIControlStateNormal];
                break;
            case 4:
                x = itemWidth * 2 + margin * 2;
                y = topMargin + margin * 2 + itemHeight;
                w = itemWidth * 1.5f;
                h = itemHeight * 2;
                [button setTitle:NSLocalizedString(@"Syslive Logo", @"Logo image placeholder") forState:UIControlStateNormal];
                break;
            case 5:
                x = itemWidth * 2 + margin * 2;
                y = topMargin + margin * 3 + itemHeight * 3;
                w = itemWidth * 1.5f;
                h = itemHeight * 2;
                [button setTitle:NSLocalizedString(@"Settings", @"Entry name for my settings") forState:UIControlStateNormal];
                break;
            case 6:
                x = itemWidth * 3.5 + margin * 3;
                y = topMargin + margin;
                w = itemWidth * 1.5f;
                h = itemHeight;
                [button setTitle:NSLocalizedString(@"Chance", @"Entry name for commercial chance") forState:UIControlStateNormal];
                break;
            case 7:
                x = itemWidth * 3.5 + margin * 3;
                y = topMargin + margin * 2 + itemHeight;
                w = itemWidth * 1.5f;
                h = itemHeight * 2;
                [button setTitle:[NSString stringWithFormat:@"%d", butIndex] forState:UIControlStateNormal];
                break;
            case 8:
                x = itemWidth * 3.5 + margin * 3;
                y = topMargin + margin * 3 + itemHeight * 3;
                w = itemWidth * 1.5f;
                h = itemHeight * 2;
                [button setTitle:[NSString stringWithFormat:@"%d", butIndex] forState:UIControlStateNormal];
                break;
            
        }
        button.frame = CGRectMake(x, y, w, h);
        //NSLog(@"Button %d: %f, %f, %f, %f", butIndex, x, y, w, h);
        [self.view addSubview:button];
    }
}

- (IBAction)moveToClientsTabsController_new:(id)sender
{
    //通过sender（也就是button）的tag值来判断点击的是什么按钮，同时根据这个值进行webView中load的URL值的判断
    //可以将所有的URL值hardcode在代码里，或者以后可以通过webservice的方式从服务器获得，目前使用hardcode方式
}

- (IBAction)moveToClientsTabsController:(id)sender
{
    
    NSLog(@"Clients button pressed");
    
    if(self.mainController.contentTabsController == nil)
    {
        self.mainController.contentTabsController = [self.mainController.storyboard instantiateViewControllerWithIdentifier:@"ContentTabs"];
        self.mainController.contentTabsController.mainController = self.mainController;
    }
    [self.view removeFromSuperview];
    [self.mainController.view insertSubview:self.mainController.contentTabsController.view atIndex:0];
    
    /*
    if(self.mainController.clientTabsController == nil)
    {
        self.mainController.clientTabsController = [self.mainController.storyboard instantiateViewControllerWithIdentifier:@"ClientsTabs"];
        self.mainController.clientTabsController.mainController = self.mainController;
    }
    [self.view removeFromSuperview];
    [self.mainController.view insertSubview:self.mainController.clientTabsController.view atIndex:0];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"dealloc %@", self);
}

@end
