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

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    //Cambiamos color del fondo de la view y del collectionview
    self.view.backgroundColor = [UIColor orangeColor];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.allowsMultipleSelection = YES;
    
    
    _selectedAssets = [NSMutableArray array];
    
    
    [self loadAssets];
  
    
}



-(void)viewDidLayoutSubviews{

    
//    NSInteger section = [_collectionView numberOfSections] - 1 ;
//    NSInteger item = [_collectionView numberOfItemsInSection:section] - 1 ;
//    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section] ;
//    [_collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:(UICollectionViewScrollPositionBottom) animated:NO];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self scrollToBottom];
    
    [self loadAssets];
    
    
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
    collectionView.allowsMultipleSelection = YES;
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

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UIImageView *selected =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedFrame"]];
//    UICollectionViewCell *celda=[self.collectionView cellForItemAtIndexPath:indexPath];
//    [celda addSubview:selected];
    
   

    
    ALAsset *asset = self.assets[indexPath.row];
    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    UIImage *image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    // Do something with the image
    


    [_selectedAssets addObject:asset];
    NSLog(@"este es el array en Selected: %@",_selectedAssets);
    NSLog(@"este es el index en Selected: %@",indexPath);
    //collectionView.allowsMultipleSelection = YES;
//    UICollectionViewCell *celda = [collectionView cellForItemAtIndexPath:indexPath];
//    UIImageView *selectedImg = [[celda.contentView subviews] lastObject];
//    selectedImg.hidden=NO;
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

    ALAsset *asset = self.assets[indexPath.row];
    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    UIImage *image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    // Do something with the image
    
    
    // Add the selected item into the array
    [_selectedAssets removeObject:asset];
    NSLog(@"este es el array en Deselected: %@",_selectedAssets);
    NSLog(@"este es el index en Deselected: %@",indexPath);
//    UICollectionViewCell *celda = [collectionView cellForItemAtIndexPath:indexPath];
//    UIImageView *selectedImg = [[celda.contentView subviews] lastObject];
//    selectedImg.hidden=YES;

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
    [self.collectionView reloadData];
    

    NSInteger section = [_collectionView numberOfSections] - 1 ;
    NSInteger item = [_collectionView numberOfItemsInSection:section] - 1 ;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section] ;
    [_collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:(UICollectionViewScrollPositionBottom) animated:NO];

    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"mandaFotos"]) {
//        selecAlbumTV * selecAlbum = segue.destinationViewController;
//        [self.navigationController pushViewController:selecAlbum animated:YES];
//
//    }
//}


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
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result)
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
    picker.delegate = self;
    
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }else{
    
            NSLog(@"fuck it.! no hay camara...");
        }


    
//    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//   
//    [self presentViewController:picker animated:YES completion:nil];
    
    
}

- (void) scrollToBottom {
    
  
        _collectionView.contentInset = UIEdgeInsetsZero;
  

        static NSInteger section = 0;
        NSInteger item = [self collectionView:_collectionView numberOfItemsInSection:section] - 1;
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
        [_collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    
   
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



- (IBAction)returnButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)usarButton:(id)sender {
    
//    crearAlbumVC *crearAlbum = [self.storyboard instantiateViewControllerWithIdentifier:@"crearAlbumVC"];
//    crearAlbum.selectedImages=_selectedAssets;
//    crearAlbum.stringdecarrete = @"Esto Fue lo que se le paso al CrearAlbumVC";
//    NSLog(@"veamos el array: %@",_selectedAssets);
    
    selecAlbumTV *selecAlbum =  [self.storyboard instantiateViewControllerWithIdentifier:@"selecAlbumTV"];
    //selecAlbumTV *selecAlbum = [[selecAlbumTV alloc]initWithNibName:@"selecAlbumTV" bundle:nil];
    selecAlbum.selectedImages = _selectedAssets;
    [self.navigationController pushViewController:selecAlbum animated:YES];

    
    
}
@end
