//
//  KYTool.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/8.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYTool.h"

@implementation KYTool
+ (NSString *)sizeToString:(NSInteger)size
{
    CGFloat unit=1000.0;
    NSString * sizeStr=nil;
    if (size >= unit * unit * unit) {//大于1GB
        sizeStr=[NSString stringWithFormat:@"%.1fGB",size/unit/ unit / unit];
    }else if (size >= unit * unit){//大于1MB
        sizeStr=[NSString stringWithFormat:@"%.1fMB",size/unit/unit];
    }else if (size >= unit){//大于1KB
        sizeStr=[NSString stringWithFormat:@"%.1fKB",size/unit];
    }else{
        sizeStr=[NSString stringWithFormat:@"%.zdB",size];
    }
    return sizeStr;
}
@end
