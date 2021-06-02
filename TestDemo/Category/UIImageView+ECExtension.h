//
//  UIImageView+ECExtension.h
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import <UIKit/UIKit.h>
#import "MacroDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ECExtension)

- (void)setImageUrl:(NSString *)url placeholderImage:(NSString *)imageName completed:(void(^)(UIImage * _Nullable image))completedHandle;

@end

NS_ASSUME_NONNULL_END
