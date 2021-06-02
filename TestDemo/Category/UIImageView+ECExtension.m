//
//  UIImageView+ECExtension.m
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import "UIImageView+ECExtension.h"

@implementation UIImageView (ECExtension)

- (void)setImageUrl:(NSString *)url placeholderImage:(NSString *)imageName completed:(void(^)(UIImage * _Nullable image))completedHandle{
    if ([url length] == 0) {
        self.image = [UIImage imageNamed:imageName];
    }
    // 判断链接有中文
//    if ([CommonUtils isHasChineseWithStr:url] || [url containsString:@">"] || [url containsString:@" "] || [url containsString:@"?"]) {
//        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    }
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageLowPriority|SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        completedHandle(image);
    }];
}


@end
