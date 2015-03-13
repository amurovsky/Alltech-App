//
//  previewCell.h
//  Alltech
//
//  Created by Tejuino developers on 25/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface previewCell : UICollectionViewCell <UITextFieldDelegate>

@property(nonatomic, strong) NSArray *fotos;
@property(nonatomic, strong) IBOutlet UIImageView *previewImg;

@end
