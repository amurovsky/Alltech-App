//
//  carreteVC.h
//  Alltech
//
//  Created by Tejuino developers on 18/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface carreteVC : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UINavigationBar *carreteNav;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *usarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelarButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *seleccionaNavItem;


- (IBAction)camaraButton:(id)sender;

- (IBAction)usarButton:(id)sender;

- (IBAction)cancelarButton:(id)sender;

@end
