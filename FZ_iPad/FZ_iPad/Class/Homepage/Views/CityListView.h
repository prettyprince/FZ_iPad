//
//  CityListView.h
//  FZ_iPad
//
//  Created by Jeemy on 16/9/10.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"


@protocol CityListViewDelegate <NSObject>

-(void)hideMenu;
-(void)choiceCity:(NSString *) city;

@end

@interface CityListView : UIView

-(id)initWithFrame:(CGRect)frame;

@property (nonatomic ,assign)id<CityListViewDelegate> delegate;

@end
