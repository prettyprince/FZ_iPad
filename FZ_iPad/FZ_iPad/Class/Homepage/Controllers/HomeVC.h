//
//  HomeNavController.h
//  FZ_iPad
//
//  Created by Jeemy on 16/9/9.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SINavigationMenuView.h"
#import "MenuView.h"
#import "CityListView.h"
#import "HousesStyleVC.h"
#import "HomeModelData.h"


@interface HomeVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,SINavigationMenuDelegate,MenuViewDelegate,CityListViewDelegate>

@property (strong, nonatomic)UICollectionView *collectionView;

@property (nonatomic ,strong)HomeModelData *homeModelData;

@end

