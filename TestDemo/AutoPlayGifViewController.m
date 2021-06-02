//
//  AutoPlayGifViewController.m
//  TestDemo
//
//  Created by DTiOS on 2021/6/1.
//

#import "AutoPlayGifViewController.h"
#import "MacroDefine.h"
#import "LeftImageTableViewCell.h"
#import "MultiImageTableViewCell.h"
#import "ImageModel.h"

@interface AutoPlayGifViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *playGifTableView;
@property (strong, nonatomic) NSMutableArray *gifArr;

// 记录偏移值,用于判断上滑还是下滑
@property (nonatomic, assign) CGFloat lastScrollViewContentOffsetY;
// Yes-往下滑,NO-往上滑
@property (nonatomic, assign) BOOL isScrollDownward;

@property (nonatomic, assign) NSInteger lastOrCurrentPlayIndex;
@end

@implementation AutoPlayGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.lastScrollViewContentOffsetY = 0.0f;
    self.lastOrCurrentPlayIndex = -1;
    
    NSArray *imageInfoArr = [self getJsonObjectFromLocal:@"imageInfo.json"];
    [self.gifArr addObjectsFromArray:[ImageListModel mj_objectArrayWithKeyValuesArray:imageInfoArr]];
    [self.playGifTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _gifArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageListModel *model = _gifArr[indexPath.row];
    if (indexPath.row % 2 == 0) {
        static NSString *cellID = @"LeftImageTableViewCell";
        LeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {

            cell = (LeftImageTableViewCell *)LoadNibNamed(cellID);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.imageListModel = model;
        return cell;
    }
    static NSString *cellID = @"MultiImageTableViewCell";
    MultiImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {

        cell = (MultiImageTableViewCell *)LoadNibNamed(cellID);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageListModel = model;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 判断滚动方向
    if (scrollView.contentOffset.y > self.lastScrollViewContentOffsetY) {
        // 向上拉
        self.isScrollDownward = YES;
    } else {
        // 向下拉
        self.isScrollDownward = NO;
    }
    self.lastScrollViewContentOffsetY = scrollView.contentOffset.y;

    if (self.gifArr.count == 0) {
        return;
    }
    // 找出适合cell播放
    NSInteger lastOrCurrentPlayIndex = [CommonUtils findCellWithScrollDirection:self.isScrollDownward currentPlayIndex:self.lastOrCurrentPlayIndex tableView:self.playGifTableView dataMutableArray:self.gifArr currentView:self.view];
    if (lastOrCurrentPlayIndex != self.lastOrCurrentPlayIndex)
    {
        // 停止当前播放的
        if (self.lastOrCurrentPlayIndex >= 0 && self.lastOrCurrentPlayIndex < self.gifArr.count) {
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.lastOrCurrentPlayIndex inSection:0];
            [CommonUtils pauseOrPlayCellWithIndex:self.playGifTableView indexPath:lastIndexPath isPause:YES];
        }

        self.lastOrCurrentPlayIndex = lastOrCurrentPlayIndex;

        // 播放出现的
        if (self.lastOrCurrentPlayIndex >= 0 && self.lastOrCurrentPlayIndex < self.gifArr.count) {
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.lastOrCurrentPlayIndex inSection:0];
            [CommonUtils pauseOrPlayCellWithIndex:self.playGifTableView indexPath:lastIndexPath isPause:NO];
        }
    }
}

- (NSMutableArray *)gifArr
{
    if (!_gifArr) {
        _gifArr = [NSMutableArray array];
    }
    return _gifArr;
}

- (id)getJsonObjectFromLocal:(NSString *)jsonStr
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    return jsonObject;
}

@end
