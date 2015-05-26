//
//  loginVC.m
//  Alltech
//
//  Created by Tejuino developers on 29/01/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "loginVC.h"
#import "CSAnimationView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AFNetworking.h>
#import "SWRevealViewController.h"
#import "session.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>


@interface loginVC ()

@end

@implementation loginVC

CGRect screenBound;
CGSize screenSize;
CGFloat screenWidth;
CGFloat screenHeight;
int flagUp=0;
int flagDown=1;
MPMoviePlayerController *moviePlayer;
AppDelegate *appDelegate;
NSString *camposVacios;
NSString *contrasenaInvalida;
NSString *conexionPerdida;
NSString *correoInvalido;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    // find movie file
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"video_iphone_1" ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    UIImageView *gradient =[[UIImageView alloc]initWithFrame:self.view.frame];
    gradient.image = [UIImage imageNamed:@"gradient23"];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    moviePlayer.controlStyle = MPMovieControlStyleNone;
    moviePlayer.view.frame = self.view.frame;
    moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    [self.view addSubview:moviePlayer.view];
    [self.view sendSubviewToBack:moviePlayer.view];
    [self.view insertSubview:gradient aboveSubview:moviePlayer.view];
    [moviePlayer play];
    
    // loop movie
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(replayMovie:)
                                                 name: MPMoviePlayerPlaybackDidFinishNotification
                                               object: moviePlayer];
    
    
    // Sacar Dimensiones de la pantalla
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    //Declaramos como delegados de los UITexField a ellos mismos
    _userName.delegate = self;
    _password.delegate = self;

    //Logo Alltech
    
    UIImage *image = [UIImage imageNamed:@"logo_alltech"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    // ipad 2, ipad Air, ipad retina
    
    if (screenWidth == 768 && screenHeight == 1024) {
        
        //backgroundImage = [UIImage imageNamed:@"fondo_ipad"];
        
        _userName.font = [UIFont fontWithName:@"Aileron-Bold" size:30.0];
        _password.font = [UIFont fontWithName:@"Aileron-Bold" size:30.0];
       [_loginButton.titleLabel setFont:[UIFont fontWithName:@"Aileron-Bold" size:30.0]];
        
        _ingresaCorreoLabel.font = [UIFont fontWithName:@"Aileron-Bold" size:30.0];
        _enviadoLabel.font = [UIFont fontWithName:@"Aileron-Bold" size:30.0];
        _enviadoCorreoLabel.font = [UIFont fontWithName:@"Aileron-Bold" size:30.0];
        _correoTexField.font = [UIFont fontWithName:@"Aileron-Bold" size:22.0];
        [_recuperarButton.titleLabel setFont:[UIFont fontWithName:@"Aileron-Bold" size:25.0]];
        
        imageView.frame = CGRectMake(0, 20, screenWidth, 80);
        
    }// iphone 6 plus
    else if (screenWidth == 414 && screenHeight == 736) {
        
        imageView.frame = CGRectMake(0, 0, screenWidth, 40);
        
    }
    
    // iphone 6
    else if (screenWidth ==375 && screenHeight == 667){
    
        //backgroundImage = [UIImage imageNamed:@"fondo_iphone_conLogo"];
    
        imageView.frame = CGRectMake(0, 0, screenWidth, 40);
    }
    
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){
        
        imageView.frame = CGRectMake(0, 20, screenWidth, 30);
        
        
    }
    
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
        
        imageView.frame = CGRectMake(0, -50, screenWidth, 30);
 
    }

    
    //Animacion Fade In de logo Alltech
    
    CSAnimationView *animationView = [[CSAnimationView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, 40)];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.duration = 1;
    animationView.delay    = 0;
    animationView.type     = CSAnimationTypeFadeIn;
    [self.view insertSubview:animationView aboveSubview:gradient];
    // Add your subviews into animationView
    [animationView addSubview:imageView];
    // Kick start the animation immediately
    [animationView startCanvasAnimation];
    NSLog(@"lenguaje Guardado: %@",[appDelegate.userSession.settings objectForKey:@"lang"]);
    NSLog(@"sessionID guardado %@",[appDelegate.userSession.settings objectForKey:@"sessid"]);
    appDelegate.userSession.lenguaje = [appDelegate.userSession.settings objectForKey:@"lang"];
    
    if (appDelegate.userSession.lenguaje == nil) {
        appDelegate.userSession.lenguaje = @"en";
        [appDelegate.userSession.settings setObject:@"en" forKey:@"lang"];
    }
    
    if ([appDelegate.userSession.lenguaje isEqual:@"es"]) {
        
        self.userName.placeholder = @"Usuario";
        self.password.placeholder = @"Contraseña";
        [self.loginButton setTitle:@"Entrar" forState:UIControlStateNormal];
        [self.olvideMiContrasena setTitle:@"Olvide mi contraseña" forState:UIControlStateNormal];
        camposVacios = @"Los campos usuario y contraseña no pueden estar vacíos";
        contrasenaInvalida = @"usuario o contraseña invalido";
        conexionPerdida = @"No se puede establecer conexión con el servidor intente mas tarde ";
        [self.recuperarButton setTitle:@"Recuperar" forState:UIControlStateNormal];
        [self.regresarButton setTitle:@" Regresar" forState:UIControlStateNormal];
        self.ingresaCorreoLabel.text = @"Ingresa tu correo electrónico para recuperar tu contraseña";
        self.enviadoLabel.text = @"SE HA ENVIADO UN CORREO CON TU CONTRASEÑA A:";
        correoInvalido = @"Correo Inválido";
    }else if ([appDelegate.userSession.lenguaje isEqual:@"en"]) {
        
        self.userName.placeholder = @"Username";
        self.password.placeholder = @"Password";
        [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [self.olvideMiContrasena setTitle:@"Forgot my password" forState:UIControlStateNormal];
        camposVacios = @"The user and password fields can not be empty";
        contrasenaInvalida = @"Invalid username or password";
        conexionPerdida = @"Can not connect to the server, please try again later";
        [self.recuperarButton setTitle:@"recover" forState:UIControlStateNormal];
        [self.regresarButton setTitle:@" Back" forState:UIControlStateNormal];
        self.ingresaCorreoLabel.text = @"Enter your email to reset your password";
        self.enviadoLabel.text = @"WE HAVE SENT AN EMAIL WITH YOUR PASSWORD TO:";
        correoInvalido = @"invalid email";
    }else if ([appDelegate.userSession.lenguaje isEqual:@"pt"]) {
        
        self.userName.placeholder = @"Nome de usuário";
        self.password.placeholder = @"senha";
        [self.loginButton setTitle:@"Conecte-Se" forState:UIControlStateNormal];
        [self.olvideMiContrasena setTitle:@"Esqueci minha senha" forState:UIControlStateNormal];
        camposVacios = @"Os campos usuário e senha não pode estar vazio";
        contrasenaInvalida = @"Nome de usuário ou senha inválida";
        conexionPerdida = @"Não é possível se conectar ao servidor , por favor, tente mais tarde";
        [self.recuperarButton setTitle:@"Recuperar" forState:UIControlStateNormal];
        [self.regresarButton setTitle:@" De Volta" forState:UIControlStateNormal];
        self.ingresaCorreoLabel.text = @"Digite seu e-mail para redefinir sua senha";
        self.enviadoLabel.text = @"FOI ENVIADO UM EMAIL COM SUA SENHA PARA:";
        correoInvalido = @"E-mail inválido";
    }
    
}


-(void)replayMovie:(NSNotification *)notification
{
    [moviePlayer play];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //Mover hacia arriba loginConteiner cuando comience a editarse en el textfield
    if (flagUp == 0) {
     
        _loginConteiner.duration = 0.6;
        _loginConteiner.delay    = 0;
        _loginConteiner.type     = CSAnimationTypeSlideDownReverse;

        [_loginConteiner startCanvasAnimation];
        flagUp ++;
        flagDown = 0;
        
    }

}


-(void)viewDidAppear:(BOOL)animated{

    if ([appDelegate.userSession.settings boolForKey:@"logged"])
    {
        NSLog(@"Logged");
        appDelegate.userSession.sesionID = [appDelegate.userSession.settings objectForKey:@"sessid"];
        [moviePlayer stop];
        [self performSegueWithIdentifier: @"logged" sender: self];
    }


}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    [_correoTexField resignFirstResponder];
    
    _loginConteiner.duration = 0.6;
    _loginConteiner.delay    = 0;
    _loginConteiner.type     = CSAnimationTypeSlideDown;
    
    [_loginConteiner startCanvasAnimation];
    flagUp = 0;
    flagDown++;
    
    return YES;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    [_correoTexField resignFirstResponder];
 
 
    if (flagDown == 0) {
 
        _loginConteiner.duration = 0.6;
        _loginConteiner.delay    = 0;
        _loginConteiner.type     = CSAnimationTypeSlideDown;
 
        [_loginConteiner startCanvasAnimation];
        flagDown++;
        flagUp = 0;
 
    }
 
}




- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}




- (IBAction)loginButton:(id)sender {
    
    //recogemos los datos ingresados por el usuario para despues mandarlos al servidor
    NSString *username = _userName.text;
    NSString *password = _password.text;
    

    if (_userName.text.length == 0 || _password.text.length ==0) {
        
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Error" message:camposVacios delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
        
    }else{
        
        NSString *lang;
        if ([[appDelegate.userSession.settings objectForKey:@"lang"] length] == 0 ) {
            lang = @"en";
        }else lang = [appDelegate.userSession.settings objectForKey:@"lang"];

        
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSDictionary *parameters = @{
                                         @"username"    : username,
                                         @"password"    : password,
                                         @"opt"         : @"login",
                                         @"lang"        : lang
                                     
                                         };
            [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"RESPUESTA: %@",responseObject);
            if ([[responseObject objectForKey:@"error"]  isEqual: @"incorrect_access"]) {
                UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Error" message:contrasenaInvalida delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alerta show];
                
                
            }else if ([responseObject objectForKey:@"sessid"]){
                
                NSLog(@"Este es el session ID: %@",[responseObject objectForKey:@"sessid"]);
                //mostramos la siguiente pantalla si la conexion fue exitosa
                SWRevealViewController *reveal = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                [appDelegate.userSession.settings setObject:[responseObject valueForKey:@"sessid"] forKey:@"sessid"];
                [appDelegate.userSession.settings setBool:YES forKey:@"logged"];
                appDelegate.userSession.sesionID = [appDelegate.userSession.settings objectForKey:@"sessid"];
                appDelegate.userSession.userID = [responseObject objectForKey:@"userid"];
                appDelegate.userSession.lenguaje = [responseObject objectForKey:@"lang"];
                NSLog(@"SessionID de la calse Session: %@",appDelegate.userSession.sesionID);
                NSLog(@"UserID de la calse Session: %@",appDelegate.userSession.userID);
                NSLog(@"Lenguaje de la calse Session: %@",appDelegate.userSession.lenguaje);
                [self presentViewController:reveal animated:YES completion:nil];
                
                //terminamos la reproduccion del video
                [moviePlayer stop];
                
                //regresamos los campos a su posicion por defecto
                if (flagDown == 0) {
                    
                    _loginConteiner.duration = 0.6;
                    _loginConteiner.delay    = 0;
                    _loginConteiner.type     = CSAnimationTypeSlideDown;
                    
                    [_loginConteiner startCanvasAnimation];
                    flagDown++;
                    flagUp = 0;
                    
                    }
                
                
                }
            
            }
         
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
                  NSLog(@"Error: %@",error);
                  UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Error" message:conexionPerdida delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                  [alerta show];
                  
              }];
    

    }


 
}




- (IBAction)olvideMiContrasenaButton:(id)sender {
    
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    
    if (_ingresaCorreoLabel.hidden == YES) {
        _ingresaCorreoLabel.hidden = NO;
        _correoTexField.hidden = NO;
        _recuperarButton.hidden = NO;
        
        _enviadoLabel.hidden = YES;
        _enviadoCorreoLabel.hidden = YES;
        
        _correoTexField.text = @"";
        
    }
    _olvideMiContrasenaBlurView.hidden = NO;
    
    
    self.olvideMiContrasenaBlurView.alpha = 0;
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations:^{
        
        self.olvideMiContrasenaBlurView.alpha = 1;
    } completion:^(BOOL finished) { }];
    
    
    

    
    
}

- (IBAction)regresarButton:(id)sender {
    
    //_olvideMiContrasenaBlurView.hidden = YES;
    
    self.olvideMiContrasenaBlurView.alpha = 1;
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations:^{
        
        self.olvideMiContrasenaBlurView.alpha = 0;
    } completion:^(BOOL finished) { }];

    
        

    
    
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    [_correoTexField resignFirstResponder];
    _correoTexField.text = @"";
}

- (IBAction)recuperarButton:(id)sender {
    NSLog(@"mail : %@",_correoTexField.text);
    //NSURL *email = [NSURL URLWithString:_correoTexField.text];
    NSString *encoded = [_correoTexField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"mail Encoded: %@",encoded);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"email"   : encoded,
                                 @"opt"     : @"recover_password"
                                 };
    //[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager POST:appDelegate.userSession.Url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSLog(@"JSON: %@",responseObject);
        if ([[responseObject objectForKey:@"status"]  isEqual: @"ok"]) {
            _ingresaCorreoLabel.hidden = YES;
            _correoTexField.hidden = YES;
            _recuperarButton.hidden = YES;
            _enviadoLabel.hidden = NO;
            _enviadoCorreoLabel.hidden = NO;
            _enviadoCorreoLabel.text = _correoTexField.text;
        }
        if ([[responseObject objectForKey:@"error"]  isEqual: @"El usuario no existe."]){
        
            UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"" message:correoInvalido delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alerta show];
        
        }
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"Error: %@",error);
              
          }];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

   
}
@end
