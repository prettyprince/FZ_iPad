//
//  LoginVC.m
//  FZ_iPad
//
//  Created by Jeemy Tim Miller on 16/9/16.
//  Copyright © 2016年 Jeemy. All rights reserved.
//

#import "LoginVC.h"
#import "HomeVC.h"
#import "DLUDID.h"
@interface LoginVC ()
@property(nonatomic ,strong)UITextField *usernameTF;
@property (nonatomic ,strong)UITextField *passwordTF;
@property (nonatomic ,strong)UITextField *phoneNumberTF;
@property (nonatomic ,strong)UIButton *loginBtn;
@end

@implementation LoginVC

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //设置登录界面
    [self setUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUI{
    //1.用户名和密码
    self.usernameTF=[[UITextField alloc]initWithFrame:CGRectMake(UIScreenSize.width/2-100 , UIScreenSize.height/2-200,200, 40)];
    self.usernameTF.backgroundColor=JSRandomColor;
    self.passwordTF=[[UITextField alloc]initWithFrame:CGRectMake(self.usernameTF.x, self.usernameTF.y+70, 200, 40)];
    self.passwordTF.backgroundColor=JSRandomColor;
    [self.view addSubview:self.usernameTF];
    [self.view addSubview:self.passwordTF];
    //2.手机验证码
    self.phoneNumberTF= [[UITextField alloc]initWithFrame:CGRectMake(self.passwordTF.x, self.passwordTF.y+70, 200, 40)];
    self.phoneNumberTF.backgroundColor=JSRandomColor;
    [self.view addSubview: self.phoneNumberTF];
    //3.登录
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenSize.width/2-25, self.phoneNumberTF.y+200, 50, 30)];
    self.loginBtn.backgroundColor=JSRandomColor;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *实现登录
 */
-(void)login:(UIButton *)btn{
    [self getUDID];

    //用户提示
    UIAlertController *alertC= [UIAlertController alertControllerWithTitle:@"登陆失败！" message:@"用户名或密码错误，请重新输入！" preferredStyle:UIAlertControllerStyleAlert];//styleActionSheet是下拉菜单
    
    
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *otherAction=[UIAlertAction actionWithTitle:@"无视" style:UIAlertActionStyleDestructive handler:nil];
    
    [alertC addAction:cancelAction];
    
    [alertC addAction:confirmAction];
    
    [alertC addAction:otherAction];
    
    
    
    [self presentViewController:alertC animated:YES completion:nil ];
    
    
    //测试直接登录
    UIWindow *window=[[UIApplication sharedApplication] keyWindow];
    UINavigationController *homeNav=[[UINavigationController alloc]init];
    HomeVC *vc=[[HomeVC alloc]init];
    [homeNav addChildViewController:vc];
    window.rootViewController=homeNav;
}

/**
 *获取UDID
 */
-(void)getUDID{
//        NSUUID *uuid =[UIDevice currentDevice].identifierForVendor;
    
      NSString *openUDID = [DLUDID value];//获取udid，保证udid的唯一性，并让之不与uuid一样卸载后uuid就会变，这个保存到keychain中不会变化，再通过userdefault和
    JSLog(@"uuid=%@",openUDID);
    
}

/**
 *上传用户名和密码,从服务器取回数据
 */

-(void)getTheDataForServer{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    JSLog(@"params=%@",params);
    
    NSString *url=[NSString stringWithFormat:@"http://teacher-api.anoedu.com/user/avatar/%@"];
    // 3.发送请求  http://dev.anoedu.com/api-konakona-test.php
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        JSLog(@"responseobject=%@",[responseObject replaceUnicode]);
        NSDictionary *dic=[responseObject valueForKey:@"meta"];
        NSString *strCode=[NSString stringWithFormat:@"%@",[dic valueForKey:@"code"]];
        NSDictionary *dicData=[responseObject valueForKey:@"data"];
        if ([strCode isEqualToString:@"0"]) {//如果返回请求数据成功
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
