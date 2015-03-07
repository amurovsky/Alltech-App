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
    previewCell *cell;

    
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
   
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
UIPickerView *pickerView1;
UIPickerView *pickerView2;
UIPickerView *pickerView3;
NSArray *programas;
NSMutableArray *productos;
NSArray *especies;

NSArray * productosMinerales;
NSArray * productosSaludIntestinal;
NSArray * productosMicotoxinas;
NSArray * productosEficienciaAlimenticia;
NSArray * productosAlgas;
NSArray * productosProteinas;
NSArray * productosotros;
NSInteger renglon;

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
    

    
    programas = [NSArray arrayWithObjects:@"Manejo de Minerales",@"Manejo de Salud Intestinal",@"Manejo de Micotoxinas",@"Manejo de Eficiencia Alimenticia",@"Manejo de Algas",@"Manejo de Proteinas",@"Otros productos",nil];
    especies =@[@"Acuicultura",@"Ganado de Carne",@"Ganado de Leche",@"Mascotas",@"Ponedoras",@"Brokers",@"Cerdos"];
    
    
    productosMinerales = @[@"Bioplex",@"Selplex",@"Elonomase"];
    productosSaludIntestinal = @[@"Actigen",@"Bio-Mos",@"Acid Pak",@"Yea-Sacc"];
    productosMicotoxinas = @[@"Mycosorb"];
    productosEficienciaAlimenticia = @[@"Allzyme SSF",@"Allzyme VegPro"];
    productosAlgas = @[@"All-G-Rich",@"LG Max"];
    productosProteinas =@[@"NuPRO",@"Optigen"];
    productosotros = @[@"Advantage Packs",@"Yea-Sacc"];

    
    
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
    
    [self pickerView:pickerView1 didSelectRow:0 inComponent:0];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if ([_programaPV isFirstResponder]) {
        return [programas count];
    }else if ([_productoPV isFirstResponder]){
        if (renglon == 0) {
           return [productosMinerales count];
        }else if (renglon == 1) {
            return [productosSaludIntestinal count];
        }else if (renglon == 2) {
            return [productosMicotoxinas count];
        }else if (renglon == 3) {
            return [productosEficienciaAlimenticia count];
        }else if (renglon == 4) {
            return [productosAlgas count];
        }else if (renglon == 5) {
            return [productosProteinas count];
        }else if (renglon == 6) {
            return [productosotros count];
        }
        
    }else if ([_especiePV isFirstResponder]){
        return [especies count];
    } return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if ([_programaPV isFirstResponder]) {
        return programas[row];
    }else if ([_productoPV isFirstResponder]){
        if (renglon == 0) {
            return productosMinerales[row];
        }else if (renglon == 1) {
            return productosSaludIntestinal[row];
        }else if (renglon == 2) {
            return productosMicotoxinas[row];
        }else if (renglon == 3) {
            return productosEficienciaAlimenticia[row];
        }else if (renglon == 4) {
            return productosAlgas[row];
        }else if (renglon == 5) {
            return productosProteinas[row];
        }else if (renglon == 6) {
            return productosotros[row];
        }

    }else if ([_especiePV isFirstResponder]){
        return especies[row];
    }
    return @"Error al cargar los programas";



}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{


    if ([_programaPV isFirstResponder]) {
        _programaPV.text = programas[row];
        renglon = [pickerView1 selectedRowInComponent:0];
        NSLog(@"este es el renglon seleccionado %li",(long)renglon);
        _productoPV.enabled = YES;
        _productoPV.text = @"";
        [_programaPV resignFirstResponder];
    }else if ([_productoPV isFirstResponder]){
        NSString *nombredelProducto = [self pickerView:pickerView1 titleForRow:row forComponent:0];
        _productoPV.text = nombredelProducto;
        [_productoPV resignFirstResponder];
    }else if ([_especiePV isFirstResponder]){
        _especiePV.text = especies[row];
        [_especiePV resignFirstResponder];
    }


}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    [textField isFirstResponder];
   
    [pickerView1 reloadAllComponents];

    
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
    [self.navigationController  pushViewController:crear animated:YES];
}



@end


@implementation CustomHeaderView



@end




