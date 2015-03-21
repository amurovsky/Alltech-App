//
//  session.h
//  Alltech
//
//  Created by Tejuino developers on 04/03/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface session : NSObject

@property (nonatomic, strong) NSString *sesionID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *lenguaje;
@property (nonatomic, strong) NSString *programaID;
@property (nonatomic, strong) NSString *productoID;
@property (nonatomic, strong) NSString *especieID;
@property (nonatomic, strong) NSString *Url;
@property (nonatomic, strong) NSUserDefaults *settings;
@property (nonatomic, strong) NSMutableArray *selectedImages;



@end



