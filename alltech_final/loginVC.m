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
#import <AVFoundation/AVFoundation.h>


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



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // find movie file
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"m4v"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    moviePlayer.controlStyle = MPMovieControlStyleNone;
    moviePlayer.view.frame = self.view.frame;
    moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    [self.view addSubview:moviePlayer.view];
    [self.view sendSubviewToBack:moviePlayer.view];
    [moviePlayer play];
    
    // loop movie
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(replayMovie:)
                                                 name: MPMoviePlayerPlaybackDidFinishNotification
                                               object: moviePlayer];
    
    
    //Video en el background por medio de gift
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"railway" ofType:@"gif"];
//    NSData *gif = [NSData dataWithContentsOfFile:filePath];
//    
//    NSLog(@"este es el frame del View: %@",NSStringFromCGRect(self.view.frame));
//    UIWebView *webViewBG = [[UIWebView alloc] initWithFrame:self.view.frame];
//    [webViewBG loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    webViewBG.userInteractionEnabled = NO;
//    webViewBG.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view insertSubview:webViewBG atIndex:0];
//    
//    UIView *filter = [[UIView alloc] initWithFrame:self.view.frame];
//    filter.backgroundColor = [UIColor blackColor];
//    filter.alpha = 0.05;
//    [self.view insertSubview:filter atIndex:1];
    
    
    // Sacar Dimensiones de la pantalla
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    //Declaramos como delegados de los UITexField a ellos mismos
    _userName.delegate = self;
    _password.delegate = self;

    
    //Ponemos  en el background la imagen de fondo
    //UIImage *backgroundImage;
    
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
        _correoTexField.font = [UIFont fontWithName:@"Aileron-Bold" size:30.0];
        [_recuperarButton.titleLabel setFont:[UIFont fontWithName:@"Aileron-Bold" size:30.0]];
        
        
        imageView.frame = CGRectMake(0, 80, screenWidth, 80);
    }
    
    // iphone 6
    else if (screenWidth ==375 && screenHeight == 667){
    
        //backgroundImage = [UIImage imageNamed:@"fondo_iphone_conLogo"];
    
        imageView.frame = CGRectMake(0, 80, screenWidth, 40);
    }
    
    // iphone 5, 5c, 5s, touch 5
    else if (screenWidth == 320 && screenHeight == 568){
        
        imageView.frame = CGRectMake(0, 80, screenWidth, 30);
        
        
    }
    
    // iphone 4, 4s, touch 4
    else if (screenWidth == 320 && screenHeight == 480){
        
        imageView.frame = CGRectMake(0, 80, screenWidth, 20);
        
        
    }

        
    

    
    
    //UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    //backgroundImageView.image=backgroundImage;
    
    
    //Animacion de logo Alltech
    
    CSAnimationView *animationView = [[CSAnimationView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, 40)];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.duration = 1;
    animationView.delay    = 0;
    animationView.type     = CSAnimationTypeFadeIn;
    [self.view insertSubview:animationView aboveSubview:moviePlayer.view];
    // Add your subviews into animationView
    [animationView addSubview:imageView];
    // Kick start the animation immediately
    [animationView startCanvasAnimation];
    

    
    
    

   
    
   
//    Evento que detecta cuando se hizo tap en el background
//    UITapGestureRecognizer *reconoceTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
//    
//    reconoceTap.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:reconoceTap];
    
    
//    //Accion mover hacia arriba UIview cuando el teclado este activo
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

 //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
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


// implementacion del metodo tap en el background
//-(void)handleBackgroundTap:(UITapGestureRecognizer *)sender
//{
//    [_userName resignFirstResponder];
//    [_password resignFirstResponder];
//    [_correoTexField resignFirstResponder];
//
//    if (flagDown == 0) {
//
//        _loginConteiner.duration = 0.6;
//        _loginConteiner.delay    = 0;
//        _loginConteiner.type     = CSAnimationTypeSlideDown;
//    
//        [_loginConteiner startCanvasAnimation];
//        flagDown++;
//        flagUp = 0;
//
//    }
//}


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





//////////////////////////////    Funciones que detectan cuando Aparece y desaparece el teclado /////////////////////////////////////////////
//- (void)keyboardDidShow:(NSNotification *)notification {
//    
//    
//    if ([[UIScreen mainScreen] bounds].size.height == 568) {
//        
//        
//        /*
//        
//        [UIView animateWithDuration:0.3
//                         animations:^{ [_userName setFrame:CGRectMake(60, 190, 200, 40)]; } ];
//        
//        [UIView animateWithDuration:0.3
//                         animations:^{ [_password setFrame:CGRectMake(60, 240, 200, 40)]; } ];
//        
//        [UIView animateWithDuration:0.3
//                         animations:^{ [_loginButton setFrame:CGRectMake(60, 290, 200, 40)]; } ];
//        
//         */
//        
////        [UIView animateWithDuration:2.0
////                         animations:^{ [self.view setFrame:CGRectMake(0, 0, 320, 380)]; } ];
//        
//        
//        
//
//    
//    }
//    
//    else {
//        
////            [UIView animateWithDuration:2.0
////                             animations:^{ [self.view setFrame:CGRectMake(0, 0, 375, 460)]; } ];
//        
//        //[self.loginConteiner setFrame:CGRectMake(0, 0, 375, 460)];
//        
//        
////        CGRect myFrame = [self.loginConteiner frame];
////        NSLog(@"height = %f", myFrame.size.height);
////        NSLog(@"width = %f", myFrame.size.width);
////        NSLog(@"x = %f", myFrame.origin.x);
////        NSLog(@"y = %f", myFrame.origin.y);
////        
////        //_loginConteiner.backgroundColor = [UIColor whiteColor];
////        
////        _loginConteiner.duration = 0.6;
////        _loginConteiner.delay    = 0;
////        _loginConteiner.type     = CSAnimationTypeSlideDownReverse;
////        
////        
////        // Add your subviews into animationView
////        //[animationView addSubview:_loginConteiner];
////        
////        // Kick start the animation immediately
////        [_loginConteiner startCanvasAnimation];
//        
//        }
//    
//}
//
//
//
//-(void)keyboardDidHide:(NSNotification *)notification{
//
//    _loginConteiner.duration = 0.6;
//    _loginConteiner.delay    = -3;
//    _loginConteiner.type     = CSAnimationTypeSlideDown;
//    
//    [_loginConteiner startCanvasAnimation];
//    flagUp = 0;
//    
//    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




- (IBAction)loginButton:(id)sender {
    
    /*
     
     NSString *admin =@"admin";
     NSString *password =@"password";
     
     
     if(_userName.text != admin && _password.text != password){
     
     UIAlertView * alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Usuario o Contraseña Incorrecto.!" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
     [alerta show];
     }
     
    */
    
    [moviePlayer stop];
    
    if (flagDown == 0) {
        
        _loginConteiner.duration = 0.6;
        _loginConteiner.delay    = 0;
        _loginConteiner.type     = CSAnimationTypeSlideDown;
        
        [_loginConteiner startCanvasAnimation];
        flagDown++;
        flagUp = 0;
        
    }
    
}

//////////////////////////////// Metodo que captura la pantalla para despues hacer un fondo con efecto blur en otro view.////////////////////////////////

//- (void) captureBlur {
//    
//    /*
//    //Get a UIImage from the UIView
//    NSLog(@"blur capture");
//    UIGraphicsBeginImageContext(self.view.bounds.size);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    */
//    
//    UIImage *backgroundImage = [UIImage imageNamed:@"fondo_iphone_conLogo"];
//    
//    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
//    backgroundImageView.image=backgroundImage;
//    
//    //Blur the UIImage
//    CIImage *imageToBlur = [CIImage imageWithCGImage:backgroundImage.CGImage];
//    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
//    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
//    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: 10] forKey: @"inputRadius"];
//    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
//    
//    //create UIImage from filtered image
//    UIImage* blurrredImage = [[UIImage alloc] initWithCIImage:resultImage];
//    
//    //Place the UIImage in a UIImageView
//    UIImageView *newView = [[UIImageView alloc] initWithFrame:CGRectMake(-15, -10, screenWidth+30, screenHeight+20)];
//    newView.image = blurrredImage;
//    
//    //insert blur UIImageView below transparent view inside the blur image container
//    [_olvideMiContrasenaBlurView insertSubview:newView atIndex:0];
//}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




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
    
    
    
//    [self captureBlur];
//    
//    //[self dismissViewControllerAnimated:YES completion:nil];
//    [UIView animateWithDuration:0.3 animations:^{
//        _olvideMiContrasenaBlurView.alpha = 1.0;
//       
//    }];
    
    
    
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
}

- (IBAction)recuperarButton:(id)sender {
    
    
    _ingresaCorreoLabel.hidden = YES;
    _correoTexField.hidden = YES;
    _recuperarButton.hidden = YES;
    
    _enviadoLabel.hidden = NO;
    _enviadoCorreoLabel.hidden = NO;
    
    
    _enviadoCorreoLabel.text = _correoTexField.text;
    
    
}

@end
