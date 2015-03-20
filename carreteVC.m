//
//  carreteVC.m
//  Alltech
//
//  Created by Tejuino developers on 18/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "carreteVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoCell.h"
#import "crearAlbumVC.h"
#import "selecAlbumTV.h"
#import "AppDelegate.h"
#import "Albums.h"
#import "repositoriodeAlbums.h"


@interface carreteVC ()

@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@end

@interface UIImagePickerController(Nonrotating)
- (BOOL)shouldAutorotate;
@end

@implementation UIImagePickerController(Nonrotating)

- (BOOL)shouldAutorotate
{
    return NO;
}

@end


@implementation carreteVC{

    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
    PhotoCell *cell;
    AppDelegate *appDelegate;
    UIRefreshControl *refreshControl;
    NSString *alertaString;

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedAssets = [NSMutableArray array];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:27/255.0f green:27/255.0f blue:29/255.0f alpha:1.0f]; /*#1b1b1d*/
    self.carreteNav.barTintColor = [UIColor colorWithRed:27/255.0f green:27/255.0f blue:29/255.0f alpha:1.0f]; /*#1b1b1d*/
    self.collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    self.collectionView.allowsMultipleSelection = YES;

    [self loadAssets];
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refershControlAction) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    
    NSString *idioma = appDelegate.userSession.lenguaje;
    if ([idioma isEqual:@"es"]) {
        self.usarButton.title = @"Usar";
        self.cancelarButton.title = @"Cancelar";
        self.seleccionaNavItem.title = @"Selecciona";
        alertaString = @"Selecciona por lo menos una fotografía";
    }else if ([idioma isEqual:@"en"]) {
        self.usarButton.title = @"Use";
        self.cancelarButton.title = @"Close";
        self.seleccionaNavItem.title = @"Choose";
        alertaString = @"Select at least one picture";
    }else if ([idioma isEqual:@"pt"]) {
        self.usarButton.title = @"Uso";
        self.cancelarButton.title = @"desligar";
        self.seleccionaNavItem.title = @"escolher";
        alertaString = @"Escolha pelo menos uma foto";
    }
}


-(void)refershControlAction{
    
    [self loadAssets];
    [refreshControl endRefreshing];

}
-(void)viewDidLayoutSubviews{
    
    
    //    NSInteger section = [_collectionView numberOfSections] - 1 ;
    //    NSInteger item = [_collectionView numberOfItemsInSection:section] - 1 ;
    //    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section] ;
    //    [_collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:(UICollectionViewScrollPositionBottom) animated:NO];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{

    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [self.selectedAssets removeAllObjects];
    
    [self loadAssets];
    //[self.collectionView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - collection view data source

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    ALAsset *asset = self.assets[indexPath.row];
    cell.asset = asset;
    cell.backgroundColor = [UIColor whiteColor];
    if (cell.selected) {
        cell.selectedFrame.hidden = NO;
    }
    else
    {
        cell.selectedFrame.hidden = YES;
    }
    
    return cell;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //Medidas segun Device
    //ipad
    if (screenWidth == 768) {
        return CGSizeMake(122, 122);
    }
    //iphone 6 plus
    else if(screenWidth == 414){
        return CGSizeMake(122, 122);
    }
    //iphone 6
    else if(screenWidth == 375){
        return CGSizeMake(122, 122);
    }
    //iphone 5 y 4
    return CGSizeMake(70, 70);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (screenWidth == 320) {
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UIImageView *selected =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedFrame"]];
    //    UICollectionViewCell *celda=[self.collectionView cellForItemAtIndexPath:indexPath];
    //    [celda addSubview:selected];
    
    
    
    
    ALAsset *asset = self.assets[indexPath.row];
//    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
//    UIImage *image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    // Do something with the image
    
    
    
    [_selectedAssets addObject:asset];
    NSLog(@"este es el array en Selected: %@",_selectedAssets);
    NSLog(@"este es el index en Selected: %@",indexPath);
    NSLog(@"esta es la ruta de la imagen seleccionada: %@",asset.defaultRepresentation.url);
    UICollectionViewCell *celda = [collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *selectedImg = [[celda.contentView subviews] lastObject];
    selectedImg.hidden=NO;
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ALAsset *asset = self.assets[indexPath.row];
//    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
//    UIImage *image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    // Do something with the image
    
    
    // Add the selected item into the array
    [_selectedAssets removeObject:asset];
    NSLog(@"este es el array en Deselected: %@",_selectedAssets);
    NSLog(@"este es el index en Deselected: %@",indexPath);
    UICollectionViewCell *celda = [collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *selectedImg = [[celda.contentView subviews] lastObject];
    selectedImg.hidden=YES;
    
}




- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - image picker delegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = (UIImage *) [info objectForKey:
                                  UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        // Do something with the image
        
 
    }];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

}


+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}


-(void)loadAssets {
    
    _assets = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    // 1
    ALAssetsLibrary *assetsLibrary = [carreteVC defaultAssetsLibrary];
    // 2
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        //[group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop){
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
            {
                // 3
                [tmpAssets addObject:result];
            }
        }];
        
        // 4
        //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
        //self.assets = [tmpAssets sortedArrayUsingDescriptors:@[sort]];
        self.assets = tmpAssets;
        
        // 5
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];
    
    
}





- (IBAction)camaraButton:(id)sender {
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    picker.modalPresentationStyle = UIModalPresentationFullScreen ;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else{
        
        NSLog(@"fuck it.! no hay camara...");
    }

    
    
}



//- (void)loadAssets {
//
//    // Initialise
//    _assets = [NSMutableArray new];
//    _assetLibrary = [[ALAssetsLibrary alloc] init];
//
//    // Run in the background as it takes a while to get all assets from the library
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
//        NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
//
//        // Process assets
//        void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
//            if (result != nil) {
//                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
//                    [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
//                    NSURL *url = result.defaultRepresentation.url;
//                    [_assetLibrary assetForURL:url
//                                   resultBlock:^(ALAsset *asset) {
//                                       if (asset) {
//                                           @synchronized(_assets) {
//                                               [_assets addObject:asset];
//
//                                           }
//                                       }
//                                   }
//                                  failureBlock:^(NSError *error){
//                                      NSLog(@"operation was not successfull!");
//                                  }];
//
//                }
//            }
//        };
//
//        // Process groups
//        void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
//            if (group != nil) {
//                [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
//                [assetGroups addObject:group];
//            }
//        };
//
//        // Process!
//        [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
//                                         usingBlock:assetGroupEnumerator
//                                       failureBlock:^(NSError *error) {
//                                           NSLog(@"There is an error");
//                                       }];
//
//    });
//
//
//}


#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    if ([segue.identifier isEqualToString:@"mostrarFoto"]) {
//        selecAlbumTV * selecAlbum = segue.destinationViewController;
//        [self.navigationController pushViewController:selecAlbum animated:YES];
//
//    }
//}



- (IBAction)usarButton:(id)sender {

    if ([_selectedAssets count] == 0) {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"" message:alertaString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
    }else{
        crearAlbumVC *crear =  [self.storyboard instantiateViewControllerWithIdentifier:@"crearAlbumVC"];
        crear.selectedImages = _selectedAssets;
        NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
        for (int i=0; i < [_selectedAssets count]; i++) {
            ALAsset *asset = self.selectedAssets[i];
            ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
            UIImage *image = [UIImage imageWithCGImage:[defaultRep fullResolutionImage] scale:[defaultRep scale] orientation:0];
            [tmpArray addObject:image];
        }
        appDelegate.userSession.selectedImages = tmpArray;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

- (IBAction)cancelarButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
