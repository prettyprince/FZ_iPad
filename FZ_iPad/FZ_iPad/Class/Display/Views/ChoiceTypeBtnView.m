//
//  ChoiceTypeBtnView.m
//  FZ_iPad
//
//  Created by Jeemy on 16/9/12.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "ChoiceTypeBtnView.h"
@interface ChoiceTypeBtnView()
@property (nonatomic ,assign)BOOL isSelected;

@end
@implementation ChoiceTypeBtnView

-(id)initWithFrame:(CGRect)frame{
   self= [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.frame=frame;
        self.backgroundColor=JSColor(23, 23, 23);
        
        [self setBtn];
    }
    return self;
}


/**
 *设置按钮
 */
-(void)setBtn{
    self.btnArray=@[@"窗帘",@"地板",@"墙壁"];
    
    
    for (int i=0;i<self.btnArray.count;i++) {
        
        CGFloat interval=self.width*0.2;
        CGFloat btnW=self.width-2*interval;
        CGFloat btnH=45;
        CGFloat btnX=interval;
        CGFloat btnY=230+btnH*i+interval*i;
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY,btnW, btnH)];
        btn.backgroundColor=JSColor(23, 23, 23);
        btn.userInteractionEnabled= YES;
        [btn setTitle:self.btnArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:JSColor(255, 255, 255) forState:UIControlStateNormal];
        [btn setTitleColor:JSColor(144, 144, 144) forState:UIControlStateHighlighted];
        [btn setTitleColor:JSColor(144, 144, 144) forState:UIControlStateSelected];

        UIImageView *imgBackV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, btn.width, btn.height)];
        imgBackV.backgroundColor=[UIColor greenColor];
        [btn setImage:imgBackV.image forState:UIControlStateSelected];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=8;
        btn.layer.borderWidth=1.5;
        btn.alpha=0.5;
        btn.layer.borderColor=JSColor(155, 155, 155).CGColor;
        btn.tag=i;
        btn.keyValues=@{@"curtain":@""};
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)clickBtn:(UIButton *)btn{
    self.isSelected=!self.isSelected;
    NSString *intId=[NSString stringWithFormat:@"%ld",btn.tag];
    
    //获取所有按钮，点击的按钮改变颜色(可以创建一个view放button);
    for (id obj  in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *theBtn=(UIButton *)obj;
            if (theBtn.tag==btn.tag) {//假如点到了这个数字的按钮
                theBtn.backgroundColor=[UIColor greenColor];
            }else{//
                theBtn.backgroundColor=[UIColor blackColor];
            }
        }
    }

    /**
     *设置代理
     */
    if (self.delegate) {
        [self.delegate changeMaterialTBV:intId];
    }
    
}
@end
