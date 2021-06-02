//
//  MultiImageTableViewCell.h
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import <UIKit/UIKit.h>
#import "MacroDefine.h"
#import "ImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MultiImageTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *multiImageCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *imageLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *multiImageCollectionViewLayoutH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *multiImageCollectionViewLayoutTop;

@property (strong, nonatomic) ImageListModel *imageListModel;
@property (assign, nonatomic) BOOL isPauseGif;
@end

NS_ASSUME_NONNULL_END
