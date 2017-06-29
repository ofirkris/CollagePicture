//
//  UIViewController+Base.m
//  CollagePicture
//
//  Created by simon on 15/7/6.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "UIViewController+LoginAndAlert.h"
#import "UserInfoUDManager.h"

static  NSString *const sbLoginStoryboard=@"RegisterLogin";
static  NSString *const sbLoginNavControllerID = @"sLoginNavControllerID" ;

static  NSString *const sLoginController = @"WYLoginViewController";

static  BOOL sLoginControllerFromStroyboard = NO;


@implementation UIViewController (LoginAndAlert)




- (BOOL)zh_performIsLoginActionWithPopAlertView:(BOOL)flag
{
    if (![UserInfoUDManager isLogin])
    {
        if (flag)
        {
            [self addAlertController];
        }
        else
        {
            [self zh_presentLoginController];
        }
        return NO;
    }
    return YES;
}



- (void)zh_performIsLoginActionWithSelector:(SEL)action withPopAlertView:(BOOL)flag
{
    if ([UserInfoUDManager isLogin])
    {
        IMP imp = [self methodForSelector:action];
        void(*func)(id,SEL) = (void *)imp;
        func(self,action);
    }
    else
    {
        if (flag)
        {
            [self addAlertController];
        }
        else
        {
            [self zh_presentLoginController];
        }
    }
}


- (void)zh_performLoginAlertViewWithSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2
{
    
    if ([UserInfoUDManager isLogin])
    {
        [self performSelector:aSelector withObject:object1 withObject:object2];
    }
    else
    {
        [self addAlertController];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag ==100)
    {
        if (buttonIndex!=alertView.cancelButtonIndex)
        {
            [self zh_presentLoginController];
        }
    }
}


- (void)addAlertController
{
    if (__IPHONE_8_0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"您还没有登录，是否需要登录", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self zh_presentLoginController];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        BOOL isAddProtocol = class_conformsToProtocol(self.class, @protocol(UIAlertViewDelegate));
        if (!isAddProtocol)
        {
            class_addProtocol([self class], @protocol(UIAlertViewDelegate));
        }

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有登录，是否需要登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag =100;
        [alert show];
    }
}



- (void)zh_presentLoginController
{
    if (sLoginControllerFromStroyboard)
    {
        UIStoryboard *sb=[UIStoryboard  storyboardWithName:sbLoginStoryboard  bundle:[NSBundle mainBundle]];
        UIViewController *loginViewController = [sb instantiateViewControllerWithIdentifier:sbLoginNavControllerID];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
    else
    {
        UIViewController * vc = (UIViewController *)[[NSClassFromString(sLoginController) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        if (nav)
        {
            nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}




@end
