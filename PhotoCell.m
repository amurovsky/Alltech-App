//
//  PhotoCell.m
//  Alltech
//
//  Created by Tejuino developers on 18/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@end

@implementation PhotoCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedFrame"]];
        image.frame = self.contentView.frame;
        [self.contentView addSubview:image];
        image.hidden=YES;

    }
    return self;

}

- (void) setAsset:(ALAsset *)asset
{
    // 2
    _asset = asset;
    self.photoImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
    
}

- (void)setSelected:(BOOL)selected {
    //[super setSelected:selected animated:animated];
    [super setSelected:(BOOL)selected];
    
    if (selected == YES) {
        self.selectedFrame.hidden = NO;
    }self.selectedFrame.hidden = YES;
    
    
}



@end
