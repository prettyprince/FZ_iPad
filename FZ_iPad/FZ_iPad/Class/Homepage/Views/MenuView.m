//
//  MenuView.m
//  FZ_iPad
//
//  Created by Jeemy on 16/9/10.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "MenuView.h"

@interface MenuView  ()<CityListViewDelegate>
@property (nonatomic ,strong)CityListView *cityV;


@end

@implementation MenuView

-(void)choiceCity:(NSString *)city{
    self.isActive=!self.isActive;
//    [KVNProgress showSuccessWithStatus:city];
    [self onHideMenu];
}
-(void)setTitle:(NSString *)title{
    [self.btn setTitle:title forState:UIControlStateNormal];
}

-(id)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)img{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        frame.origin.y += 1.0;
        self.btn=[[UIButton alloc]initWithFrame:frame];
        [self.btn setTitle:title forState:UIControlStateNormal];
        self.btn.titleLabel.font=[UIFont systemFontOfSize:20];
//        btn.backgroundColor=[UIColor blueColor];
        self.btn.titleLabel.textColor=[UIColor blackColor];
        self.btn.imageView.image=[UIImage imageNamed:@"location"];
        [self.btn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];//给button添加image
        self.btn.imageEdgeInsets = UIEdgeInsetsMake(0,5,0,30);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    
        self.btn.titleLabel.textAlignment = NSTextAlignmentRight;//设置title的字体居中
        [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
        [self.btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
        self.btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
        
        [self.btn addTarget:self action:@selector(showOrHideMenu) forControlEvents:UIControlEventTouchUpInside];
        
       
        
       

       
        [self addSubview:self.btn];
        
    }
    return self;
}

-(void)showOrHideMenu{
    JSLog(@"点击");
//    self.cityV.delegate=self;
    
    [self.delegate didSelectItemAtIndex:2];
    self.isActive=!self.isActive;
    if (self.isActive) {
        NSLog(@"On show");
        
        [self onShowMenu];
    } else {
        NSLog(@"On hide");
        [self onHideMenu];
    }
}
#pragma cityviewDelegate



- (void)hideMenu{
    JSLog(@"触发了代理事件;");
}


- (void)onShowMenu
{

    JSLog(@"打开菜单");
    UIImageView *imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cityBg"]];
    self.cityV=[[CityListView alloc]initWithFrame:CGRectMake(UIScreenSize.width/2-imgV.bounds.size.width/2,0, imgV.bounds.size.width, imgV.bounds.size.height)];
    self.cityV.delegate=self;
    
    [self.superview.superview addSubview:self.cityV];
 
}


- (void)onHideMenu
{
    if (self.cityV) {
        [self.cityV removeFromSuperview];
    }
//    JSLog(@"关闭菜单");
}



#pragma mark -
#pragma mark Handle taps

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    JSLog(@"isactive=%d",self.isActive);
//    self.isActive = !self.isActive;
//}


-(void)displayMenuInView:(UIView *)view{
    
}
@end
