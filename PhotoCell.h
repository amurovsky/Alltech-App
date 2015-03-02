//
//  PhotoCell.h
//  Alltech
//
//  Created by Tejuino developers on 18/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoCell : UICollectionViewCell

@property(nonatomic, strong) ALAsset *asset;

@property(nonatomic, strong) IBOutlet UIImageView *photoImageView;

@property(nonatomic, strong) NSMutableArray *selectedAssets;

@property (weak, nonatomic) IBOutlet UIImageView *selectedFrame;


@end


