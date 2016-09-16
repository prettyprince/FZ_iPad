//
//  DisplayVC.m
//  FZ_iPad
//
//  Created by Jeemy on 16/9/12.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "DisplayVC.h"
#import "UIImage+WebP.h"
#import "MaterialsCell.h"
#import "ImageBigModel.h"
#import "ImageSmallModel.h"
@interface DisplayVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UIImageView *bgImgView;
@property (nonatomic ,strong)UIView *statusV;
@property (nonatomic ,strong)UIButton *closeBtn;
@property (nonatomic ,strong)UIButton *listBtn;
@property (nonatomic ,strong)UIButton *checkBtn;
@property (nonatomic ,strong)UIButton *menuButton;
@property (nonatomic ,strong)ChoiceTypeBtnView *btnView;
@property (nonatomic ,strong)UITableView *tableview;

//装cell中是否被选中
@property (nonatomic ,strong)NSMutableArray *selectMuArray;
@property (nonatomic ,assign)BOOL isSelected;

@property (nonatomic ,strong)CALayer *myLayer;
//点击的地板之类的按钮数组
@property (nonatomic ,strong)NSArray *typeArray;
//从文件plist中取出的数据
@property (nonatomic ,strong)NSDictionary *bigImgDic;
@property (nonatomic ,strong)NSDictionary *smallImgDic;
//选择的材料属于哪一大板块
@property (nonatomic ,copy )NSString *typeNameStr;
//每次生成的新的图层
@property (nonatomic ,strong)UIImageView *endImgView;
//做一个view层让之在最外面，方便图片fang入它的下面
@property (nonatomic ,strong)UIView *insertView;
@property(nonatomic ,strong)UIView *replaceView;//用于被取代的视图

/**
 *定义每个样式的房间装饰image
 */
@property (nonatomic ,strong)UIImageView *wallImgView;//1
@property (nonatomic ,strong)UIImageView *landImgView;//2
@property (nonatomic ,strong)UIImageView *curtainImgView;//3
/**
 *分开设置每个的是否已经点击
 */
@property (nonatomic ,assign)BOOL curtainSelected;
@property (nonatomic ,assign)BOOL wallSelected;

@property (nonatomic ,assign)BOOL landSelected;
//判断是否之前点击的图片
@property (nonatomic ,copy)NSString *preImgName;

//存放点击过的材料
@property (nonatomic ,strong)NSMutableArray *layerMuArray;
@end

@implementation DisplayVC
-(NSMutableArray *)layerMuArray{
    if (_layerMuArray==nil) {
        _layerMuArray = [[NSMutableArray alloc]init];
    }
    return _layerMuArray;
}
-(CALayer *)myLayer{
    if (_myLayer==nil) {
        self.myLayer=[CALayer layer];
        //设置layer的属性
        self.myLayer.frame=CGRectMake(0, 0, UIScreenSize.width, UIScreenSize.height);
        
    }
    return _myLayer;
}

/**
 *tableview的懒加载
 */
-(UITableView *)tableview{
    CGFloat width=UIScreenSize.width * 0.3;
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 150, width/2+20,UIScreenSize.height-100) style:UITableViewStylePlain];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.delegate=self;
        _tableview.dataSource=self;
        
        _tableview.backgroundColor=JSColor(23, 23, 23);
        JSLog(@"1");
    }
    
    return _tableview;
}
/**
 *tableview的代理和数据源方法
 */
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    long int count;
    if (self.typeArray.count>0) {
        count=self.typeArray.count;
    }else{
        count=1;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 可重用标示符
    NSString *imageBigStr = [[NSBundle mainBundle] pathForResource:@"ImageSmallList" ofType:@"plist"];
    NSDictionary *imageBigDic = [[NSMutableDictionary alloc] initWithContentsOfFile:imageBigStr];
    JSLog(@"从plist文件拿到的数据:%@",imageBigDic);
    NSArray *curtainSmallArray=[imageBigDic valueForKey:@"curtain"];
    
//    NSArray *smallModelArray=[ImageSmallModel objectArrayWithKeyValuesArray:curtainSmallArray];
    
    
    MaterialsCell *cell=[MaterialsCell cellWithTableView:tableView];
//    if (indexPath.row<4) {
//        cell.imageSmallModel=smallModelArray[indexPath.row];
//    }
    cell.imageSmallStr=self.typeArray[indexPath.row];
    JSLog(@"curtainSmallArray=%@,cell.imageSmallStr=%@",curtainSmallArray,curtainSmallArray[indexPath.row]);
    cell.backgroundColor=JSColor(23, 23, 23);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /**
     *获取点击当前cell后所有之前点过的非重复的样
     */
    //当点击第一个时<先存放点过的>//存放

    JSLog(@"开始时的数组:%@",self.layerMuArray  );
    //选中某个cell时，绘图
    //创建一个layer
         //设置需要显示的图片
   
        NSString *strName=[self.bigImgDic valueForKey:self.typeNameStr][indexPath.row];
    
       UIImageView *imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:strName]];
        self.myLayer.contents=(id)[UIImage imageNamed:strName].CGImage;
        NSString *str=[NSString stringWithFormat:@"%ld",indexPath.row];
        [self.selectMuArray addObject:str];

    

    
    
    /**
     *画图层
     */
    if (self.endImgView!=nil) {
        JSLog(@"最后的图层bu 为空");
    }else{
        JSLog(@"为空");
        self.endImgView=self.bgImgView;
       
    }

    
    if ([self.typeNameStr isEqualToString:@"curtain"]) {//为窗帘
        NSString * strCurtain=[NSString stringWithFormat:@"curtain.%@",strName];
        if (self.preImgName!=strName) {
            [self.curtainImgView setHidden:NO];
//            self.curtainImgView.image=img;
            
            //先判断 数组中是否存在这个同类材料，有则替换，无则增加
            NSString *curtainStr=@"curtain";
            if (self.layerMuArray.count>0) {
                BOOL isFind=0;
                for (int i=0;i<self.layerMuArray.count;i++) {
                    
                    if ([self.layerMuArray[i] containsString:curtainStr]) {
                                                //因为涉及不同种类切换时名字肯定不一样,所以要再判断是否里面包含一样的类型的，不然不会消息
                        if ([self.layerMuArray[i] containsString:strName]) {
                            //删除之前那个 因为点到重复的了
                            [self.layerMuArray removeObjectAtIndex:i];
                        }else{
                            //替换之前那个
                            [self.layerMuArray replaceObjectAtIndex:i withObject:strCurtain];

                        }
                        
                        isFind=1;
                    }
                    
                }
                if (isFind == 0) {//说明没有发现同类型的
                    [self.layerMuArray addObject:strCurtain];
                }
            }else{
                [self.layerMuArray addObject:strCurtain];
            }
           
        }
        
        if(self.preImgName==strName&&(self.curtainImgView.hidden==YES)){
            //隐藏
            [self.layerMuArray addObject:strCurtain];

            [self.curtainImgView setHidden:NO];
            
        }else if(self.preImgName==strName&&(self.curtainImgView.hidden==NO)){
            [self.layerMuArray removeObject:strCurtain];
         
            [self.curtainImgView setHidden:YES];
        }
        
//        JSLog(@"self.MutableLaye=%@",self.layerMuArray);
        
//        [self.bgImgView.layer replaceSublayer:self.curtainImgView.layer with:self.myLayer];

    }else if([self.typeNameStr isEqualToString:@"wall"]){//墙壁
        
//        self.wallImgView.image=img;
        
        NSString * strCurtain=[NSString stringWithFormat:@"wall.%@",strName];
        if (self.preImgName!=strName) {
            [self.wallImgView setHidden:NO];
//            self.wallImgView.image=img;
            
            //先判断 数组中是否存在这个同类材料，有则替换，无则增加
            NSString *curtainStr=@"wall";
            if (self.layerMuArray.count>0) {
                BOOL isFind=0;
                for (int i=0;i<self.layerMuArray.count;i++) {
                    
                    if ([self.layerMuArray[i] containsString:curtainStr]) {
                        
                        if ([self.layerMuArray[i] containsString:strName]) {
                            //删除之前那个 因为点到重复的了
                            [self.layerMuArray removeObjectAtIndex:i];
                        }else{
                            //替换之前那个
                            [self.layerMuArray replaceObjectAtIndex:i withObject:strCurtain];
                            
                        }
                       
                        isFind=1;
                    }
                    
                }
                if (isFind == 0) {//说明没有发现同类型的
                    [self.layerMuArray addObject:strCurtain];
                }
            }else{
                [self.layerMuArray addObject:strCurtain];
            }
            
        }
        
        if(self.preImgName==strName&&(self.wallImgView.hidden==YES)){
            //隐藏
            [self.layerMuArray addObject:strCurtain];
            
            [self.wallImgView setHidden:NO];
            
        }else if(self.preImgName==strName&&(self.wallImgView.hidden==NO)){
            [self.layerMuArray removeObject:strCurtain];
            
            [self.wallImgView setHidden:YES];
        }
        
        
    }else if ([self.typeNameStr isEqualToString:@"land"]){//地板
//        self.landImgView.image=img  ;
        
        
        
        NSString * strCurtain=[NSString stringWithFormat:@"land.%@",strName];
        if (self.preImgName!=strName) {
            [self.landImgView setHidden:NO];
//            self.landImgView.image=img;
            
            //先判断 数组中是否存在这个同类材料，有则替换，无则增加
            NSString *curtainStr=@"land";
            if (self.layerMuArray.count>0) {
                BOOL isFind=0;
                for (int i=0;i<self.layerMuArray.count;i++) {
                    
                    if ([self.layerMuArray[i] containsString:curtainStr]) {
                        if ([self.layerMuArray[i] containsString:strName]) {
                            //删除之前那个 因为点到重复的了
                            [self.layerMuArray removeObjectAtIndex:i];
                        }else{
                            //替换之前那个
                            [self.layerMuArray replaceObjectAtIndex:i withObject:strCurtain];
                            
                        }
                        isFind=1;
                    }
                    
                }
                if (isFind == 0) {//说明没有发现同类型的
                    [self.layerMuArray addObject:strCurtain];
                }
            }else{
                [self.layerMuArray addObject:strCurtain];
            }
            
        }
        
        if(self.preImgName==strName&&(self.landImgView.hidden==YES)){
            //隐藏
            [self.layerMuArray addObject:strCurtain];
            
            [self.landImgView setHidden:NO];
            
        }else if(self.preImgName==strName&&(self.landImgView.hidden==NO)){
            [self.layerMuArray removeObject:strCurtain];
            
            [self.landImgView setHidden:YES];
        }
        
    }
 
 
    
    JSLog(@"self.layerMuArray=%@",self.layerMuArray );
    
    
    /**
     叠加图片
     */
   
    if(self.layerMuArray.count>0){
        UIGraphicsBeginImageContext(self.bgImgView.size);//开始画图
        
        UIImage *img1;
        UIImage *img2;
        UIImage *img3;
        [[UIImage imageNamed:@"testpng"] drawInRect:self.bgImgView.frame];
        for (int i=0; i<self.layerMuArray.count; i++) {
           if ([self.layerMuArray[i] containsString:@"wall"]){
                NSString *str=[self.layerMuArray[i] substringFromIndex:5];

                UIImage *img=[UIImage imageNamed:str];
               img1=img;
               
            }else if([self.layerMuArray[i] containsString:@"land"]){
                NSString *str=[self.layerMuArray[i] substringFromIndex:5];

                UIImage *img=[UIImage imageNamed:str];
                img2=img;
//                [img drawInRect:self.bgImgView.frame];
                
            } else if ([self.layerMuArray[i] containsString:@"curtain"]) {
                NSString *str=[self.layerMuArray[i] substringFromIndex:8];
//                JSLog(@"curtain:%@",str);
                UIImage *img=[UIImage imageNamed:str];
                img3=img;
//                [img drawInRect:self.curtainImgView.frame];
                
            }
        }
        
        [img1 drawInRect:self.bgImgView.frame];
        [img2 drawInRect:self.bgImgView.frame];
        [img3 drawInRect:self.bgImgView.frame];
        UIImage *newImg=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.bgImgView.image=newImg;
        
    }else{
        self.bgImgView.image=[UIImage imageNamed:@"testpng"];
    }
    
    
    
    
    
    
    self.preImgName=strName;

    self.replaceView=self.endImgView;
    UIGraphicsEndImageContext();
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
       
     [super viewWillDisappear:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    JSLog(@"323");
    // Do any additional setup after loading the view.
    self.view.backgroundColor=JSColor(255, 255, 255);
    
    NSString *imageBigStr = [[NSBundle mainBundle] pathForResource:@"ImageBigList" ofType:@"plist"];
    NSDictionary *imageBigDic = [[NSMutableDictionary alloc] initWithContentsOfFile:imageBigStr];
    self.bigImgDic=imageBigDic;
    NSString *imageSmallStr = [[NSBundle mainBundle] pathForResource:@"ImageSmallList" ofType:@"plist"];
    NSDictionary *imageSmallDic = [[NSMutableDictionary alloc] initWithContentsOfFile:imageSmallStr];
    self.smallImgDic=imageSmallDic;
    
    [self setInit];
    
}
/**
 *初始化当前页面
 */
-(void)setInit{
//    NSUUID *uuid =[UIDevice currentDevice].identifierForVendor;
//    JSLog(@"uuid=%@",uuid.UUIDString);
    //低层图片
    self.bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UIScreenSize.width, UIScreenSize.height)];
    [self.bgImgView setBackgroundColor:[UIColor purpleColor]];
    self.bgImgView.userInteractionEnabled =YES;
    //放一张方便layer的below的view
    self.insertView=[[UIView alloc]initWithFrame:self.bgImgView.frame];
    [self.bgImgView addSubview:self.insertView];
    
    self.replaceView=[[UIView alloc]initWithFrame:self.bgImgView.frame];
    [self.bgImgView insertSubview:self.replaceView belowSubview:self.insertView];
    
    //设置需要显示的图片
    self.landImgView=[[UIImageView alloc]initWithFrame:self.bgImgView.frame];
    self.wallImgView=[[UIImageView alloc]initWithFrame:self.bgImgView.frame];
    self.curtainImgView=[[UIImageView alloc]initWithFrame:self.bgImgView.frame];

    [self.bgImgView insertSubview:self.curtainImgView belowSubview:self.insertView];
    [self.bgImgView insertSubview:self.wallImgView belowSubview:self.curtainImgView];

    [self.bgImgView insertSubview:self.landImgView belowSubview:self.wallImgView];

    

    
    
    
    
    [self.bgImgView setImage:[UIImage imageNamed:@"testpng.png"]];

//     UIImage *image=[UIImage imageWithWebP:@"/Users/Jeemy/Desktop/FZ_iPad/FZ_iPad/test.webp"];

//    [self makeWebp];
    [self.view addSubview:self.bgImgView];
    
    //右侧状态栏
    self.menuButton = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenSize.width-150, 100, 80, 80)];
    self.menuButton.backgroundColor = JSColor(23, 23, 23);
    [self.bgImgView addSubview:self.closeBtn];
    [self.menuButton setTitle:@"菜单" forState:UIControlStateNormal];
    self.menuButton.layer.cornerRadius=40;
    self.menuButton.layer.masksToBounds=YES;
    
    [self.menuButton addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.insertView addSubview:self.menuButton];
    
    
    CGFloat statusW=UIScreenSize.width * 0.3;
    CGFloat statusX=UIScreenSize.width - statusW;
    CGFloat statusH=UIScreenSize.height;
  
    self.statusV = [[UIView alloc]initWithFrame:CGRectMake(statusX, 0, statusW, statusH)];
    self.statusV.userInteractionEnabled=YES;
    self.statusV.backgroundColor = JSColor(23, 23, 23);
    self.btnView=[[ChoiceTypeBtnView alloc]initWithFrame:CGRectMake(self.statusV.width/2+20, 0, self.statusV.width/2-20, self.statusV.height)];
    
    self.btnView.delegate=self;
    self.btnView.userInteractionEnabled=YES;
    [self.statusV addSubview:self.btnView];
    
    
//    [self.bgImgView addSubview:self.statusV];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 40, 50, 50)];
    closeBtn.backgroundColor = JSRandomColor;
    [self.statusV addSubview:closeBtn];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.layer.cornerRadius=25;
    closeBtn.layer.masksToBounds=YES;
    [closeBtn addTarget:self action:@selector(clickCloseMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //放个tableview在status上
    [self.statusV addSubview:self.tableview  ];
    JSLog(@"2");

    
    
    //左侧三个按钮
    CGFloat btnX=UIScreenSize.width*0.03;
    CGFloat btnY=UIScreenSize.height*0.1;
    CGFloat btnW=50;
    CGFloat btnH=50;
    self.closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    self.closeBtn.backgroundColor = JSRandomColor;
    [self.insertView addSubview:self.closeBtn];
    [self.closeBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.closeBtn.layer.cornerRadius=25;
    self.closeBtn.layer.masksToBounds=YES;
    [self.closeBtn addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.listBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, CGRectGetMaxY(self.closeBtn.frame)+70, btnW, btnH)];
    [self.listBtn setTitle:@"清单" forState:UIControlStateNormal];
    self.listBtn.layer.cornerRadius=25;
    self.listBtn.layer.masksToBounds=YES;
    self.listBtn.backgroundColor = JSRandomColor;
    [self.insertView addSubview:self.listBtn];
    [self.listBtn addTarget:self action:@selector(clickListBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, CGRectGetMaxY(self.listBtn.frame)+70, btnW, btnH)];
    [self.checkBtn setTitle:@"查验" forState:UIControlStateNormal];
    self.checkBtn.layer.cornerRadius=25;
    self.checkBtn.layer.masksToBounds=YES;
    self.checkBtn.backgroundColor = JSRandomColor;
    [self.insertView addSubview:self.checkBtn];
     [self.checkBtn addTarget:self action:@selector(clickCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *实现菜单弹出
 */
-(void)clickMenuBtn:(UIButton *)btn{
    [self.bgImgView addSubview:self.statusV];

}
-(void)clickCloseMenuBtn:(UIButton *)btn{
    [self.statusV removeFromSuperview];
}
/**
 *实现左边三个按钮方法
 */
-(void)clickCloseBtn:(UIButton *)btn{
    JSLog(@"你要关闭本页面");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickListBtn:(UIButton *)btn{
    
    JSLog(@"1");
}
-(void)clickCheckBtn:(UIButton *)btn{
    JSLog(@"2");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *webp的使用
 */

- (void)makeWebp {
    
    // Do any additional setup after loading the view, typically from a nib.
//    NSString *normalImg = [[NSBundle mainBundle] pathForResource:@"testpng" ofType:@"png"];
    
//    uint64_t fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:normalImg error:nil] fileSize];
    
    
    UIImage *demoImage = [UIImage imageNamed:@"test.webp"];
    NSData *imgData=[UIImage imageToWebP:demoImage quality:0.5];
   
    
//    UIImageView *pngView = [[UIImageView alloc] initWithImage:demoImage];
//    pngView.frame = CGRectMake(0, 0, demoImage.size.width, demoImage.size.height);
//    
//    [self.view addSubview:pngView];
//    UILabel *pngLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pngView.frame) + 5,300, 10)];
//    pngLabel.text = [NSString stringWithFormat:@"%@ format file size: %.2f KB ",[[normalImg pathExtension] uppercaseString],(double)fileSize / 1024];
//    [pngLabel setFont:[UIFont systemFontOfSize:12]];
//    [self.view addSubview:pngLabel];
    
    
//    self.bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pngView.frame) + 20,demoImage.size.width, demoImage.size.height)];
//    [self.view addSubview:self.bgImgView];
    
//    UIImage *image=[UIImage imageWithData:imgData];
    [self displayImageWithData:imgData];
    return;
    
    [UIImage imageToWebP:demoImage quality:75.0 alpha:1.0 preset:WEBP_PRESET_PHOTO completionBlock:^(NSData *result) {
        
        [self displayImageWithData:result];
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    
    
}


- (void)displayImageWithData:(NSData *)webPData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *webPPath = [paths[0] stringByAppendingPathComponent:@"image.webp"];
    if ([webPData writeToFile:webPPath atomically:YES]) {
        [UIImage imageWithWebP:webPPath completionBlock:^(UIImage *result) {
//            uint64_t fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:webPPath error:nil] fileSize];
            
//            _webPLabel1.text = [NSString stringWithFormat:@"%@ format file size: %.2f KB ",[[webPPath pathExtension] uppercaseString],(double)fileSize / 1024];
            [self.bgImgView setImage:result];
        } failureBlock:^(NSError *error) {
            
        }];
    }
    
    
}


/**
 *右侧按钮的代理方法
 */
-(void)changeMaterialTBV:(NSString *)typeName{
    JSLog(@"代理传过来的typename=%@",typeName);
    NSString *imageBigStr = [[NSBundle mainBundle] pathForResource:@"ImageSmallList" ofType:@"plist"];
    NSDictionary *imageBigDic = [[NSMutableDictionary alloc] initWithContentsOfFile:imageBigStr];
//    JSLog(@"从plist文件拿到的数据:%@",imageBigDic);
   
    
    if ([typeName isEqualToString:@"0"]) {//点击窗帘
         self.typeArray=[imageBigDic valueForKey:@"curtain"];
        self.typeNameStr=@"curtain";
    }else if([typeName isEqualToString:@"1"]){//点击地板
         self.typeArray=[imageBigDic valueForKey:@"land"];
        self.typeNameStr=@"land";
    }else{//点击墙壁
         self.typeArray=[imageBigDic valueForKey:@"wall"];
        self.typeNameStr=@"wall";
        
    }
    [self.tableview reloadData];
}
@end
