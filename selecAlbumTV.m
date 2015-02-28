//
//  selecAlbumTV.m
//  Alltech
//
//  Created by Tejuino developers on 20/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "selecAlbumTV.h"
#import "crearAlbumVC.h"

@interface selecAlbumTV ()

@end

@implementation selecAlbumTV{

    NSArray *albums;
    NSArray *imgAlbums;
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Inicializamos las variables para recoger las dimensiones de la pantalla
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    albums=@[@"Pelaje bovino en Feria del ganado Guanajuato.",@"Alltech FEI World Equestrian Games™",@"Resultados en Avicultura",@"Eficencia Alimenticia Porcina",@"VIRBAC Bovinos Carne 2014",@"Congreso Mundial de Ganadería Tropical"];
    imgAlbums=@[@"img1",@"img2",@"img3",@"img4",@"img5",@"img6"];
    
    //ponemos fondo al View y a la barra de navegacion
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    self.selectAlbumNav.barTintColor = [UIColor orangeColor];
    
    //agregar view para poner color de fondo al status bar
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 22)];
    statusBarView.backgroundColor  =  [UIColor orangeColor];
    [self.view addSubview:statusBarView];
    
    NSLog(@"estas son las imagenes que el usuario selecciono en SelecAlbumTV: %@",self.selectedImages);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 1)
        return [albums count];
    return 1;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;
    UIImageView *imgView;
    CGSize itemSize;
    
    
    //CELDA STATICA
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"crearNuevoAlbum" forIndexPath:indexPath];
        
        //Redimencion de imagenes respecto a tamaño del dispositivo
        
        // ipad 2, ipad mini, ipad retina
        if (screenWidth == 768 && screenHeight == 1024) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 22, 69, 69)];
            itemSize = CGSizeMake(70, 70);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:25.0];
        }
        
        // iphone 6 plus
        if (screenWidth == 414 && screenHeight == 736) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 15, 49, 49)];
            itemSize = CGSizeMake(40, 40);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }
        
        // iphone 6
        if (screenWidth == 375 && screenHeight == 667) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 15, 49, 49)];
            itemSize = CGSizeMake(40, 40);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }
        // iphone 5, 5c, 5s, touch 5
        else if (screenWidth == 320 && screenHeight == 568){
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 40, 40)];
            itemSize = CGSizeMake(30, 30);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }
        // iphone 4, 4s, touch 4
        else if (screenWidth == 320 && screenHeight == 480){
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 40, 40)];
            itemSize = CGSizeMake(30, 30);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }

        imgView.image = [UIImage imageNamed:@"mas"];
        cell.textLabel.text = @"Nuevo Álbum";

    //CELDAS DINAMICAS
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableItem" forIndexPath:indexPath];
    
        cell.textLabel.text = [albums objectAtIndex:indexPath.row];
        cell.textLabel.numberOfLines = 2;
    
        //Redimencion de imagenes respecto a tamaño del dispositivo
        
        // ipad 2, ipad mini, ipad retina
        if (screenWidth == 768 && screenHeight == 1024) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 22, 69, 69)];
            itemSize = CGSizeMake(70, 70);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:25.0];
        }
        
        // iphone 6 plus
        if (screenWidth == 414 && screenHeight == 736) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 15, 49, 49)];
            itemSize = CGSizeMake(40, 40);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }
        
        // iphone 6
        if (screenWidth == 375 && screenHeight == 667) {
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 15, 49, 49)];
            itemSize = CGSizeMake(40, 40);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:19.0];
        }
        // iphone 5, 5c, 5s, touch 5
        else if (screenWidth == 320 && screenHeight == 568){
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 40, 40)];
            itemSize = CGSizeMake(30, 30);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }
        // iphone 4, 4s, touch 4
        else if (screenWidth == 320 && screenHeight == 480){
            
            imgView = [ [UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 40, 40)];
            itemSize = CGSizeMake(30, 30);
            cell.textLabel.font=[UIFont fontWithName:@"Aileron-Thin" size:17.0];
        }

        
        imgView.image = [UIImage imageNamed:[imgAlbums objectAtIndex:indexPath.row] ];


    }

    imgView.contentMode = UIViewContentModeCenter;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [cell addSubview:imgView];
    
    
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //fondo transparente a la celda
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     //Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"crearAlbum"]) {
        crearAlbumVC *crearAlbum = (crearAlbumVC *) segue.destinationViewController;
        crearAlbum.selectedImages = self.selectedImages;
    }
    
    
}



-(UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
    
}

- (IBAction)returnButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}
@end
