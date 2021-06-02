//
//  ImageModel.h
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject
@property (strong, nonatomic) NSString *imageUrl;
@property (assign, nonatomic) BOOL isGif;
@end

@interface ImageListModel : NSObject
@property (strong, nonatomic) NSArray *imageList;
@property (assign, nonatomic) BOOL isHaveGif;
@end

NS_ASSUME_NONNULL_END
