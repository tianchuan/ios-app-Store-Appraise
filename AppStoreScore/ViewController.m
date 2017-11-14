//
//  ViewController.m
//  AppStoreScore
//
//  Created by tianchuan on 2017/11/10.
//  Copyright © 2017年 score. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>

const NSString *appId = @"981001429614";

@interface ViewController ()<SKStoreProductViewControllerDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)onclick_score {
    //跳出应用,跳转到AppStore,进行评分
    
    NSString *storeStr=[NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:storeStr]];
}
- (IBAction)onclick_interiorRating {
    //此方法只能跳转到商店评分界面，点击评分无反应
    //苹果提供了一个框架StoreKit.framework,导入StoreKit.framework,在需要跳转的控制器里面添加头文件#import, 实现代理方法：< SKStoreProductViewControllerDelegate >
    SKStoreProductViewController *storeProductView = [[SKStoreProductViewController alloc] init];
    storeProductView.delegate=self;
    [storeProductView loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:appId} completionBlock:^(BOOL result, NSError * _Nullable error) {
        
        if(error){
            NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
        }else{
            // 模态弹出appstore
            [self presentViewController:storeProductView animated:YES completion:nil];
        }
    }];
}
#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
