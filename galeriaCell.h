//
//  galeriaCell.h
//  Alltech
//
//  Created by Tejuino developers on 19/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface galeriaCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *portadaAlbum;
@property (weak, nonatomic) IBOutlet UILabel *numerodeFotos;
@property (weak, nonatomic) IBOutlet UILabel *nombredelAlbum;
@property (weak, nonatomic) IBOutlet UITextView *descripciondelAlbum;
@property (weak, nonatomic) IBOutlet UILabel *fechadelAlbum;
@property (weak, nonatomic) IBOutlet UIView *marcoAlbum;

@end
