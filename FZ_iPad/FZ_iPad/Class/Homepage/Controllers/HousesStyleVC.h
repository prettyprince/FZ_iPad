//
//  HousesStyleVC.h
//  FZ_iPad
//
//  Created by Jeemy on 16/9/11.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayVC.h"
@class DisplayVC;

@interface HousesStyleVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic)UICollectionView *collectionView;

//楼盘名
@property(nonatomic ,copy)NSString *hoursesName;
@property (nonatomic , strong)DisplayVC *displayVC;

@end
