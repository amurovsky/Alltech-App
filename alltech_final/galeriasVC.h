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

- (IBAction)segmentedControl:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UINavigationBar *galeriasNav;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightMenu;

@property (weak, nonatomic) IBOutlet UILabel *nombredelPrograma;

@property (weak, nonatomic) IBOutlet UILabel *nombreProductoyEspecie;

@property (nonatomic, strong) NSString * nombrePrograma;

@property (nonatomic, strong) NSString * nombreEspecie;

@property (nonatomic, strong) NSString * nombreProducto;

@property (nonatomic, strong) NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)returnButton:(id)sender;



@end






