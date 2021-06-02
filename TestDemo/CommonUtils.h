//
//  CommonUtils.h
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MacroDefine.h"
#import "LeftImageTableViewCell.h"
#import "MultiImageTableViewCell.h"
#import "ImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonUtils : NSObject

+ (void)pauseOrPlayCellWithIndex:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath isPause:(BOOL)pause;
+ (NSInteger)findCellWithScrollDirection:(BOOL)isScrollDownward currentPlayIndex:(NSInteger)index tableView:(UITableView *)tableView dataMutableArray:(NSMutableArray *)array currentView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
