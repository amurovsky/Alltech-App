//
//  sideMenuVC.h
//  Alltech
//
//  Created by Tejuino developers on 05/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface sideMenuVC : UIViewController <UITableViewDataSource, UITableViewDelegate,MWPhotoBrowserDelegate>{

    NSMutableArray *_selections;
}

@property (weak, nonatomic) IBOutlet UITableView *sideMenuTable;

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) NSMutableArray *assets;

- (void)loadAssets;


@end
