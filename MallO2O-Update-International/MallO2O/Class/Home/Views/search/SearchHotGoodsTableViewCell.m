//
//  SearchHotGoodsTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/2/17.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "SearchHotGoodsTableViewCell.h"
#import "SearchHotGoodsCollectionViewCell.h"


@interface SearchHotGoodsTableViewCell ()<UICollectionViewDataSource ,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout>

@property (copy ,nonatomic) UICollectionView *collectionView;

@property (copy ,nonatomic) UILabel *label;

@end

@implementation SearchHotGoodsTableViewCell{
    NSArray *array;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        array = @[@"111",@"222",@"333",@"444"];
        [self addUI];
    }
    return self;
}

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withCellId:(NSString *)cellIdentifier{
    SearchHotGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)addUI{
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.label];
    [_label  autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [_label autoSetDimension:ALDimensionHeight toSize:40];
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    NSInteger dataCount = dataArray.count;
    NSInteger hang = dataCount/3;
    if (dataCount%3 != 0) {
        hang = hang + 1;
    }
    _collectionView.frame = CGRectMake(10, 40, SCREEN_WIDTH - 20, hang * 40);
    [_collectionView reloadData];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.minimumInteritemSpacing = 0;
//        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH - 20, 0) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SearchHotGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"searchCollectionCell"];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchHotGoodsCollectionViewCell *cell = [SearchHotGoodsCollectionViewCell cellOfCollectionView:collectionView cellForRowAtIndexPath:indexPath withCellId:@"searchCollectionCell"];
//    cell.string = array[indexPath.row];
    cell.dataDic = self.dataArray[indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 40)/3, 35);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了collectionview");
    if (self.block) {
        NSDictionary *dic = self.dataArray[indexPath.row];
        self.block(dic);
    }
}

- (void)clickCell:(ClickHotCell)block{
    self.block = block;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initForAutoLayout];
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = UIColorFromRGB(0x444444);
        _label.text = [NSString stringWithFormat:@"     %@", NSLocalizedString(@"searchHisHotCommodityTitle", nil)];
    }
    return _label;
}

@end
