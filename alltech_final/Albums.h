//
//  Albums.h
//  Alltech
//
//  Created by Jose Esteban Garibay Castillo on 09/03/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Albums : NSObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSString * programa;
@property (nonatomic, retain) NSString * producto;
@property (nonatomic, retain) NSString * especie;
@property (nonatomic, retain) NSString * programaID;
@property (nonatomic, retain) NSString * productoID;
@property (nonatomic, retain) NSString * especieID;
@property (nonatomic, retain) NSMutableArray * imagenes;
@property (nonatomic, retain) NSString * fechaModificacion;


@end
