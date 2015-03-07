//
//  galeriasVC.h
//  Alltech
//
//  Created by Tejuino developers on 09/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface galeriasVC : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MWPhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *galeriasNav;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightMenu;

@property (nonatomic, strong) NSMutableArray *photos;

- (IBAction)returnButton:(id)sender;



@end






