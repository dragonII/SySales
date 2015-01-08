//
//  ApplicationItemViewCell.m
//  SySales
//
//  Created by Wang Long on 1/8/15.
//  Copyright (c) 2015 Wang Long. All rights reserved.
//

#import "ApplicationItemViewCell.h"

@interface ItemCellBackgroundView : UIView

@end

@implementation ItemCellBackgroundView

- (void)drawRect:(CGRect)rect
{
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0.0f];
    [[UIColor whiteColor] setStroke];
    UIColor *fillColor = [UIColor whiteColor];
    
    [fillColor setFill];
    [bezierPath stroke];
    [bezierPath fill];
    
    CGContextRestoreGState(aRef);
}

@end

@implementation ApplicationItemViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        ItemCellBackgroundView *bgView = [[ItemCellBackgroundView alloc] init];
        self.backgroundView = bgView;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setNameString:(NSString *)nameString
{
    if(![_nameString isEqualToString:nameString])
    {
        _nameString = nameString;
        _nameLabel.text = _nameString;
    }
}

@end
