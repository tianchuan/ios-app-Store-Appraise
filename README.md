跳转到AppStore评分,有两种方法：

1、一种是跳出应用,跳转到AppStore,进行评分；
2、另一种是在应用内,内置AppStore进行评分。

appId 在https://itunesconnect.apple.com中创建应用即可在应用界面获得

1.跳出应用,跳转到AppStore,进行评分

[[UIApplicationsharedApplication]openURL:[NSURLURLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=APPID&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];（APPID可在itunce里面查到）

2.在应用内,内置AppStore进行评分

苹果提供了一个框架StoreKit.framework,导入StoreKit.framework,在需要跳转的控制器里面添加头文件#import, 实现代理方法：< SKStorePRoductViewControllerDelegate >

//自定义方法
```c
- (void)loadAppStore
{
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
```

在info.plist 中 添加App Transport Security Settings


