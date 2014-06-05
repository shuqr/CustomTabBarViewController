//
//  CDCTabBarViewController.m
//  CustomTabBarViewController
//
//  Created by Chanry on 14-4-3.
//  Copyright (c) 2014年 Chanry. All rights reserved.
//

#import "CDCTabBarViewController.h"
#import <objc/runtime.h>

@interface CDCTabBarViewController ()

@end

@implementation CDCTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self hideRealTabBar];
    
    if (!self.cdcTabBar) {
        [self addCustomMyTabBar];
    }
}


//隐藏自带tabbar
- (void)hideRealTabBar{
    
    for(UIView *view in self.view.subviews){
        
        if([view isKindOfClass:[UITabBar class]]){
            
            view.hidden = YES;
            
            break;
        }
    }
}

//加上自定义tabbar
- (void)addCustomMyTabBar{
    
    NSMutableArray *tabItemsArray = [[NSMutableArray alloc] init];
    CDCTabBarModel *tabBarModel = [[CDCTabBarModel alloc] initWithJsonFile];
    
    if (tabBarModel.tabBarItems) {
        int index = 0;
        for (CDCTabBarItemModel *model in tabBarModel.tabBarItems) {
            CDCTabBarItem *item = [[CDCTabBarItem alloc] initWithTabBarModel:model barTotalNum:[tabBarModel.tabBarItems count] currentIndex:index++ selectedAction:^{
                NSLog(@"index:%d",index);
            }];
            [tabItemsArray addObject:item];
        }
    }
    
    self.cdcTabBar = [[CDCTabBar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-kCDCTabBarHeight, [UIScreen mainScreen].bounds.size.width, kCDCTabBarHeight) tabBarItems:tabItemsArray moreBar:tabBarModel.moreBar];
    [self.view addSubview:self.cdcTabBar];
}

- (void)switchIndex {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


/**
 *  根据字符串获取类
 */
//- (Class)getClass {
//    Class clz = objc_get_class();
//    
//    clz *item = [[clz alloc] init];
//}
- (void)hideTabBar {
    self.cdcTabBar.hidden = YES;
}
- (void)showTabBar {
    self.cdcTabBar.hidden = NO;
}

- (void)hideTabBarWithoutAnimation {
    self.cdcTabBar.hidden = YES;
}

@end
