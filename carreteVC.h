//
//  carreteVC.h
//  Alltech
//
//  Created by Tejuino developers on 18/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "ViewController.h"


@interface carreteVC : ViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UINavigationBar *carreteNav;


- (IBAction)camaraButton:(id)sender;

- (IBAction)returnButton:(id)sender;

- (IBAction)usarButton:(id)sender;

@end
