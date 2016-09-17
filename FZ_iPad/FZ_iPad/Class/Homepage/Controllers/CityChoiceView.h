//
//  CityChoiceView.h
//  FZ_iPad
//
//  Created by Jeemy Tim Miller on 16/9/17.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityChoiceView : UIView

-(id)initWithFrame:(CGRect)frame;
-(void)displayView:(UIView*)view;
@property (nonatomic ,strong)UIView *containView;
@end
