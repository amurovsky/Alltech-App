//
//  selecAlbumTV.h
//  Alltech
//
//  Created by Tejuino developers on 20/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selecAlbumTV : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *selectAlbumNav;

@property (weak, nonatomic) IBOutlet UITableView *selectAlbumTable;

@property (weak, nonatomic) IBOutlet UINavigationItem *misAlbumsNavItem;

- (IBAction)returnButton:(id)sender;

@end
