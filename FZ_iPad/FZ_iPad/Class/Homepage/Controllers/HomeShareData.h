//
//  HomeShareData.h
//  FZ_iPad
//
//  Created by Jeemy Tim Miller on 16/9/17.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeShareData : NSObject
@property (nonatomic ,assign)BOOL isClicked;
+(HomeShareData *)shareData;
@end
