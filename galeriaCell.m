//
//  galeriaCell.m
//  Alltech
//
//  Created by Tejuino developers on 19/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "galeriaCell.h"

@implementation galeriaCell

- (void)awakeFromNib {
    // Initialization code
    _portadaAlbum.frame = CGRectMake(0, 0, 20, 20);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    _numerodeFotos.text =@"7";
    

}

@end
