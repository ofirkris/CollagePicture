//
//  CHSWebViewController.m
//  MerchantBusinessClient
//
//  Created by 朱新明 on 2020/2/5.
//  Copyright © 2020 com.Chs. All rights reserved.
//

#import "CHSWebViewController.h"

@interface CHSWebViewController ()<WKScriptMessageHandler>

@end

@implementation CHSWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"goBackToNative"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"openLogin"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"openServiceTel"];
    //商户详情
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"openMerchantDetail"];
}

///定死默认状态条内容样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    [super preferredStatusBarStyle];
    return  self.webNavigationBarHide?self.statusBarStyle:UIStatusBarStyleLightContent;;
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"name =%@",message.name);
    if ([message.name isEqualToString:@"goBackToNative"])
    {
        [self messageActionWithGoBackToNative];
    }
    else if ([message.name caseInsensitiveCompare:@"openLogin"] == NSOrderedSame)
    {
        [self messageActionWithTokenError];
    }
    else if ([message.name caseInsensitiveCompare:@"openServiceTel"] == NSOrderedSame)
    {
        [self messageActionWithTelPhoneWithPhoneNumber:message.body];
    }
    else if ([message.name caseInsensitiveCompare:@"openMerchantDetail"] == NSOrderedSame)
    {
        [self messageActionWithRouterMerchantDetailWithUrl:message.body];
    }
}

//返回
- (void)messageActionWithGoBackToNative
{
    [self exitWebViewApp];
}

- (void)messageActionWithTokenError
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationUserTokenError object:nil];
}

- (void)messageActionWithTelPhoneWithPhoneNumber:(NSString *)phone
{
    [[UIApplication sharedApplication]zx_openURLToCallIphoneWithTel:phone];
}

- (void)messageActionWithRouterMerchantDetailWithUrl:(NSString *)url
{
    NSString *string2 = [url stringByReplacingOccurrencesOfString:@"{token}" withString:[UserInfoUDManager getToken]];
     NSString *string3 =[string2 stringByReplacingOccurrencesOfString:@"{ttid}" withString:kAPP_Version];
     CHSWebViewController *vc = [[CHSWebViewController alloc] init];
     [vc loadWebPageWithURLString:string3];
     vc.hidesBottomBarWhenPushed = YES;
     vc.webNavigationBarHide = YES;
     [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
