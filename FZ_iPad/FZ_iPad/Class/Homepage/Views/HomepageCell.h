//
//  HomepageCell.h
//  FZ_iPad
//
//  Created by Jeemy on 16/9/12.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModelData.h"
@interface HomepageCell : UICollectionViewCell

@property (nonatomic ,strong)HomeModelData *homeModelData;

@property (nonatomic ,copy)NSString *imgStr;
@property(strong,nonatomic) UIImageView *imageView;
@property (nonatomic ,strong)NSMutableArray *mutableArray;
@property (nonatomic ,strong)UILabel *titleLbl;
@end
