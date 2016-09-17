//
//  HomepageCell.m
//  FZ_iPad
//
//  Created by Jeemy on 16/9/12.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "HomepageCell.h"

@implementation HomepageCell

-(void)setHomeModelData:(HomeModelData *)homeModelData{
    _homeModelData=homeModelData;
    
    JSLog(@"homeModelData:%@",homeModelData.array);
}
-(void)setImgStr:(NSString *)imgStr{
    JSLog(@"=====imgstr=%@",imgStr);
    _imgStr=imgStr;
    self.titleLbl.text=imgStr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        JSLog(@"进入了collectioncell类");
        self.titleLbl= [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-20, 2000, 20)];
        self.titleLbl.textColor = [UIColor blackColor];
        [self addSubview:self.titleLbl];
 
//        JSLog(@"self.imgStr=%@,self.mutableArray=%@,self.titleLbl=%@",self.imgStr,self.mutableArray,self.titleLbl.text);
   
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3)];
        [self.imageView setUserInteractionEnabled:true];
        [self addSubview:self.imageView];

    }
    return self;
}
@end
