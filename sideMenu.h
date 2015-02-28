//
//  sideMenu.h
//  Alltech
//
//  Created by Tejuino developers on 19/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sideMenu : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *camaraImg;
@property (weak, nonatomic) IBOutlet UIImageView *idiomaImg;
@property (weak, nonatomic) IBOutlet UIImageView *logoutImg;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *separatorImg;


@end
