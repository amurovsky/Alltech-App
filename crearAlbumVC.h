//
//  crearAlbumVC.h
//  Alltech
//
//  Created by Tejuino developers on 23/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface crearAlbumVC : UIViewController <UICollectionViewDelegateFlowLayout,UICollisionBehaviorDelegate,UICollectionViewDataSource>

@property(nonatomic, weak) IBOutlet UINavigationBar *crearAlbumNav;
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) IBOutlet UIImageView * previewImg;
@property(nonatomic, strong) NSMutableArray *selectedImages;
- (IBAction)returnButton:(id)sender;


- (IBAction)guardarButton:(id)sender;


@end


@interface CustomHeaderCell : UITableViewCell



@end


@interface CustomHeaderView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UILabel *tituloAlbumLabel;

@property (strong, nonatomic) IBOutlet UILabel *descripcionLabel;

@end



@interface nuevoAlbum : UIViewController <UITextFieldDelegate>

@property (nonatomic,weak) IBOutlet UINavigationBar * nuevoAlbumNav;
@property (weak, nonatomic) IBOutlet UITextField *tituloTextField;
@property (weak, nonatomic) IBOutlet UITextField *descripcionTextField;
@property (strong, nonatomic) NSArray *tituloDescripcionAlbum;


- (IBAction)returnButton:(id)sender;

@end