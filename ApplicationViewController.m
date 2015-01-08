//
//  ApplicationViewController.m
//  SySales
//
//  Created by Wang Long on 1/8/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import "ApplicationViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "ApplicationItemViewCell.h"
#import "ApplicationPageViewController.h"

static int StatusBarHeight = 20;
static int NavigationBarHeight = 44;
static int ToolBarHeight = 49;

static NSString *CellIdentifier = @"ItemViewCellIdentifier";

@interface ApplicationViewController () <CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *itemsCollectionView;
@property (strong, nonatomic) NSArray *appItemList;
@property (nonatomic) NSInteger selectedAppIndex;

@end

@implementation ApplicationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initCollectionView
{
    if(!self.itemsCollectionView)
    {
        CGRect rect = CGRectMake(self.view.bounds.origin.x,
                                 self.view.bounds.origin.y + StatusBarHeight + NavigationBarHeight,
                                 self.view.bounds.size.width,
                                 self.view.bounds.size.height - (StatusBarHeight + NavigationBarHeight + ToolBarHeight));
        
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.minimumColumnSpacing = 12;
        layout.minimumInteritemSpacing = 10;
        
        self.itemsCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        
        self.itemsCollectionView.delegate = self;
        self.itemsCollectionView.dataSource = self;
        
        UIEdgeInsets contentInsets = self.itemsCollectionView.contentInset;
        contentInsets.top = 10.0f;
        contentInsets.bottom = 20.0f;
        //contentInsets.left = 5.0f;
        //contentInsets.right = 5.0f;
        [self.itemsCollectionView setContentInset:contentInsets];
        
        self.itemsCollectionView.showsHorizontalScrollIndicator = NO;
        self.itemsCollectionView.bounces = YES;
        
        self.itemsCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.itemsCollectionView.backgroundColor = [UIColor greenColor];
        //self.itemsCollectionView.alpha = 0.4f;
        
        [self.itemsCollectionView registerClass:[ApplicationItemViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        UINib *nib = [UINib nibWithNibName:@"AppItemCell" bundle:nil];
        [self.itemsCollectionView registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    }
}

- (void)loadDateFromPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AppItems" ofType:@"plist"];
    self.appItemList = [NSArray arrayWithContentsOfFile:path];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self loadDateFromPlist];
    
    [self initCollectionView];
    
    [self.view addSubview:self.itemsCollectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CHTCollectionViewWaterfallLayout *layout = (CHTCollectionViewWaterfallLayout *)collectionView.collectionViewLayout;
    layout.columnCount = 4;
    
    return [self.appItemList count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(72, 82);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ApplicationItemViewCell *cell = (ApplicationItemViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dict = [self.appItemList objectAtIndex:indexPath.row];
    
    cell.nameString = [dict objectForKey:@"name"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ApplicationPageViewController *appPageVC = (ApplicationPageViewController *)segue.destinationViewController;
    NSDictionary *dict = [self.appItemList objectAtIndex:self.selectedAppIndex];
    NSString *url = [dict objectForKey:@"url"];
    appPageVC.urlString = url;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //ApplicationItemViewCell *cell = (ApplicationItemViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    self.selectedAppIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"GotoAppByUrl" sender:self];
}

@end
