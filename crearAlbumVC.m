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
#import <AFNetworking.h>
#import "AppDelegate.h"
#import <MBProgressHUD.h>

@interface crearAlbumVC ()

@end

@implementation crearAlbumVC{
    NSArray *fotos;
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
    previewCell *cell;
    AppDelegate *appDelegate;
    NSString *galeriaID;
    NSInteger tag;

    
}



-(void)viewDidLoad{
    [super viewDidLoad];
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    tag = 0;
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //ponemos fondo al View y a la barra de navegacion
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    self.crearAlbumNav.barTintColor = [UIColor orangeColor];
    
    //agregar view para poner color de fondo al status bar
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 22)];
    statusBarView.backgroundColor  =  [UIColor orangeColor];
    [self.view addSubview:statusBarView];
    
    self.sendFrame.layer.cornerRadius = self.sendFrame.frame.size.width /2;
    self.sendFrame.clipsToBounds = YES;
    self.enviarButton.imageView.tintColor = [UIColor whiteColor];
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CustomHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        
        reusableview = headerView;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 129, headerView.bounds.size.width, 1)];
        lineView.backgroundColor = [UIColor orangeColor];
        [headerView addSubview:lineView];
        headerView.tituloAlbumLabel.text = _getTitulo;
        headerView.descripcionLabel.text = _getDescripcion;

    }
    
    
    return reusableview;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //return [fotos count];
    return [self.selectedImages count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    cell = (previewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"previewCell" forIndexPath:indexPath];
    
    
    ALAsset *asset = self.selectedImages[indexPath.row];
    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    cell.backgroundColor = [UIColor clearColor];
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



-(IBAction)guardarButton:(id)sender{

    AppDelegate *appDelegateContext =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegateContext managedObjectContext];
    NSManagedObject *newAlbum;
    newAlbum = [NSEntityDescription
                insertNewObjectForEntityForName:@"Albums"
                inManagedObjectContext:context];
    [newAlbum setValue: _getPrograma forKey:@"programa"];
    [newAlbum setValue: _getProducto  forKey:@"producto"];
    [newAlbum setValue: _getEspecie forKey:@"especie"];
    [newAlbum setValue: _getTitulo forKey:@"nombre"];
    [newAlbum setValue: _getDescripcion forKey:@"descripcion"];

    NSError *error;
    [context save:&error];
    
    
    UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Su album fue enviado a revisíon" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alerta show];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
        
}

- (IBAction)returnButton:(id)sender{

   [self.navigationController popViewControllerAnimated:TRUE];

}

- (IBAction)enviarButton:(id)sender {
    
    [self uploadImages];
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        
//        sleep(1);
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        NSDictionary *parameters = @{
//                                     @"sessid"          : appDelegate.userSession.sesionID,
//                                     @"title"           : self.getTitulo,
//                                     @"description"     : self.getDescripcion,
//                                     @"id_program"      : appDelegate.userSession.programaID,
//                                     @"id_product"      : appDelegate.userSession.productoID,
//                                     @"id_animal_type"  : appDelegate.userSession.especieID
//                                     };
//        [manager.requestSerializer setValue:@"sinspf34niufww44ib53ufds" forHTTPHeaderField:@"apikey"];
//        [manager.requestSerializer setValue:@"dfaiun45vfogn234@" forHTTPHeaderField:@"password"];
//        [manager.requestSerializer setValue:@"new_gallery" forHTTPHeaderField:@"opt"];
//        [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
//        [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        NSLog(@"RESPUESTA: %@",responseObject);
//        galeriaID = [responseObject objectForKey:@"id_gallery"];
//        NSLog(@"id de la galeria: %@",[responseObject objectForKey:@"id_gallery"]);
//        [self uploadImages];
//        }
//              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                  
//                  NSLog(@"Error: %@",error);
//                  
//              }];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        });
//    });

}


-(void)uploadImages{
//    for (int i = 0; i < [self.selectedImages count]; i++) {
//    
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        NSDictionary *parameters = @{
//                                     @"sessid"          : appDelegate.userSession.sesionID,
//                                     @"id_gallery"      : galeriaID,
//                                     @"title"           : self.getDescripcion,
//                                     @"description"     : appDelegate.userSession.programaID,
//                                     @"image"           : appDelegate.userSession.productoID
//                                     };
//        [manager.requestSerializer setValue:@"sinspf34niufww44ib53ufds" forHTTPHeaderField:@"apikey"];
//        [manager.requestSerializer setValue:@"dfaiun45vfogn234@" forHTTPHeaderField:@"password"];
//        [manager.requestSerializer setValue:@"new_gallery_image" forHTTPHeaderField:@"opt"];
//        [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
//        [manager POST:appDelegate.userSession.Url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        }
//         
//         
//              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//              }]
//        [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        NSLog(@"RESPUESTA: %@",responseObject);
//        for(NSDictionary *tempDic in [responseObject objectForKey:@"galleries"])
//        {
//
//
//
//        }
//
//            
//        }
//              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                  
//                  NSLog(@"Error: %@",error);
//                  
//              }];
//  }
    
//    ALAsset *asset = self.selectedImages[0];
//    
//    NSLog(@"URL img %@",asset.defaultRepresentation.url);
////    NSDictionary *headers = @{
////                                  @"apikey"     : @"sinspf34niufww44ib53ufds",
////                                  @"password"   : @"dfaiun45vfogn234",
////                                  @"opt"        : @"new_gallery_image",
////                                  };
//    NSDictionary *parameters = @{
//                                  @"sessid"          : appDelegate.userSession.sesionID,
//                                  @"id_gallery"      : galeriaID,
//                                  @"title"           : self.getDescripcion,
//                                  @"description"     : appDelegate.userSession.programaID,
//                                  @"image"           : appDelegate.userSession.productoID
//                                  };
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    //configuration.HTTPAdditionalHeaders = headers;
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSURL *URL = [NSURL URLWithString:appDelegate.userSession.Url];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:appDelegate.userSession.Url parameters:@""];
//    NSURL *filePath = asset.defaultRepresentation.url;
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"Success: %@ %@", response, responseObject);
//        }
//    }];
//    [uploadTask resume];
    

}
@end







#pragma mark - nuevoAlbum
#import <AFNetworking.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>


@implementation nuevoAlbum
UIPickerView *pickerView1;
UIPickerView *pickerView2;
UIPickerView *pickerView3;
NSMutableArray *programas;
NSMutableArray *productos;
NSMutableArray *especies;
NSMutableArray *programaID;
NSMutableArray *productoID;
NSMutableArray *especieID;
UIView *blockView;

AppDelegate *appDelegate;

CGRect screenBound;
CGSize screenSize;
CGFloat screenWidth;
CGFloat screenHeight;

-(void)viewDidLoad{
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    programas =[[NSMutableArray alloc]init];
    productos =[[NSMutableArray alloc]init];
    especies =[[NSMutableArray alloc]init];
    programaID =[[NSMutableArray alloc]init];
    productoID =[[NSMutableArray alloc]init];
    especieID =[[NSMutableArray alloc]init];
    
    
    //ponemos fondo al View y a la barra de navegacion
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    self.nuevoAlbumNav.barTintColor = [UIColor orangeColor];
    
    //agregar view para poner color de fondo al status bar
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
    statusBarView.backgroundColor  =  [UIColor orangeColor];
    [self.view addSubview:statusBarView];
    
    pickerView1 = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView1.delegate = self;
    pickerView1.dataSource = self;
    _programaPV.delegate = self;
    _productoPV.delegate = self;
    _especiePV.delegate = self;
    _tituloTextField.delegate = self;
    _descripcionTextField.delegate = self;
    pickerView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    _programaPV.inputView = pickerView1;
    _productoPV.inputView = pickerView1;
    _especiePV.inputView = pickerView1;
    [self programasRequest];
}

-(void)viewWillAppear:(BOOL)animated{


}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if ([_programaPV isFirstResponder]) {
        return [programas count];
    }else if ([_productoPV isFirstResponder]){
        return [productos count];
    }else if ([_especiePV isFirstResponder]){
        return [especies count];
    } return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if ([_programaPV isFirstResponder]) {
        return programas[row];
    }else if ([_productoPV isFirstResponder]){
        if ([programas count] == 0) {
            return @"No Existen Productos en este Programa";
        }else return productos[row];
    }else if ([_especiePV isFirstResponder]){
        if ([especies count] == 0) {
            return @"No Existen Especies en este Producto";
        }else return especies[row];
    }
    return @"Error al cargar los programas";



}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{


    if ([_programaPV isFirstResponder]) {
        _programaPV.text = programas[row];
        _productoPV.enabled = YES;
        appDelegate.userSession.programaID = programaID[row];
        [self productosRequest];
        [_programaPV resignFirstResponder];
    }else if ([_productoPV isFirstResponder]){
        _productoPV.text = productos[row];
        _especiePV.enabled = YES;
        appDelegate.userSession.productoID = productoID[row];
        [self EspeciesRequest];
        [_productoPV resignFirstResponder];
    }else if ([_especiePV isFirstResponder]){
        _especiePV.text = especies[row];
        appDelegate.userSession.especieID = especieID[row];
        [_especiePV resignFirstResponder];
    }


}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
//    blockView = [[UIView alloc]initWithFrame:self.view.frame];
//    blockView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:blockView];
    [textField isFirstResponder];
    [pickerView1 reloadAllComponents];

    return YES;

}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    //[blockView removeFromSuperview];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    if (([_descripcionTextField isFirstResponder] || [_tituloTextField isFirstResponder]) && ( screenWidth == 320 )) {
        [self animateTextField:textField up:YES];
    }
    

}

-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (([_descripcionTextField resignFirstResponder] || [_tituloTextField resignFirstResponder]) && ( screenWidth == 320)) {
        [self animateTextField:textField up:NO];
    }

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.tituloTextField resignFirstResponder];
    [self.descripcionTextField resignFirstResponder];
    [self.programaPV resignFirstResponder];
    [self.productoPV resignFirstResponder];
    [self.especiePV resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.tituloTextField resignFirstResponder];
    [self.descripcionTextField resignFirstResponder];
    [self.programaPV resignFirstResponder];
    [self.productoPV resignFirstResponder];
    [self.especiePV resignFirstResponder];
    return YES;
    
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = 150; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.conteiner.bounds = CGRectOffset(self.conteiner.bounds, 0, movement);
    [UIView commitAnimations];
    
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

- (IBAction)returnButton:(id)sender {
    
   [self.navigationController popViewControllerAnimated:TRUE];
    
}

- (IBAction)crearButton:(id)sender {

    crearAlbumVC *crear =  [self.storyboard instantiateViewControllerWithIdentifier:@"crearAlbumVC"];
    crear.getTitulo = _tituloTextField.text;
    crear.getDescripcion = _descripcionTextField.text;
    crear.selectedImages = self.selectedImages;
    crear.getPrograma = _programaPV.text;
    crear.getProducto = _productoPV.text;
    crear.getEspecie = _especiePV.text;
    [self.navigationController  pushViewController:crear animated:YES];

}


-(void)programasRequest{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"sessid"    : appDelegate.userSession.sesionID
                                 
                                 };
    [manager.requestSerializer setValue:@"sinspf34niufww44ib53ufds" forHTTPHeaderField:@"apikey"];
    [manager.requestSerializer setValue:@"dfaiun45vfogn234@" forHTTPHeaderField:@"password"];
    [manager.requestSerializer setValue:@"get_programs" forHTTPHeaderField:@"opt"];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        for(NSDictionary *tmpDic in [responseObject objectForKey:@"programs"])
        {
            [programas addObject: [tmpDic objectForKey:@"title"]];
            [programaID addObject:[tmpDic valueForKey:@"id"]];
            NSLog(@"title es: %@", [tmpDic valueForKey:@"title"]);
            
        }

    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
              
          }];

    
}

-(void)productosRequest{
    
    [productos removeAllObjects];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"sessid"    : appDelegate.userSession.sesionID,
                                 @"id_program": appDelegate.userSession.programaID
                                 
                                 };
    [manager.requestSerializer setValue:@"sinspf34niufww44ib53ufds" forHTTPHeaderField:@"apikey"];
    [manager.requestSerializer setValue:@"dfaiun45vfogn234@" forHTTPHeaderField:@"password"];
    [manager.requestSerializer setValue:@"get_products" forHTTPHeaderField:@"opt"];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        for(NSDictionary *tempDic in [responseObject objectForKey:@"products"])
        {
            [productos addObject: [tempDic objectForKey:@"title"]];
            [productoID addObject: [tempDic objectForKey:@"id"]];
            NSLog(@"title es: %@", [tempDic valueForKey:@"title"]);
            
        }
        NSLog(@"JSON: %@",responseObject);
        NSLog(@"array title: %@",productos);
        NSLog(@"array ID: %@",productoID);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
              
          }];

    
}

-(void)EspeciesRequest{
    
    [especies removeAllObjects];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"sessid"    : appDelegate.userSession.sesionID,
                                 @"id_product": appDelegate.userSession.productoID
                                 
                                 };
    [manager.requestSerializer setValue:@"sinspf34niufww44ib53ufds" forHTTPHeaderField:@"apikey"];
    [manager.requestSerializer setValue:@"dfaiun45vfogn234@" forHTTPHeaderField:@"password"];
    [manager.requestSerializer setValue:@"get_animals" forHTTPHeaderField:@"opt"];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        for(NSDictionary *tempDic in [responseObject objectForKey:@"animals"])
        {
            [especies addObject:[tempDic objectForKey:@"title"]];
            [especieID addObject:[tempDic objectForKey:@"id"]];
            NSLog(@"title es: %@", [tempDic valueForKey:@"title"]);
            
        }
        NSLog(@"JSON: %@",responseObject);
        NSLog(@"array title: %@",especies);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
              
          }];

}

@end


@implementation CustomHeaderView



@end




