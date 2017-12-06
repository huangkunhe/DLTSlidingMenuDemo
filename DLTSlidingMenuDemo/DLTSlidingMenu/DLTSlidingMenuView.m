//
//  DLTSlidingMenuView.m
//  DLiTong
//
//  Created by river on 2017/10/2.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import "DLTSlidingMenuView.h"
#import "DLTSlidingMenuCollectionViewCell.h"
#import "DLTSlidingMenuItemModel.h"
#import "DLTCollectionViewHorizontalLayout.h"

@interface DLTSlidingMenuView()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong) DLTCollectionViewHorizontalLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pgCtrl;

@end

@implementation DLTSlidingMenuView

static NSString *const DLTSlidingMenuViewCell = @"DLTSlidingMenuCollectionViewCell";
static NSString *const DLTSlidingMenuViewBlankCell = @"DLTSlidingMenuCollectionViewBlankCell";

-(UIPageControl *)pgCtrl{
    if (!_pgCtrl) {
        _pgCtrl =[[UIPageControl alloc]init];
        _pgCtrl.currentPage = 0;
        _pgCtrl.pageIndicatorTintColor = self.pgCtrlNormalColor;
        _pgCtrl.currentPageIndicatorTintColor = self.pgCtrlSelectedColor;
    }
    return _pgCtrl;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat uiScreenWidth =self.frame.size.width;
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, uiScreenWidth, self.frame.size.height-30) collectionViewLayout:flowLayout];
         _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled =YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0.0, 0, 0.0, 0);       
       

        UINib *nib = [UINib nibWithNibName:@"DLTSlidingMenuCollectionViewCell" bundle:[NSBundle mainBundle]];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:DLTSlidingMenuViewCell];
//        [_collectionView registerClass:[DLTSlidingMenuCollectionViewCell class] forCellWithReuseIdentifier:DLTSlidingMenuViewCell];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:DLTSlidingMenuViewBlankCell];
    }
    return _collectionView;
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self setupSubviews];
    self.pgCtrl.numberOfPages = dataArray.count > self.countCol * self.countRow ? (dataArray.count + self.countRow * self.countCol - 1) / (self.countRow * self.countCol) : 0;
    if (self.pgCtrlIsHidden) {
        self.pgCtrl.frame =CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 3);
        [self addSubview:self.pgCtrl];
    }
    [self.collectionView reloadData];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialization];
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialization];
    [self setupSubviews];
}

- (void)initialization {
    _pgCtrlSelectedColor = [UIColor greenColor];
    _pgCtrlIsHidden = YES;
    
}

- (void)setupSubviews {

    [self addSubview:self.collectionView];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat uiScreenWidth =self.frame.size.width;
    int sideLength = uiScreenWidth /(CGFloat)self.countCol;
    int sideHeight =(self.frame.size.height-30)/(CGFloat)self.countRow;
    /// 设置 UICollectionViewFlowLayout 尺寸
    return  CGSizeMake(sideLength, sideHeight);

    
}


#pragma mark - - - UICollectionView 的 dataSource 方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger countSet = (self.dataArray.count + (self.countRow * self.countCol - 1)) / (self.countRow * self.countCol) * (self.countRow * self.countCol);// 先去掉尾数，再补缺
    return countSet;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    int indexChanged = [self convertDirectionCount:indexPath.row rowCount:self.countRow colCount:self.countCol];
    if (indexChanged < self.dataArray.count) {
        
        DLTSlidingMenuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:DLTSlidingMenuViewCell forIndexPath:indexPath];
        
        DLTSlidingMenuItemModel * model = self.dataArray[indexChanged];
        
        cell.itemModel = model;
        return cell;
    }
    else {
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:DLTSlidingMenuViewBlankCell forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.userInteractionEnabled = NO;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    int indexChanged = [self convertDirectionCount:indexPath.row rowCount:self.countRow colCount:self.countCol];
    
    if (indexChanged < self.dataArray.count) {
        
        if (self.delegateAslidingMenuView && [self.delegateAslidingMenuView respondsToSelector:@selector(didSelectedSlidingMenuView:didSelectedItemAtIndex:)]) {
            [self.delegateAslidingMenuView didSelectedSlidingMenuView:self didSelectedItemAtIndex:indexChanged];
        }
    }
}

-(int)convertDirectionCount:(long)number rowCount:(int)rowCount colCount:(int)colCount{
    
    int tempH = (int)number / (colCount * rowCount);
    int tempL = number % (colCount * rowCount);
    int result = tempL - (tempL / rowCount) * (rowCount - 1) + tempL % rowCount * (colCount - 1) + tempH * (colCount * rowCount);
    return result;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int page = (scrollView.contentOffset.x+6)/ scrollView.frame.size.width;
    self.pgCtrl.currentPage = page;
}


@end
