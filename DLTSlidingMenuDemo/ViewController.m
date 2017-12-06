//
//  ViewController.m
//  DLTSlidingMenuDemo
//
//  Created by river on 2017/12/6.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import "ViewController.h"
#import "DLTSlidingMenuView.h"
#import "DLTSlidingMenuItemModel.h"


@interface ViewController ()<DLTSlidingMenuViewDelegate>

@property (nonatomic, strong) DLTSlidingMenuView *menuView;

@end

@implementation ViewController

-(DLTSlidingMenuView *)menuView{
    if (!_menuView) {
        
        _menuView = [[DLTSlidingMenuView alloc]initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 209)];
        _menuView.delegateAslidingMenuView = self;
        _menuView.countRow = 2;
        _menuView.countCol = 4;
        _menuView.pgCtrlNormalColor =[UIColor grayColor];
    }
    return _menuView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuView];
    [self getData];
}

- (void)getData
{
    NSMutableArray * dataArray = [NSMutableArray new];
    for (int i =0; i< 10; i++) {
        DLTSlidingMenuItemModel * itemModel = [DLTSlidingMenuItemModel new];
        itemModel.menuID = [NSString stringWithFormat:@"%d",i];
        itemModel.titleName =[NSString stringWithFormat:@"item%d",i];
        itemModel.imageURL = @"icon_homepage_default";
        [dataArray addObject:itemModel];
    }
    self.menuView.dataArray = dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark DLTSlidingMenuViewDelegate
- (void)didSelectedSlidingMenuView:(DLTSlidingMenuView *)slidingMenuView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
}


@end
