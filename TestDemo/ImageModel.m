//
//  ImageModel.m
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import "ImageModel.h"

@implementation ImageModel

@end

@implementation ImageListModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
        @"imageList" : @"ImageModel"
    };
}

- (BOOL)isHaveGif
{
    for (ImageModel *model in self.imageList) {
        if (model.isGif) {
            return YES;
        }
    }
    return NO;
}

@end
