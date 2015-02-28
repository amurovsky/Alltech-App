//
//  sideMenuVC.m
//  Alltech
//
//  Created by Tejuino developers on 05/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "sideMenuVC.h"

@interface sideMenuVC ()

@end

@implementation sideMenuVC{

    NSArray * imageSideMenu;
    
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat porcentaje;
    CGFloat resultadoPorcentaje;

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadAssets];
    [self loadAssets];
    // Do any additional setup after loading the view.
    
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    
    porcentaje = 25;
    
    resultadoPorcentaje = (porcentaje * screenWidth) / 100;
    
    
    imageSideMenu = @[@"sideMenu1",@"sideMenu2",@"sideMenu3"];
    
    //poner fondo al view
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondoSideMenu"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{



    return [imageSideMenu count];

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    
    
    UIImageView * imgView;
    
    // separador de celadas
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatorSideMenu"]];
    
    
    // ipad
    if (screenWidth == 768 && screenHeight == 1024) {
        
        imageView.frame = CGRectMake(75, 115, 90, 2);
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(90, 25, 60, 60)];
        
        // iphone 5, 5c, 5s, touch 5
    }
    // Iphone 6
    else if (screenWidth == 375 && screenHeight == 667) {
        
        imageView.frame = CGRectMake(75, 72, 60, 1);
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(85, 15, 40, 40)];
        
      // iphone 5, 5c, 5s, touch 5
    }else if (screenWidth == 320 && screenHeight == 568){
        
        imageView.frame = CGRectMake(20, 62, 55, 1);
        imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(25, 15, 40, 40)];
    }
    
    CGSize itemSize = CGSizeMake(40, 40);
    imgView.image = [UIImage imageNamed:[imageSideMenu objectAtIndex:indexPath.row] ];
    imgView.contentMode = UIViewContentModeCenter;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [cell addSubview:imgView];
    
    
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [cell.contentView addSubview:imageView];
    
    
    // cambiamos el color de la celda a transparente
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Redimension de celdas respecto al tamaño del dispositivo
    
    // ipad 2 , ipad mini, ipad retina
    if (screenWidth == 768 && screenHeight == 1024) {
        
        return 115;
    }
    
    // iphone 6 plus
    if (screenWidth == 414 && screenHeight == 736) {
        
        return 84;
        
    }
    
    // iphone 6
    if (screenWidth == 375 && screenHeight == 667) {
        
        return 74;
    }
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){
        
        return 64;
        
    }
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
        
        return 54;
        
    }
    
    return 54;
    
}




//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.row == 0) {
//        
////        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
////        picker.delegate = self;
////        
////        
////        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
////        {
////            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
////            [self presentViewController:picker animated:YES completion:nil];
////        }else{
////        
////            NSLog(@"fuck it.! no hay camara...");
////        
////        }
//        
//        
//        
//        
//        NSLog(@"entro a didSelectRowAtIndexPath.!");
//        
//        // Browser
//        NSMutableArray *photos = [[NSMutableArray alloc] init];
//        NSMutableArray *thumbs = [[NSMutableArray alloc] init];
//        //MWPhoto *photo;
//        BOOL displayActionButton = NO;
//        BOOL displaySelectionButtons = YES;
//        BOOL displayNavArrows = NO;
//        BOOL enableGrid = YES;
//        BOOL startOnGrid = YES;
//        
//        @synchronized(_assets) {
//            NSMutableArray *copy = [_assets copy];
//            for (ALAsset *asset in copy) {
//                [photos addObject:[MWPhoto photoWithURL:asset.defaultRepresentation.url]];
//                [thumbs addObject:[MWPhoto photoWithImage:[UIImage imageWithCGImage:asset.thumbnail]]];
//            }
//        }
//        self.photos = photos;
//        self.thumbs = thumbs;
//        
//        // Create browser
//        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
//        browser.displayActionButton = displayActionButton;
//        browser.displayNavArrows = displayNavArrows;
//        browser.displaySelectionButtons = displaySelectionButtons;
//        browser.alwaysShowControls = displaySelectionButtons;
//        browser.zoomPhotosToFill = YES;
//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//        browser.wantsFullScreenLayout = YES;
//#endif
//        browser.enableGrid = enableGrid;
//        browser.startOnGrid = startOnGrid;
//        browser.enableSwipeToDismiss = YES;
//        [browser setCurrentPhotoIndex:0];
//        
//        // Reset selections
//        if (displaySelectionButtons) {
//            _selections = [NSMutableArray new];
//            for (int i = 0; i < photos.count; i++) {
//                [_selections addObject:[NSNumber numberWithBool:NO]];
//            }
//        }
//        
//        // Show
//        
//        // Push
//        //[self.navigationController pushViewController:browser animated:YES];
//        
//        // Modal
//        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
//        nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:nc animated:YES completion:nil];
//        
//        // Release
//        
//        // Deselect
//        //[self.sideMenuTable deselectRowAtIndexPath:indexPath animated:YES];
//        
//    }else if (indexPath.row == 2) {
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//        
//    }
//
//
//}




#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Load Assets

- (void)loadAssets {
    
    // Initialise
    _assets = [NSMutableArray new];
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    
    // Run in the background as it takes a while to get all assets from the library
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
        NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
        
        // Process assets
        void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result != nil) {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                    NSURL *url = result.defaultRepresentation.url;
                    [_assetLibrary assetForURL:url
                                   resultBlock:^(ALAsset *asset) {
                                       if (asset) {
                                           @synchronized(_assets) {
                                               [_assets addObject:asset];
                                               
                                           }
                                       }
                                   }
                                  failureBlock:^(NSError *error){
                                      NSLog(@"operation was not successfull!");
                                  }];
                    
                }
            }
        };
        
        // Process groups
        void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
            if (group != nil) {
                [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
                [assetGroups addObject:group];
            }
        };
        
        // Process!
        [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                         usingBlock:assetGroupEnumerator
                                       failureBlock:^(NSError *error) {
                                           NSLog(@"There is an error");
                                       }];
        
    });
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
