//
//  MaterialsCell.h
//  FZ_iPad
//
//  Created by Jeemy on 16/9/12.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageSmallModel.h"
@interface MaterialsCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;



@property (nonatomic ,strong)ImageSmallModel *imageSmallModel;
@property (nonatomic ,copy )NSString *imageSmallStr;

@end
