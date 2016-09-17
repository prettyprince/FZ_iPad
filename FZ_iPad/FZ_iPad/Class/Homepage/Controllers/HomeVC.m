//
//  HomeNavController.m
//  FZ_iPad
//
//  Created by Jeemy on 16/9/9.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "HomeVC.h"
#import <CoreLocation/CoreLocation.h>
#import "HomepageCell.h"
#import "CoHomeReuseView.h"
#import "CityChoiceView.h"
#import "HomeShareData.h"

@interface HomeVC ()<CLLocationManagerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic ,strong)CLLocationManager *locationManager;
@property (nonatomic ,strong)CityListView *cityListV;
@property (nonatomic ,strong)MenuView *menuView;
@property (nonatomic ,strong)HousesStyleVC *hourseStyleVC;
@property (nonatomic ,strong)NSMutableArray *imgsArray;
@end

@implementation HomeVC

/**
 *懒加载
 */
-(NSMutableArray *)imgsArray{
    if (_imgsArray==nil) {
        _imgsArray=[[NSMutableArray alloc]init];
        for(int i=0;i<5;i++){
            [_imgsArray addObject:[NSString stringWithFormat:@"curtainbig%d",i+1]];
        }
    }
    return _imgsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"重庆";
    self.view.backgroundColor=[UIColor whiteColor];
    
    //增加通知中心
    [JSNotificationCenter addObserver:self selector:@selector(cityChoice:) name:@"CityChoice" object:nil];
    //设置下拉菜单
    [self setupMenu];
//    [self setupNewMenu];
    
    
    //设置collectionController
    [self collectionSetup];
//    [self jiugongge];
    [self setCity];
}

-(void)cityChoice: (NSNotification *)noti{
//设置导航上的城市标题
    [self.menuView setTitle:noti.object];
}

/**
 *自定义弹出菜单
 */

-(void)setupNewMenu{
    if (self.navigationItem) {
        
//        UIImageView *imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cityBg"]];
        self.menuView=[[MenuView alloc]initWithFrame:CGRectMake(0, 0, 300, self.navigationController.navigationBar.bounds.size.height) title:@"重庆" image:nil];
        
        self.menuView.delegate=self;
        
//        JSLog(@"menuV.frame:%@",NSStringFromCGRect(menuV.frame));
        self.navigationItem.titleView=self.menuView;
        
    }
    
}

-(void)choiceCity:(NSString *)city{
    JSLog(@"您选择的城市是:%@",city);
    
    self.cityListV = [[CityListView alloc]init];
    [self.cityListV removeFromSuperview];
  
    [JSNotificationCenter postNotificationName:@"CityChoice" object:city];
    
    

}
- (void)didSelectItemAtIndex:(NSUInteger)index{
    
    
//    JSLog(@"menuView的代理,代理直：%ld",index);
}

/**
 *设置布局collectionView
 */
-(void)collectionSetup{
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, UIScreenSize.width, UIScreenSize.height-64) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[HomepageCell class] forCellWithReuseIdentifier:@"Cell"];
    //注册view
    [self.collectionView registerClass:[CoHomeReuseView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    [self.view addSubview:self.collectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *导航栏
 */

-(void)hideMenu{
    JSLog(@"代理代理");
}

/**
 *制作城市下拉菜单
 */
- (void)setupMenu
{
    
    if (self.navigationItem) {
        CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
//        SINavigationMenuView *menu = [[SINavigationMenuView alloc] initWithFrame:frame title:@"重庆"];
//        menu.userInteractionEnabled=YES;
//        [menu displayMenuInView:self.view];
//        menu.items = @[@"重庆", @"杭州", @"宁波", @"上海", @"南宁"];
//        menu.delegate = self;
//        self.navigationItem.titleView = menu;
        UIView *titleV=[[UIView alloc]initWithFrame:frame];
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, titleV.width, titleV.height)];
        [btn setTitle:@"点我" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside ];
        titleV.backgroundColor=[UIColor redColor];
        [titleV addSubview:btn];
        
        self.navigationItem.titleView=titleV;
       
    }
}
-(void)clickBtn:(UIButton *)btn{
    CityChoiceView *view=[[CityChoiceView alloc]initWithFrame:CGRectMake(UIScreenSize.width-400, 50, 400, UIScreenSize.height-300)];
    //UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    [view displayView:btn];
}

/**
 *城市定位
 */
-(void)setCity{
    // 1、判断设备是否开启定位服务
    if (![CLLocationManager locationServicesEnabled]) {
        // 弹框提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                 message:@"您的设备暂未开启定位服务!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil]];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
        return;
    }
    // 2、初始化定位服务
    _locationManager = [[CLLocationManager alloc] init];
    // 3、请求定位授权
    
    // a、请求在使用期间授权（弹框提示用户是否允许在使用期间定位）,需添加NSLocationWhenInUseUsageDescription到info.plist；
    // b、请求在后台定位授权（弹框提示用户是否允许不在使用App时仍然定位）,需添加NSLocationAlwaysUsageDescription添加key到info.plist；
    [_locationManager requestAlwaysAuthorization];
    
    // 4、设置定位精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // 5、设置定位频率，每隔多少米定位一次
    _locationManager.distanceFilter = 10.0;
    
    // 6、设置代理
    _locationManager.delegate = self;
    
    // 7、开始定位
    // 注意：开始定位比较耗电，不需要定位的时候最好调用[stopUpdatingLocation]结束定位。
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate methods
// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    JSLog(@"定位失败：%@",error);
}

// 位置更新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 获取最新定位
    CLLocation *locatition = locations.lastObject;
    // 打印位置信息
    JSLog(@"latitude：%.2f, longitude：%.2f", locatition.coordinate.latitude, locatition.coordinate.longitude);
    
    //获取当前城市名
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //根据经纬度反向编译出地址信息
    [geocoder reverseGeocodeLocation:locatition completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count>0) {
            CLPlacemark *placemark =[placemarks objectAtIndex:0]
            ;
           //将获得的所有信息显示到label上
            JSLog(@"获取的所有信息:%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            
                    if (!city) {
            
                        //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
            
                        city = placemark.administrativeArea;
                        
                    }
            JSLog(@"当前城市为:%@",city);
            NSString *l0City=[NSString stringWithFormat:@"当前城市:%@",city];
            self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:l0City style:UIBarButtonItemStylePlain target:self action:nil] ;

        }
        else if (error == nil && [placemarks count] == 0)
            
                {
            
                    JSLog(@"No results were returned.");
            
                }
            
                else if (error != nil)
            
                {
                    
                    JSLog(@"An error occurred = %@", error);
                    
                }
    }];
    
    // 停止定位
    [_locationManager stopUpdatingLocation];

}




/**
 *collection的协议和代理
 */
#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgsArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     JSLog(@"imgs=%@,row=%ld,item=%ld",self.imgsArray[indexPath.item],indexPath.row,indexPath.item);
    static NSString * CellIdentifier = @"Cell";
     HomepageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
     cell.imgStr=self.imgsArray[indexPath.item];
    cell.imageView.image= [UIImage imageNamed:self.imgsArray[indexPath.row]];
    self.homeModelData.array=self.imgsArray;
    cell.homeModelData=nil;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reView=nil;
    if(kind == UICollectionElementKindSectionHeader){
        CoHomeReuseView *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        view.title.text = [[NSString alloc] initWithFormat:@"头部视图%ld",indexPath.section];
        reView=view;
    }
    return reView;
    
}
#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    CGFloat screenW=UIScreenSize.width;
    //    CGFloat screenH=UIScreenSize.height;
    CGFloat interval=UIScreenSize.width*0.08;
    CGFloat oneW=(screenW-4*interval)/3;
    return CGSizeMake(oneW , oneW);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat interval=UIScreenSize.width*0.08;
    return UIEdgeInsetsMake(5, interval, 5, interval);//上左下右
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    cell.backgroundColor = [UIColor greenColor];
    NSLog(@"item======%ld",indexPath.item);
    NSLog(@"row=======%ld",indexPath.row);
    NSLog(@"section===%ld",indexPath.section);
    self.hourseStyleVC=[[HousesStyleVC alloc]init];
    self.hourseStyleVC.hoursesName= @"北京和重庆";
    [self.navigationController pushViewController:self.hourseStyleVC animated:NO];
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return UIScreenSize.width*0.08;
}

@end

