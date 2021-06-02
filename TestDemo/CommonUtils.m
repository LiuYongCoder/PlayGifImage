//
//  CommonUtils.m
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import "CommonUtils.h"

@implementation CommonUtils

+ (void)pauseOrPlayCellWithIndex:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath isPause:(BOOL)pause
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[MultiImageTableViewCell class]]) {
        MultiImageTableViewCell *imageCell = (MultiImageTableViewCell *)cell;
        imageCell.isPauseGif = pause;
    } else if ([cell isKindOfClass:[LeftImageTableViewCell class]]) {
        LeftImageTableViewCell *leftCell = (LeftImageTableViewCell *)cell;
        pause ? [leftCell.leftImageView.player pausePlaying] : [leftCell.leftImageView.player startPlaying];
        leftCell.gifMarkLab.hidden = !pause;
    }
}


+ (NSInteger)findCellWithScrollDirection:(BOOL)isScrollDownward currentPlayIndex:(NSInteger)index tableView:(UITableView *)tableView dataMutableArray:(NSMutableArray *)array currentView:(UIView *)view
{
    __block NSInteger lastOrCurrentPlayIndex = index;
    
    // 当一个窗口内包含了首尾cell时，只有首个cell会触发动画
    // 概率很小，后面注释代码简单解决一下但不完美
    if (tableView.contentOffset.y <= 0)
    {
        // 顶部
        if (array.count > 0) {
            ImageListModel *model = array[0];
            if (model.isHaveGif)
            {
                lastOrCurrentPlayIndex = 0;
                return lastOrCurrentPlayIndex;
            }
        }
    } else if (tableView.contentOffset.y + tableView.frame.size.height >= tableView.contentSize.height)
    {
        // 底部
        if (array.count > 1) {
            ImageListModel *model = array[array.count - 1];
            if (model.isHaveGif)
            {
                lastOrCurrentPlayIndex = 0;
                return lastOrCurrentPlayIndex;
            }
        }
    }
    
    NSArray *cellsArray = [tableView visibleCells];
    
    NSArray *newArray = nil;
    if (!isScrollDownward) {
        newArray = [cellsArray reverseObjectEnumerator].allObjects;
    } else {
        newArray = cellsArray;
    }
    
    [newArray enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [tableView indexPathForCell:cell];
        if (!indexPath) {
            *stop = YES;
            return;
        }
        ImageListModel *model = array[indexPath.row];
        if (model.isHaveGif)
        {
            CGRect rect = [cell convertRect:cell.bounds toView:view];

            // 顶部间隔
            CGFloat topSpacing = rect.origin.y;
            // 底部间隔
            CGFloat bottomSpacing = view.frame.size.height - rect.origin.y - rect.size.height;

            BOOL find = NO;
            if (isScrollDownward) {
                if ((topSpacing >= -rect.size.height/5) && (bottomSpacing >= -rect.size.height/3))
                {
                    find = YES;
                }
            } else {
                if ((topSpacing >= -rect.size.height/3) && (bottomSpacing >= -rect.size.height/5))
                {
                    find = YES;
                }
            }

            if (find)
            {
                lastOrCurrentPlayIndex = indexPath.row;
                *stop = YES;
            } else {
                lastOrCurrentPlayIndex = -1;
            }
        }
    }];

    return lastOrCurrentPlayIndex;
}

@end
