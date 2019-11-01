//
//  PrefectureCollectionCellTypeC.h
//  MobileCaiLocal
//
//  Created by 朱新明 on 2019/10/30.
//  Copyright © 2019 timtian. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "HomeModel.h"

#import "PrefectureSubViewA.h"
#import "PrefectureSubViewC.h"
NS_ASSUME_NONNULL_BEGIN

@interface PrefectureCollectionCellTypeC : BaseCollectionViewCell

@property (nonatomic, strong) PrefectureSubViewC *view1;

@property (nonatomic, strong) PrefectureSubViewC *view2;

@property (nonatomic, strong) PrefectureSubViewC *view3;

@property (nonatomic, strong) PrefectureSubViewA *view4;

@property (nonatomic, strong) PrefectureSubViewA *view5;

@property (nonatomic, strong) UIView *line_vertical;
@property (nonatomic, strong) UIView *line_vertical2;

@property (nonatomic, strong) UIView *line_horizontal;
@end

NS_ASSUME_NONNULL_END
