//
//  MenuView.h
//  FZ_iPad
//
//  Created by Jeemy on 16/9/10.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListView.h"

@protocol MenuViewDelegate <NSObject>

@optional
- (void)didSelectItemAtIndex:(NSUInteger)index;

@end

@interface MenuView : UIView

@property (nonatomic ,strong)UIButton * btn;
@property (nonatomic ,assign) BOOL isActive;
@property (nonatomic ,assign)id<MenuViewDelegate > delegate;
//@property (nonatomic ,assign)CityListView *cityListV;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)img;
- (void)displayMenuInView:(UIView *)view;
-(void)setTitle:(NSString *)title;

@end
