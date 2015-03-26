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
#import "AppDelegate.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "productosVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "loginVC.h"

@interface galeriasVC ()


@end

@implementation galeriasVC{

    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat porcentaje;
    CGFloat resultadoPorcentaje;
    NSMutableArray *albums;
    NSMutableArray *imgAlbums;
    NSMutableArray *descAlbums;
    NSMutableArray *albumID;
    NSMutableArray *fechaPublicacion;
    NSMutableArray *photosURL;
    NSMutableArray *numFotos;
    AppDelegate *appDelegate;
    BOOL misAlbums;
    NSMutableArray * galeriasTags;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    misAlbums =NO;
    albums = [[NSMutableArray alloc]init];
    imgAlbums = [[NSMutableArray alloc]init];
    descAlbums = [[NSMutableArray alloc]init];
    albumID = [[NSMutableArray alloc]init];
    fechaPublicacion = [[NSMutableArray alloc]init];
    numFotos = [[NSMutableArray alloc]init];

    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self loadRequest];
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
    
    
    //cambiar texto de las etiquetas de la barra de navegacion (Programa, Producto, Especie)
    self.nombredelPrograma.text = self.nombrePrograma;
    self.nombredelPrograma.adjustsFontSizeToFitWidth = YES;
    self.nombreProductoyEspecie.text = [NSString stringWithFormat:@"%@ - %@",self.nombreProducto,self.nombreEspecie];
    

    NSString *idioma = appDelegate.userSession.lenguaje;
    if ([idioma isEqual:@"es"]) {
        [self.segmentedControl setTitle:@"Todas" forSegmentAtIndex:0];
        [self.segmentedControl setTitle:@"Mis Álbums" forSegmentAtIndex:1];
    }else if ([idioma isEqual:@"en"]) {
        [self.segmentedControl setTitle:@"All" forSegmentAtIndex:0];
        [self.segmentedControl setTitle:@"My Albums" forSegmentAtIndex:1];
    }else if ([idioma isEqual:@"pt"]) {
        [self.segmentedControl setTitle:@"Todos" forSegmentAtIndex:0];
        [self.segmentedControl setTitle:@"Meus álbuns" forSegmentAtIndex:1];
    }
    
    //Slide-out right Menu
    
    SWRevealViewController * revealViewController = self.revealViewController;
    if (revealViewController) {
        
        
        [self.rightMenu setTarget: self.revealViewController];
        [self.rightMenu setAction: @selector( rightRevealToggle:)];
        revealViewController.rightViewRevealWidth= resultadoPorcentaje;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }


}

-(void)loadRequest{

        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"sessid"    : appDelegate.userSession.sesionID,
                                 @"id_program": appDelegate.userSession.programaID,
                                 @"id_product": appDelegate.userSession.productoID,
                                 @"id_animal_type": appDelegate.userSession.especieID,
                                 @"opt"       : @"get_galleries"
                                 };
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"RESPUESTA: %@",responseObject);
        if ([[responseObject objectForKey:@"error"] isEqualToString:@"session_expired"]) {
            loginVC *login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
            [appDelegate.userSession.settings setBool:NO forKey:@"logged"];
            UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Session Expired" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alerta show];
            [self presentViewController:login animated:YES completion:nil];
        }

        [_activityIndicator startAnimating];
        for(NSDictionary *tempDic in [responseObject objectForKey:@"galleries"])
        {
            if (misAlbums == YES) {
                if ([[tempDic objectForKey:@"owner"]  isEqual: appDelegate.userSession.userID]) {
                    [albums addObject:[NSString stringWithFormat:@"Álbum: %@",[tempDic objectForKey:@"title"]]];
                    [imgAlbums addObject:[tempDic objectForKey:@"image"]];
                    [descAlbums addObject:[tempDic objectForKey:@"description"]];
                    [albumID addObject:[tempDic objectForKey:@"id"]];
                    [fechaPublicacion addObject:[tempDic objectForKey:@"published_at"]];
                    [numFotos addObject:[tempDic objectForKey:@"num_images"]];
                }
                    
            }else{
                
                [albums addObject:[NSString stringWithFormat:@"Álbum: %@",[tempDic objectForKey:@"title"]]];
                [imgAlbums addObject:[tempDic objectForKey:@"image"]];
                [descAlbums addObject:[tempDic objectForKey:@"description"]];
                [albumID addObject:[tempDic objectForKey:@"id"]];
                [fechaPublicacion addObject:[tempDic objectForKey:@"published_at"]];
                [numFotos addObject:[tempDic objectForKey:@"num_images"]];
                
            }
            
            
        }[self.collectionView reloadData];
        // NSLog(@"JSON: %@",responseObject);
        [_activityIndicator stopAnimating];
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
              
          }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [albums count];

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    galeriaCell *cell = (galeriaCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"galeriaCell" forIndexPath:indexPath];
    
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithString:[NSString stringWithFormat:@"%@",[albums objectAtIndex:indexPath.row]]];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(0, 6)];
    
    [cell.nombredelAlbum setAttributedText: text];
    //cell.nombredelAlbum.text = [albums objectAtIndex:indexPath.row];
    //cell.portadaAlbum.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imgAlbums objectAtIndex:indexPath.row]]]];
    [cell.portadaAlbum sd_setImageWithURL:[imgAlbums objectAtIndex:indexPath.row]
               placeholderImage:[UIImage imageNamed:@"photoGalerias.jpg"]];
    //cell.portadaAlbum.image = [imgAlbums objectAtIndex:indexPath.row];
    cell.portadaAlbum.clipsToBounds = YES;
    cell.descripciondelAlbum.text = [descAlbums objectAtIndex:indexPath.row];
    cell.numerodeFotos.text = [NSString stringWithFormat:@"%@",[numFotos objectAtIndex:indexPath.row]];
    
    NSString *str = [NSString stringWithFormat:@"%@",[fechaPublicacion objectAtIndex:indexPath.row]]; /// here this is your date with format yyyy-MM-dd
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: str]; // here you can fetch date from string with define format
    NSLocale *Locale;
    dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([appDelegate.userSession.lenguaje  isEqual: @"es"]) {
        Locale = [[NSLocale alloc]initWithLocaleIdentifier:@"es_ES"];
        [dateFormatter setDateFormat:@"dd' de 'MMMM'  'yyyy'"];// here set format which you want...
    }else if ([appDelegate.userSession.lenguaje isEqual: @"en"]){
        Locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat:@"MMMM' 'dd', 'yyyy'"];
    
    }else if ([appDelegate.userSession.lenguaje isEqual: @"pt"]){
        Locale = [[NSLocale alloc]initWithLocaleIdentifier:@"pt"];
        [dateFormatter setDateFormat:@"dd' 'MMMM' de 'yyyy'"];
    }
    
    
    [dateFormatter setLocale:Locale];
    
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    cell.fechadelAlbum.text = convertedString;
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

    photosURL = [[NSMutableArray alloc] init];
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"sessid"    : appDelegate.userSession.sesionID,
                                 @"id_gallery": [albumID objectAtIndex:indexPath.row],
                                 @"opt"       : @"get_gallery_images"
                                 };
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        if ([[responseObject objectForKey:@"error"] isEqualToString:@"session_expired"]) {
            loginVC *login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
            [appDelegate.userSession.settings setBool:NO forKey:@"logged"];
            UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Session Expired" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alerta show];
            [self presentViewController:login animated:YES completion:nil];
        }

        NSLog(@"RESPUESTA gallery images: %@",responseObject);
        for(NSDictionary *tempDic in [responseObject objectForKey:@"images"])
        {
            //[albums addObject:[tempDic objectForKey:@"title"]];
            [photosURL addObject:[tempDic objectForKey:@"image"]];
            //[descAlbums addObject:[tempDic objectForKey:@"description"]];
            NSLog(@"title es: %@", [tempDic valueForKey:@"title"]);
            NSLog(@"imagen es: %@", [tempDic valueForKey:@"image"]);
            
        }NSLog(@"arreglo de url %@",photosURL);
        [self mostrarGaleria];
        // NSLog(@"JSON: %@",responseObject);
        // NSLog(@"array title: %@",especies);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
              
          }];



}


-(void)mostrarGaleria{

    NSMutableArray *photos = [[NSMutableArray alloc] init];
    MWPhoto *photo;
    for (int i=0; i< photosURL.count; i++) {
        NSLog(@"Url de la imagen: %@ Index: %i",[photosURL objectAtIndex:i],i);
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:[photosURL objectAtIndex:i]]];
        [photos addObject:photo];
    }
    
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
- (IBAction)segmentedControl:(id)sender {
    
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            [albums removeAllObjects];
            [imgAlbums removeAllObjects];
            [descAlbums removeAllObjects];
            [albumID removeAllObjects];
            NSLog(@"Seleccionamos el 1 segmento");
            misAlbums = NO;
            [self loadRequest];
            
            break;
        case 1:
            [albums removeAllObjects];
            [imgAlbums removeAllObjects];
            [descAlbums removeAllObjects];
            [albumID removeAllObjects];
            NSLog(@"Seleccionamos el 2 segmento");
            misAlbums = YES;
            [self loadRequest];
            
            break;
        default:
            break;
    }
}


@end






