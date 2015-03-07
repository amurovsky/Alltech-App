//
//  galeriasVC.m
//  Alltech
//
//  Created by Tejuino developers on 09/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "galeriasVC.h"
#import "SWRevealViewController.h"
#import "galeriaCell.h"

@interface galeriasVC ()


@end

@implementation galeriasVC{

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
    // Do any additional setup after loading the view.
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    if (screenWidth ==768) {
        porcentaje = 15;
    }else porcentaje = 25;
    
    
    resultadoPorcentaje = (porcentaje * screenWidth) / 100;
    
    //Cambiar Color del Background del View.
    self.view.backgroundColor = [UIColor orangeColor];
    
    //Quitar la sobra de la barra de navegacion
    [self.galeriasNav setBackgroundImage:[[UIImage alloc] init]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.galeriasNav.shadowImage = [[UIImage alloc] init];
    
    

    
    //Slide-out right Menu
    
    SWRevealViewController * revealViewController = self.revealViewController;
    if (revealViewController) {
        
        
        [self.rightMenu setTarget: self.revealViewController];
        [self.rightMenu setAction: @selector( rightRevealToggle:)];
        revealViewController.rightViewRevealWidth= resultadoPorcentaje;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 6;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    galeriaCell *cell = (galeriaCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"galeriaCell" forIndexPath:indexPath];
    
    

    cell.backgroundColor = [UIColor clearColor];
    

    return cell;
    



}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (screenWidth == 768) {
        return UIEdgeInsetsMake(10, 60, 0, 60); // top, left, bottom, right
    }
    return UIEdgeInsetsMake(10, 0, 0, 0);
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSMutableArray *photos = [[NSMutableArray alloc] init];
    MWPhoto *photo;
    
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ejemplo1" ofType:@"png"]]];
    photo.caption = @"Fotografías de Gerardo Torres. \n \n Notar el pelaje del ejemplar al frente, ahí podemos notar mejor la mejora.";
    [photos addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ejemplo2" ofType:@"png"]]];
    photo.caption = @"Fotografías de Gerardo Torres. \n \n Notar el pelaje del ejemplar al frente, ahí podemos notar mejor la mejora";
    [photos addObject:photo];
    //photo = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://global.alltech.com/sites/default/files/styles/flexslider_country/public/images/country/slideshow/2305-What-if-you-could-get-more-milk-ad.gif?itok=l7TuToB0"]];
    photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ejemplo3" ofType:@"png"]]];
    photo.caption = @"Fotografías de Gerardo Torres. \n \n Aquí se muestra como el pelaje cambió favorablemente cabo de 35 días de alimento.";
    [photos addObject:photo];
    photo = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://ag.alltech.com/sites/default/files/styles/flexslider_full/public/Profitability-On-The-Farm.png?itok=HiRCm7v2"]];
    //photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ejemplo4" ofType:@"png"]]];
    photo.caption = @"Fotografías de Gerardo Torres. \n \n Notar el pelaje del ejemplar al frente, ahí podemos notar mejor la mejora.";
    [photos addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ejemplo6" ofType:@"png"]]];
    photo.caption = @"Fotografías de Gerardo Torres. \n \n Notar el pelaje del ejemplar al frente, ahí podemos notar mejor la mejora.";
    [photos addObject:photo];
    photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ejemplo7" ofType:@"png"]]];
    photo.caption = @"Fotografías de Gerardo Torres. \n \n Notar el pelaje del ejemplar al frente, ahí podemos notar mejor la mejora.";
    [photos addObject:photo];
    
    self.photos = photos;
    
    
    // Create browser (must be done each time photo browser is
    // displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser * browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = NO; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = NO; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.enableSwipeToDismiss = NO;
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:0];
    
    //Present
    //[self.navigationController pushViewController:browser animated:YES];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
    
    
    // Deselect
    //[self.collectionView deselectRowAtIndexPath:indexPath animated:YES];

}




-(NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{

    return self.photos.count;;
}


-(id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{

    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;

}


- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//Cambiamos a blanco el color de la status Bar

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (IBAction)returnButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}
@end






