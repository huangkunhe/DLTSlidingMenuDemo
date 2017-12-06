//
//  DLTSlidingMenuCollectionViewCell.m
//  DLiTong
//
//  Created by river on 2017/10/2.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import "DLTSlidingMenuCollectionViewCell.h"
#import "DLTSlidingMenuItemModel.h"


@interface DLTSlidingMenuCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;

@end


@implementation DLTSlidingMenuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    // Initialization code
}

-(void)setItemModel:(DLTSlidingMenuItemModel *)itemModel
{
    self.lblTitle.text = itemModel.titleName;
    if ([itemModel.imageURL hasPrefix:@"http"]) {
        NSLog(@"使用SDWebImage 加载");
//         [self.imgViewIcon sd_setImageWithURL:[NSURL URLWithString:itemModel.imageURL] placeholderImage:[UIImage imageNamed:@"icon_homepage_default"]];
        
    }else
    {
        [self.imgViewIcon setImage:[UIImage imageNamed:itemModel.imageURL]];
    }
   
}

@end
