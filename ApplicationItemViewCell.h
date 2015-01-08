//
//  ApplicationItemViewCell.h
//  SySales
//
//  Created by Wang Long on 1/8/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationItemViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (copy, nonatomic) NSString *nameString;
@property (copy, nonatomic) NSString *imageURL;

@end
