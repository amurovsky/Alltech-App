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
#import "ViewController.h"
#import "SWRevealViewController.h"
#import "selecAlbumTV.h"
#import "carreteVC.h"
#import "Albums.h"
#import "repositoriodeAlbums.h"
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
    NSString *guardarAlerta;
    NSString *enviarAlerta;
    
}



-(void)viewDidLoad{
    [super viewDidLoad];
    //Inicializamos las variables para recoger las dimensiones de la pantalla
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

    UIView * separador = [[UIView alloc]initWithFrame:CGRectMake(screenWidth/2, 0, 1, screenHeight)];
    separador.backgroundColor = [UIColor whiteColor];
    [self.toolBarAlbum   addSubview:separador];
    [appDelegate.userSession.selectedImages removeAllObjects];
    
    NSString *idioma = appDelegate.userSession.lenguaje;
    if ([idioma isEqual:@"es"]) {
        
        self.navItem.title = @"Crear Álbum";
        self.guardarButton.title = @"Guardar";
        self.enviarButton.title = @"Enviar";
        guardarAlerta = @"Su album fue guardado satisfactoriamente";
        enviarAlerta = @"Su album fue enviado a revision";
    }else if ([idioma isEqual:@"en"]) {
        
        self.navItem.title = @"Create Album";
        self.guardarButton.title = @"Save";
        self.enviarButton.title = @"Send";
        guardarAlerta = @"Your album was saved successfully";
        enviarAlerta = @"Your album has been sent to review";
    }else if ([idioma isEqual:@"pt"]) {
        
        self.navItem.title = @"Criar Album";
        self.guardarButton.title = @"Salvar";
        self.enviarButton.title = @"Enviar";
        guardarAlerta = @"Seu álbum foi salvo com sucesso";
        enviarAlerta = @"Seu álbum foi enviado a avaliar";
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
    
}




-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CustomHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        
        reusableview = headerView;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 129, headerView.bounds.size.width, 1)];
        lineView.backgroundColor = [UIColor orangeColor];
        [headerView addSubview:lineView];
        headerView.tituloAlbumLabel.text = _albums.nombre;
        headerView.descripcionLabel.text = _albums.descripcion;
        headerView.filtradoLabel.text = [NSString stringWithFormat:@"%@/ %@/ %@",_albums.programa,_albums.producto,_albums.especie];
    }
    
    
    return reusableview;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if ([appDelegate.userSession.selectedImages count] == 0) {
        NSLog(@"vienes de atras count y hay :%lu imagenes",(unsigned long)[_albums.imagenes count]);
       return [_albums.imagenes count];
    }
    return [appDelegate.userSession.selectedImages count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    cell = (previewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"previewCell" forIndexPath:indexPath];
    
    
    //ALAsset *asset = self.selectedImages[indexPath.row];
    //ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    //cell.backgroundColor = [UIColor clearColor];
    //cell.previewImg.image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    
    if([appDelegate.userSession.selectedImages count] == 0){
        UIImage *image = [UIImage imageWithData:[_albums.imagenes objectAtIndex:indexPath.row]];
        cell.previewImg.image = image;
    }else{
        cell.previewImg.image = [appDelegate.userSession.selectedImages objectAtIndex:indexPath.row];
    
    }
    
        
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
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy hh:mma"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    _albums.imagenes = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [appDelegate.userSession.selectedImages count]; i++) {
        NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(appDelegate.userSession.selectedImages[i], 0.0)];
        //[_albums.imagenes addObject:appDelegate.userSession.selectedImages[i]];
        [_albums.imagenes addObject:imageData];
    }
    
    _albums.fechaModificacion = dateString;
    UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"" message:guardarAlerta delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alerta show];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
        
}

- (IBAction)mostrarCarrete:(id)sender {
    
    [appDelegate.userSession.selectedImages removeAllObjects];
    carreteVC *carrete = [self.storyboard instantiateViewControllerWithIdentifier:@"carreteVC"];
    [self presentViewController:carrete animated:YES completion:nil];
    
}

- (IBAction)returnButton:(id)sender{
    [appDelegate.userSession.selectedImages removeAllObjects];
    [self.navigationController popViewControllerAnimated:TRUE];

}

- (IBAction)enviarButton:(id)sender {

    
    //[self uploadImages];

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{
                                     @"sessid"          : appDelegate.userSession.sesionID,
                                     @"title"           : self.albums.nombre,
                                     @"description"     : self.albums.descripcion,
                                     @"id_program"      : appDelegate.userSession.programaID,
                                     @"id_product"      : appDelegate.userSession.productoID,
                                     @"id_animal_type"  : appDelegate.userSession.especieID,
                                     @"opt"             : @"new_gallery"
                                     };

        [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
        [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {

        NSLog(@"RESPUESTA: %@",responseObject);
        galeriaID = [responseObject objectForKey:@"id_gallery"];
        NSLog(@"id de la galeria: %@",[responseObject objectForKey:@"id_gallery"]);
        [self uploadImages];
        }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
                  NSLog(@"Error: %@",error);
                  
              }];

}


-(void)uploadImages{
    
    NSLog(@"galeria ID: %@",appDelegate.userSession.selectedImages);

    if ([_albums.imagenes count] != 0) {

        for (int i = 0; i < [self.albums.imagenes count]; i++) {
            NSString *fileName = [NSString stringWithFormat:@"%ld%c%c.jpg", (long)[[NSDate date] timeIntervalSince1970], arc4random_uniform(26) + 'a', arc4random_uniform(26) + 'a'];
            //UIImage *image = [UIImage imageNamed:@"ejemplo4"];
            //NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(appDelegate.userSession.selectedImages[i], 0.0)];
            
            // setting up the request object now
            NSURL *nsurl =[NSURL URLWithString:appDelegate.userSession.Url];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            [request setURL:nsurl];
            [request setHTTPMethod:@"POST"];
            
            
            NSString *boundary = @"---------------------------14737809831466499882746641449";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            /*
             now lets create the body of the post
             */
            NSMutableData *body = [NSMutableData data];
            
            //sessionID
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sessid\"\r\n\r\n%@", appDelegate.userSession.sesionID] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //Galeria ID
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id_gallery\"\r\n\r\n%@",galeriaID] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //titulo
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n%@", @""] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //Descripcion
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"description\"\r\n\r\n%@", @""] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //cover
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"cover\"\r\n\r\n%@", @"0"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //opt
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"opt\"\r\n\r\n%@", @"new_gallery_image"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //Image
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n",fileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:_albums.imagenes[i]]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // setting the body of the post to the reqeust
            [request setHTTPBody:body];
            
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSLog(@"Respuesta: %@",returnData);
            
        
        }
        
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"" message:enviarAlerta delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"" message:@"No puedes enviar un álbum sin imagenes" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
    
    }
 
    
    

}


@end







#pragma mark - nuevoAlbum
#import <AFNetworking.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>


@implementation nuevoAlbum
UIPickerView *pickerView1;
NSMutableArray *programas;
NSMutableArray *productos;
NSMutableArray *especies;
NSMutableArray *programaID;
NSMutableArray *productoID;
NSMutableArray *especieID;
UIView *blockView;
NSString *choose;
NSString *alertaVacios;

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
    
    pickerView1 = [[UIPickerView alloc]init];
    pickerView1.delegate = self;
    pickerView1.dataSource = self;
    _programaPV.delegate = self;
    _productoPV.delegate = self;
    _especiePV.delegate = self;
    _tituloTextField.delegate = self;
    _descripcionTextField.delegate = self;
    pickerView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    [toolBar setBackgroundImage:[UIImage new]
                  forToolbarPosition:UIToolbarPositionAny
                          barMetrics:UIBarMetricsDefault];
    
    [toolBar setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"OK"
                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(doneButton:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = 10;
    toolBar.items = @[flex,barButtonDone,space];
    barButtonDone.tintColor=[UIColor orangeColor];
    _programaPV.inputView = pickerView1;
    _productoPV.inputView = pickerView1;
    _especiePV.inputView = pickerView1;
    _programaPV.inputAccessoryView = toolBar;
    _productoPV.inputAccessoryView = toolBar;
    _especiePV.inputAccessoryView = toolBar;
    
    
//    NSInteger row = [pickerView1 selectedRowInComponent:0];
//    NSString *Selected = [programas objectAtIndex:row];
    
    [self programasRequest];
    
    NSString *idioma = appDelegate.userSession.lenguaje;
    if ([idioma isEqual:@"es"]) {
        self.programaPV.placeholder =@"Selecciona un programa";
        self.productoPV.placeholder =@"Selecciona un producto";
        self.especiePV.placeholder =@"Selecciona una tipo";
        self.tituloTextField.placeholder =@"Agrega un título";
        self.descripcionTextField.placeholder =@"Agrega una descripción";
        self.crearAlbumNavItem.title=@"Crear Álbum";
        self.crearButton.title=@"Crear";
        choose = @"Selecciona ...";
        alertaVacios = @"Hay Campos sin completar";
        
    }else if ([idioma isEqual:@"en"]) {
        self.programaPV.placeholder =@"Choose a program";
        self.productoPV.placeholder =@"Choose a product";
        self.especiePV.placeholder =@"Choose a type";
        self.tituloTextField.placeholder =@"Add a title";
        self.descripcionTextField.placeholder =@"Add a description";
        self.crearAlbumNavItem.title=@"Create Album";
        self.crearButton.title=@"Create";
        choose = @"Choose ...";
        alertaVacios = @"There are fields without completing";
    }else if ([idioma isEqual:@"pt"]) {
        self.programaPV.placeholder =@"Escolha um programa";
        self.productoPV.placeholder =@"Escolha um produto";
        self.especiePV.placeholder =@"Escolha um tipo";
        self.tituloTextField.placeholder =@"Adicione um título";
        self.descripcionTextField.placeholder =@"Adicione uma descrição";
        self.crearAlbumNavItem.title=@"Criar Album";
        self.crearButton.title=@"Criar";
        choose = @"Escolha ...";
        alertaVacios = @"Existem campos sem preenchimento";
    }
}

-(void)doneButton:(id)sender
{
    if ([_programaPV isFirstResponder]) {
        _productoPV.enabled = YES;
        [_programaPV resignFirstResponder];
        [self.conteiner setUserInteractionEnabled:YES];
    }else if ([_productoPV isFirstResponder]){
        _especiePV.enabled = YES;
        [_productoPV resignFirstResponder];
        [self.conteiner setUserInteractionEnabled:YES];
    }else if ([_especiePV isFirstResponder]){
        [_especiePV resignFirstResponder];
        [self.conteiner setUserInteractionEnabled:YES];
    }
    
    
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

    if (row != 0) {
        if ([_programaPV isFirstResponder]) {
            _programaPV.text = programas[row];
            appDelegate.userSession.programaID = programaID[row-1];
            [self productosRequest];
        }else if ([_productoPV isFirstResponder]){
            _productoPV.text = productos[row];
            appDelegate.userSession.productoID = productoID[row-1];
            [self EspeciesRequest];
        }else if ([_especiePV isFirstResponder]){
            _especiePV.text = especies[row];
            appDelegate.userSession.especieID = especieID[row-1];
        }
    }

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == _programaPV || textField == _productoPV || textField == _especiePV) {
        [self.conteiner setUserInteractionEnabled:NO];
    }
    [textField isFirstResponder];
    [pickerView1 reloadAllComponents];

    return YES;

}

-(void)textFieldDidBeginEditing:(UITextField *)textField{


    if ( screenWidth == 320 ) {
        [self animateTextField:textField up:YES];
    }
    

}

-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (screenWidth == 320) {
        [self animateTextField:textField up:NO];
    }

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


-(void)programasRequest{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"sessid"  : appDelegate.userSession.sesionID,
                                 @"opt"     : @"get_programs"
                                 };
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {

        for(NSDictionary *tmpDic in [responseObject objectForKey:@"programs"])
        {
            [programas addObject: [tmpDic objectForKey:@"title"]];
            [programaID addObject:[tmpDic valueForKey:@"id"]];
            NSLog(@"title es: %@", [tmpDic valueForKey:@"title"]);
            
            
        }[programas insertObject:choose atIndex:0];
        NSLog(@"1: %@ 2: %@",programas[0],programas[1]);
        NSLog(@"Count: %lu",(unsigned long)[programas count]);

        
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
                                 @"id_program": appDelegate.userSession.programaID,
                                 @"opt"       : @"get_products"
                                 };
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
        [productos insertObject:choose atIndex:0];
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
                                 @"id_product": appDelegate.userSession.productoID,
                                 @"opt"       : @"get_animals"
                                 };
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
        [especies insertObject:choose atIndex:0];
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
              
          }];

}


-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

- (IBAction)returnButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)crearButton:(id)sender {
    
    if (_programaPV.text.length !=0 && _productoPV.text.length !=0 && _especiePV.text.length !=0 && _tituloTextField.text.length !=0 && _descripcionTextField.text.length !=0 ) {
        
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy hh:mma"];
        NSString *dateString = [dateFormat stringFromDate:today];
        
        
        Albums *album = [[Albums alloc]init];
        
        album.nombre = _tituloTextField.text;
        album.descripcion = _descripcionTextField.text;
        album.programa = _programaPV.text;
        album.producto = _productoPV.text;
        album.especie = _especiePV.text;
        album.fechaModificacion = dateString;
        
        NSMutableArray * albums = [repositoriodeAlbums sharedInstance].albums;
        [albums addObject:album];
        
        [self.navigationController  popViewControllerAnimated:YES];
        
    }else
    {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"" message:alertaVacios delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
    }
    
    
    
}

@end


@implementation CustomHeaderView



@end




