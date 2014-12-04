//
//  PTRXHomeTabViewController.m
//  SySales
//
//  Created by Wang Long on 12/4/14.
//  Copyright (c) 2014 Wang Long. All rights reserved.
//

#import "PTRXHomeTabViewController.h"
#import "PTRXDetailForHomePageViewController.h"

@interface PTRXHomeTabViewController ()

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
    
    //NSInteger tag = button.tag;
    
    [self performSegueWithIdentifier:@"ToHomeDetail" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIButton *button = (UIButton *)sender;
    PTRXDetailForHomePageViewController *detailVC = (PTRXDetailForHomePageViewController *)segue.destinationViewController;
    NSInteger tag = button.tag;
    
    NSString *urlString;
    
    switch (tag)
    {
        case 2001:
            urlString = @"http://scs3.syslive.cn/mb/customer/customerlist.ds";
            detailVC.urlStringForWebView = urlString;
            break;
            
        default:
            break;
    }
}

- (void)backToHome:(UIStoryboardSegue *)segue
{

}

@end
