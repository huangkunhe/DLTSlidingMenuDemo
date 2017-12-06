//
//  DLTSlidingMenuItemModel.h
//  DLiTong
//
//  Created by river on 2017/10/2.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLTSlidingMenuItemModel : NSObject

///id
@property (nonatomic,copy) NSString *menuID;
///标题
@property (nonatomic,copy) NSString *titleName;
///图片URL
@property (nonatomic,copy) NSString *imageURL;
///类型
@property (nonatomic,copy) NSString *itemType;
///h5
@property (nonatomic,copy) NSString *h5URL;
@end
