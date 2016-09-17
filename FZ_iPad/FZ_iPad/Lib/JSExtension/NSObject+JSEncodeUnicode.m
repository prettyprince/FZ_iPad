//
//  NSString+JSEncodeUnicode.m
//  WoYaoSai
//
//  Created by Jeemy on 15/12/7.
//  Copyright © 2015年 icenoie. All rights reserved.
//

#import "NSObject+JSEncodeUnicode.h"

@implementation NSObject(JSEncodeUnicode)

/**
 *给有unicode编码的转换成中文样式
 */
- (NSString *)replaceUnicode {
//    JSLog(@"self=%@",self);
    NSString *str=[NSString stringWithFormat:@"%@",self];
    NSString *tempStr1 = [str stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

@end
