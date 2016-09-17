//
//  OverallShareData.m
//  FZ_iPad
//
//  Created by Jeemy Tim Miller on 16/9/16.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "OverallShareData.h"

@implementation OverallShareData
+(OverallShareData *)shareData
{
    static OverallShareData *shareData = nil;
    
    @synchronized(self)
    {
        if (!shareData)
            shareData = [[OverallShareData alloc] init];
        return shareData;
    }
}

@end
