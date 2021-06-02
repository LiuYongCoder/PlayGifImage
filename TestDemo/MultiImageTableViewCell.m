//
//  MultiImageTableViewCell.m
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#define AtlasImageViewWidth      (SCREEN_WIDTH - 30 - 10 * 2) / 3
#define AtlasTwoOrFourImageViewWidth      (SCREEN_WIDTH - 30 - 10) / 2
#define AtlasImageViewHeight     88
#define AtlasImageViewCellSpace     10

#import "MultiImageTableViewCell.h"
#import "MultiImageCollectionViewCell.h"
@interface MultiImageTableViewCell ()
@property (assign, nonatomic) NSInteger currentPlayIndex;
@end

@implementation MultiImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _currentPlayIndex = 0;
    
    _multiImageCollectionView.delegate = self;
    _multiImageCollectionView.dataSource = self;
    [_multiImageCollectionView registerNib:[UINib nibWithNibName:@"MultiImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MultiImageCollectionViewCell"];
    _imageLayout.minimumLineSpacing = AtlasImageViewCellSpace;
    _imageLayout.minimumInteritemSpacing = AtlasImageViewCellSpace;
    _imageLayout.itemSize = CGSizeMake(AtlasImageViewWidth, AtlasImageViewHeight);
}

- (void)setImageListModel:(ImageListModel *)imageListModel
{
    _imageListModel = imageListModel;
    
    // 图片  15是view底部距  10是cell间距
    if (_imageListModel.imageList.count == 0) {
        _multiImageCollectionViewLayoutH.constant = 0;
        _multiImageCollectionViewLayoutTop.constant = 0;
    } else if (_imageListModel.imageList.count == 1) {
        CGFloat imageH = (SCREEN_WIDTH - 30) * 9 / 16;
        _multiImageCollectionViewLayoutH.constant = imageH;
        _imageLayout.itemSize = CGSizeMake(SCREEN_WIDTH - 30, imageH);
    } else if (_imageListModel.imageList.count == 2) {
        _multiImageCollectionViewLayoutH.constant = AtlasTwoOrFourImageViewWidth;
        _imageLayout.itemSize = CGSizeMake(AtlasTwoOrFourImageViewWidth, AtlasTwoOrFourImageViewWidth);
    } else if (_imageListModel.imageList.count < 4) {
        _multiImageCollectionViewLayoutH.constant = AtlasImageViewHeight;
        _imageLayout.itemSize = CGSizeMake(AtlasImageViewWidth, AtlasImageViewHeight);
    } else if (_imageListModel.imageList.count == 4) {
        _multiImageCollectionViewLayoutH.constant = AtlasTwoOrFourImageViewWidth * 2 + AtlasImageViewCellSpace;
        _imageLayout.itemSize = CGSizeMake(AtlasTwoOrFourImageViewWidth, AtlasTwoOrFourImageViewWidth);
    } else if (_imageListModel.imageList.count < 7) {
        _multiImageCollectionViewLayoutH.constant = AtlasImageViewHeight * 2 + AtlasImageViewCellSpace;
        _imageLayout.itemSize = CGSizeMake(AtlasImageViewWidth, AtlasImageViewHeight);
    } else {
        _multiImageCollectionViewLayoutH.constant = AtlasImageViewHeight * 3 + AtlasImageViewCellSpace;
        _imageLayout.itemSize = CGSizeMake(AtlasImageViewWidth, AtlasImageViewHeight);
    }
    [_multiImageCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageListModel.imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MultiImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MultiImageCollectionViewCell" forIndexPath:indexPath];
    ImageModel *imageModel = _imageListModel.imageList[indexPath.row];
    
    [cell.multiImageView setImageUrl:NONullString(imageModel.imageUrl) placeholderImage:@"" completed:^(UIImage * _Nullable image) {
        imageModel.isGif = image.sd_isAnimated;
        cell.gifMarkLab.hidden = !image.sd_isAnimated;
    }];
    
    //禁止自动播放，否则会导致全部gif自动播放一遍
    cell.multiImageView.autoPlayAnimatedImage = NO;

    return cell;
}

- (void)setIsPauseGif:(BOOL)isPauseGif
{
    _isPauseGif = isPauseGif;
    if (_imageListModel.imageList.count == 0) {
        return;
    }
    if (_isPauseGif) {
        [self pauseCurrentImageViewPlay];
    } else {
        [self playCurrentImageViewPlay];
    }
}

- (void)pauseCurrentImageViewPlay
{
    NSIndexPath *imageIndexpath = [NSIndexPath indexPathForRow:_currentPlayIndex inSection:0];
    MultiImageCollectionViewCell *imageCell = (MultiImageCollectionViewCell *)[_multiImageCollectionView cellForItemAtIndexPath:imageIndexpath];
    ImageModel *mModel = _imageListModel.imageList[_currentPlayIndex];
    if (mModel.isGif) {
        [imageCell.multiImageView.player pausePlaying];
        imageCell.gifMarkLab.hidden = NO;
    }
}

- (void)playCurrentImageViewPlay
{
    // 开始下一个播放
    NSIndexPath *currentIndexpath = [NSIndexPath indexPathForRow:_currentPlayIndex inSection:0];
    MultiImageCollectionViewCell *currentCell = (MultiImageCollectionViewCell *)[_multiImageCollectionView cellForItemAtIndexPath:currentIndexpath];
    ImageModel *currentModel = _imageListModel.imageList[_currentPlayIndex];
    KWeakSelf
    if (currentModel.isGif) {
        [currentCell.multiImageView.player startPlaying];
        currentCell.gifMarkLab.hidden = YES;
        currentCell.multiImageView.player.animationLoopHandler = ^(NSUInteger loopCount) {
            [currentCell.multiImageView.player stopPlaying];
            currentCell.gifMarkLab.hidden = NO;
            weakSelf.currentPlayIndex = weakSelf.currentPlayIndex < (weakSelf.imageListModel.imageList.count - 1) ? (++weakSelf.currentPlayIndex) : 0;
            [self playCurrentImageViewPlay];
        };
    } else {
        _currentPlayIndex = _currentPlayIndex < (_imageListModel.imageList.count - 1) ? (++_currentPlayIndex) : 0;
        [self playCurrentImageViewPlay];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
