//
//  MultiImageCollectionViewCell.h
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import <UIKit/UIKit.h>
#import "MacroDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface MultiImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SDAnimatedImageView *multiImageView;
@property (weak, nonatomic) IBOutlet UILabel *gifMarkLab;

@end

NS_ASSUME_NONNULL_END
