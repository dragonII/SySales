//
//  ApplicationPageViewController.h
//  SySales
//
//  Created by Wang Long on 1/8/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (copy, nonatomic) NSString *urlString;

@end
