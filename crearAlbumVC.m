//
//  crearAlbumVC.m
//  Alltech
//
//  Created by Tejuino developers on 23/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "crearAlbumVC.h"
#import "previewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface crearAlbumVC ()

@end

@implementation crearAlbumVC{
    NSArray *fotos;
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;

    
}



-(void)viewDidLoad{
    [super viewDidLoad];
    
    //fotos =@[@"ejemplo1",@"ejemplo2",@"ejemplo3",@"ejemplo4",@"ejemplo5",@"ejemplo6",@"ejemplo7"];
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    //ponemos fondo al View y a la barra de navegacion
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    self.crearAlbumNav.barTintColor = [UIColor orangeColor];
    
    //agregar view para poner color de fondo al status bar
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 22)];
    statusBarView.backgroundColor  =  [UIColor orangeColor];
    [self.view addSubview:statusBarView];

    

}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CustomHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        
        reusableview = headerView;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 129, headerView.bounds.size.width, 1)];
        lineView.backgroundColor = [UIColor orangeColor];
        [headerView addSubview:lineView];
        headerView.descripcionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, 60)];
        headerView.tituloAlbumLabel.text = @"Esto es una prueba";
        headerView.descripcionLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consequat erat massa, non dapibus turpis congue ut. Integer lorem libero, scelerisque et hendrerit ut, porta vel elit. Sed non bibendum felis. Etiam id vulputate sapien, id lacinia nisl. Aenean a purus nec massa faucibus interdum in sit amet leo. Sed sed enim odio. Praesent sollicitudin, tellus in ultricies vulputate, nisi tellus dictum sapien, eu ullamcorper tellus est eu quam.";
        //headerView.descripcionLabel.frame = ;
        
        
    }
    
    
    return reusableview;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //return [fotos count];
    return [self.selectedImages count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    previewCell *cell = (previewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"previewCell" forIndexPath:indexPath];
    
    
    ALAsset *asset = self.selectedImages[indexPath.row];
    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    cell.backgroundColor = [UIColor clearColor];

    //cell.previewImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",fotos[indexPath.row]]];
    cell.previewImg.image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    cell.previewImg.clipsToBounds = YES;
    return cell;
    
    
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (screenWidth == 768) {
        return UIEdgeInsetsMake(10, 60, 0, 60); // top, left, bottom, right
    }
    return UIEdgeInsetsMake(10, 0, 0, 0);
    
}


- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1 ;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
 
    
    
}


-(IBAction)guardarButton:(id)sender{
    
    UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Su album fue enviado a revisíon" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alerta show];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)returnButton:(id)sender{

   [self.navigationController popViewControllerAnimated:TRUE];

}

@end







#pragma mark - nuevoAlbum

@implementation nuevoAlbum

-(void)viewDidLoad{
    
    
    //ponemos fondo al View y a la barra de navegacion
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    self.nuevoAlbumNav.barTintColor = [UIColor orangeColor];
    
    //agregar view para poner color de fondo al status bar
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
    statusBarView.backgroundColor  =  [UIColor orangeColor];
    [self.view addSubview:statusBarView];


}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.tituloTextField resignFirstResponder];
    [self.descripcionTextField resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.tituloTextField resignFirstResponder];
    [self.descripcionTextField resignFirstResponder];
    return YES;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

- (IBAction)returnButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end


@implementation CustomHeaderView

-(void)viewDidLoad{


}

@end




