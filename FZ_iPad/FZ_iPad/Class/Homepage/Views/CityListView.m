//
//  CityListView.m
//  FZ_iPad
//
//  Created by Jeemy on 16/9/10.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "CityListView.h"
#import "HomeVC.h"
@interface CityListView()
@property (nonatomic ,strong)UIImageView *imgV;
@property (nonatomic ,assign)int btnTag;
@property (nonatomic ,strong)HomeVC *homeVC;

@property (nonatomic ,strong)NSArray *cityArray;
@end

@implementation CityListView


-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
//        self.userInteractionEnabled=YES;
        self.imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cityBg"]];
        self.imgV.frame=frame;
        self.imgV.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor darkGrayColor];
        self.alpha=0.8;
        self.frame=CGRectMake(0, 64, UIScreenSize.width, UIScreenSize.height-44);
        //配置城市信息
        [self cityList];
        
        [self addSubview:self.imgV];
        
        //添加手势操作
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        tap1.cancelsTouchesInView = YES;
//        [self addGestureRecognizer:tap1];
    
    }
    
    return self;
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    self.homeVC = [[HomeVC alloc]init];
    self.delegate=self.homeVC;
    
    
//    JSLog(@"点击了没有");
   
    if (self.delegate) {
//        JSLog(@"进入代理");
        [self.delegate hideMenu];
    }
    
}


/**
 *城市排列
 */
-(void)cityList{
    CGFloat width=(self.imgV.width-6*self.imgV.width*0.08)/5;
    CGFloat heigh=40;
    CGFloat interval=self.imgV.width*0.08;
    self.cityArray=@[@"重庆",@"天津",@"北京",@"重庆",@"重庆",@"重庆",@"重庆",@"重庆",@"重庆",
                         @"重庆",@"重庆",@"广东",@"南川",@"俄罗斯",@"重庆",@"纽约",@"巴西",@"美国"];
    
    
    for (int i=0; i<self.cityArray.count; i++) {
        // 计算行号  和   列号
        int row = i / 5;
        int col = i % 5;
        //根据行号和列号来确定 子控件的坐标
        CGFloat cityX = interval + col * (width + interval);
        CGFloat cityY = 84+row * (heigh + interval);
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(cityX, cityY, width, heigh)];
        [btn setTitle:self.cityArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:JSColor(55, 55, 55) forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        btn.backgroundColor = JSRandomColor ;
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=3;
        btn.layer.borderColor=[UIColor darkGrayColor].CGColor;
        btn.layer.borderWidth=0.8;
        btn.tag=i;
        
        [self.imgV addSubview:btn];
        
        [btn addTarget:self action:@selector(choiceCity:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
-(void)choiceCity:(UIButton *)btn{
//    self.homeVC = [[HomeVC alloc]init];
//    self.delegate=self.homeVC;
//    
    
    [self.delegate choiceCity:self.cityArray[btn.tag]];
    
    
    [JSNotificationCenter postNotificationName:@"CityChoice" object:self.cityArray[btn.tag]];
//    JSLog( @"选择了这个城市:%@",self.cityArray[btn.tag]);

}






@end
