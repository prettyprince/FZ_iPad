//
//  CityChoiceView.m
//  FZ_iPad
//
//  Created by Jeemy Tim Miller on 16/9/17.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "CityChoiceView.h"
@interface CityChoiceView()<UIGestureRecognizerDelegate>
@property (nonatomic ,strong )UIView *cityListView;
@property (nonatomic ,assign)BOOL isClicked;

@end

@implementation CityChoiceView

-(void)setContainView:(UIView *)containView{
    _containView=containView;

    
}
-(void)displayView:(UIView *)view{
   /*
    self.containView=view;
    self.containView.frame=CGRectMake(300, 50, 100, 400);
    self.containView.backgroundColor=[UIColor blackColor];
    //self.containView.alpha=0.5;
   
    
    */
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;

    self.containView=[[UIView alloc]init];
     self.containView.frame=CGRectMake(400, 50, 60, 460);
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.containView.width, self.containView.height)];
    [btn setTitle:@"测试按钮" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor purpleColor]];
    //[self.containView addSubview:btn];
    
    UIView *vtest=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.containView.width, self.containView.height)]    ;
    vtest.backgroundColor=[UIColor purpleColor];
    [self.containView addSubview:vtest];
    
    //self.containView.center.x=CGRectGetMidX(newFrame);
   
    self.containView.backgroundColor=[UIColor blueColor];
    [self addSubview:self.containView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。

    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];

    
}

- (void)tapGesturedDetected:(UITapGestureRecognizer *)recognizer

{
    JSLog(@".消除消除.");
    // do something
    self.isClicked=!self.isClicked;
    [self removeFromSuperview];

    
}
/**
 *让字视图不响应父视图的手势操作
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.containView]) {
        return NO;
    }
    
    return YES;
    
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=frame;
        self.backgroundColor=[UIColor clearColor];
        
        
        
        
        [self setCityView];
        
    }
    return self;
}

-(void)clickBtn:(UIButton *)btn{
    self.isClicked=!self.isClicked;
    /**
     *做一个城市的view
     */
    [self setCityView];
}
-(void)setCityView{
    if (self.isClicked) {
        JSLog(@"点击按钮");
        self.cityListView=[[UIView alloc]initWithFrame:CGRectMake(UIScreenSize.width-400, 50, 400, UIScreenSize.height-300)];
        self.cityListView.backgroundColor=JSRandomColor;
        [self addSubview:self.cityListView];
        JSLog(@"self.superviewClass=%@",[self.containView class]);
    }else{
        [self removeFromSuperview];
    }

}



@end
