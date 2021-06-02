//
//  LeftImageTableViewCell.h
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import <UIKit/UIKit.h>
#import "MacroDefine.h"
#import "ImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LeftImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *gifMarkLab;
@property (weak, nonatomic) IBOutlet SDAnimatedImageView *leftImageView;

@property (strong, nonatomic) ImageListModel *imageListModel;
@end

NS_ASSUME_NONNULL_END
