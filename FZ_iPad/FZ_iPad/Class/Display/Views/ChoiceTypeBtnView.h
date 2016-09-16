//
//  ChoiceTypeBtnView.h
//  FZ_iPad
//
//  Created by Jeemy on 16/9/12.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoiceTypeBtnViewDelegate <NSObject>

-(void)changeMaterialTBV:(NSString *)typeName;
@end

@interface ChoiceTypeBtnView : UIView
- (id)initWithFrame:(CGRect)frame;

@property (nonatomic ,strong)NSArray *btnArray;
@property (nonatomic ,assign)id<ChoiceTypeBtnViewDelegate> delegate;
@end
