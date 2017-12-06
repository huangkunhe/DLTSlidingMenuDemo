//
//  DLTSlidingMenuView.h
//  DLiTong
//
//  Created by river on 2017/10/2.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLTSlidingMenuView;

@protocol DLTSlidingMenuViewDelegate <NSObject>
- (void)didSelectedSlidingMenuView:(DLTSlidingMenuView *)slidingMenuView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface DLTSlidingMenuView : UIView

@property(nonatomic,assign) int countRow;
@property(nonatomic,assign) int countCol;
@property(nonatomic,assign) BOOL pgCtrlIsHidden;
@property(nonatomic,strong) UIColor *pgCtrlNormalColor;
@property(nonatomic,strong) UIColor *pgCtrlSelectedColor;

@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,weak)id<DLTSlidingMenuViewDelegate> delegateAslidingMenuView;

@end
