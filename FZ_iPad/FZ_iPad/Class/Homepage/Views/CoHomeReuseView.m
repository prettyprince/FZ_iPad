//
//  CoReuseView.m
//  FZ_iPad
//
//  Created by Jeemy Tim Miller on 16/9/17.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "CoHomeReuseView.h"

@implementation CoHomeReuseView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame: frame];
    if(self){
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 300, 20)];
        self.title.textColor = [UIColor blackColor];
        [self addSubview:self.title];
    }
    return self;
}
@end
