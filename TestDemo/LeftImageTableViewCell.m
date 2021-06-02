//
//  LeftImageTableViewCell.m
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import "LeftImageTableViewCell.h"

@implementation LeftImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageListModel:(ImageListModel *)imageListModel
{
    _imageListModel = imageListModel;
    if (_imageListModel.imageList.count > 0) {
        ImageModel *imageModel = _imageListModel.imageList[0];
        KWeakSelf
        [_leftImageView setImageUrl:NONullString(imageModel.imageUrl) placeholderImage:@"" completed:^(UIImage * _Nullable image) {
            imageModel.isGif = image.sd_isAnimated;
            weakSelf.gifMarkLab.hidden = !image.sd_isAnimated;
        }];
        //禁止自动播放，否则会导致全部gif自动播放一遍
        _leftImageView.autoPlayAnimatedImage = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
