//
//  repositoriodeAlbums.h
//  Alltech
//
//  Created by Jose Esteban Garibay Castillo on 17/03/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface repositoriodeAlbums : NSObject

@property (nonatomic, strong) NSMutableArray * albums;

+(repositoriodeAlbums *) sharedInstance;
-(void)leer;
-(void)guardar;
-(NSString *) ruta;

@end
