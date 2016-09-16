//
//  MaterialsCell.m
//  FZ_iPad
//
//  Created by Jeemy on 16/9/12.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "MaterialsCell.h"
@interface MaterialsCell()
@property (nonatomic ,strong)UIImageView *imgV;
@end
@implementation MaterialsCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setImageSmallStr:(NSString *)imageSmallStr{
    _imageSmallStr = imageSmallStr;
    
    self.imgV.image = [UIImage imageNamed:imageSmallStr];
}
-(void)setImageSmallModel:(ImageSmallModel *)imageSmallModel{
    _imageSmallModel = imageSmallModel;
//    NSArray *array=imageSmallModel.curtain;
//    JSLog(@"这里模型数据为:%@",array);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 可重用标示符
    static NSString *ID = @"MaterialsCell";
    
    // 让表格缓冲区查找可重用cell
    MaterialsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell = [[MaterialsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentView.backgroundColor=JSColor(23, 23, 23);
        CGFloat cellW=UIScreenSize.width*0.3/2+20;
//        CGFloat cellH=UIScreenSize.height;
        //添加初始化Cell的代码
        self.imgV=[[UIImageView alloc]initWithFrame:CGRectMake(2, 2, cellW-4, 160-4)];
        self.imgV.image=[UIImage imageNamed:self.imageSmallStr];
        JSLog(@"图片地址:%@",self.imageSmallStr);
        self.imgV.layer.cornerRadius=3;
        self.imgV.layer.masksToBounds=YES;
        self.imgV.layer.borderColor=JSColor(188, 188, 188).CGColor;
        self.imgV.layer.borderWidth=2;
//        imgV.backgroundColor=JSRandomColor;
    
        
        
        [self.contentView addSubview:self.imgV];
    }
    return self;

    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
