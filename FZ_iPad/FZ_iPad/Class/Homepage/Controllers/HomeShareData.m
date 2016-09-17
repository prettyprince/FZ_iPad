//
//  HomeShareData.m
//  FZ_iPad
//
//  Created by Jeemy Tim Miller on 16/9/17.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "HomeShareData.h"

@implementation HomeShareData
+(HomeShareData *)shareData
{
    static HomeShareData *shareData = nil;
    
    @synchronized(self)
    {
        if (!shareData)
            shareData = [[HomeShareData alloc] init];
        return shareData;
    }
}

@end
