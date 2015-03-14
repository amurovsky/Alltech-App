//
//  crearAlbumVC.h
//  Alltech
//
//  Created by Tejuino developers on 23/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface crearAlbumVC : UIViewController <UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property(nonatomic, weak) IBOutlet UINavigationBar *crearAlbumNav;
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *selectedImages;
@property (strong, nonatomic) NSString *getTitulo;
@property (strong, nonatomic) NSString *getDescripcion;
@property (strong, nonatomic) NSString *getPrograma;
@property (strong, nonatomic) NSString *getProducto;
@property (strong, nonatomic) NSString *getEspecie;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarAlbum;

- (IBAction)returnButton:(id)sender;
- (IBAction)enviarButton:(id)sender;
- (IBAction)guardarButton:(id)sender;


@end


@interface CustomHeaderCell : UITableViewCell



@end


@interface CustomHeaderView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UILabel *tituloAlbumLabel;
@property (strong, nonatomic) IBOutlet UILabel *descripcionLabel;



@end


#import "canvas.h"

@interface nuevoAlbum : UIViewController <UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,weak) IBOutlet UINavigationBar * nuevoAlbumNav;
@property (weak, nonatomic) IBOutlet UITextField *programaPV;
@property (weak, nonatomic) IBOutlet UITextField *productoPV;
@property (weak, nonatomic) IBOutlet UITextField *especiePV;
@property(nonatomic, strong) NSMutableArray *selectedImages;
@property (weak, nonatomic) IBOutlet UITextField *tituloTextField;
@property (weak, nonatomic) IBOutlet UITextField *descripcionTextField;
@property (strong, nonatomic) NSArray *tituloDescripcionAlbum;

@property (weak, nonatomic) IBOutlet CSAnimationView *conteiner;

- (IBAction)returnButton:(id)sender;
- (IBAction)crearButton:(id)sender;

@end