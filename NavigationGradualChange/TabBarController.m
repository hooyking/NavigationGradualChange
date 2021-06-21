//
//  TabBarController.m
//  NavigationGradualChange
//
//  Created by hooyking on 2021/6/16.
//

#import "TabBarController.h"
#import "BaseNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "Tools.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titleArr = @[@"第一页",@"第二页"];
    NSMutableArray *allNavVC = [NSMutableArray arrayWithCapacity:titleArr.count];
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    NSArray *vcArr = @[firstVC,secondVC];
    
    [vcArr enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseNavigationController *nv = [[BaseNavigationController alloc] initWithRootViewController:obj];
        nv.navigationBar.translucent = YES;
        [nv.navigationBar setBackgroundImage:[Tools imageWithColor:[UIColor redColor] size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
        nv.navigationBar.shadowImage = [UIImage new];
        nv.navigationItem.title = titleArr[idx];
        obj.title = titleArr[idx];
        [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
        nv.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
        nv.navigationBar.barTintColor = [UIColor whiteColor];
        [allNavVC addObject:nv];
    }];
    self.viewControllers = allNavVC;
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = [UIColor grayColor];
        self.tabBar.tintColor = [UIColor redColor];
    }
}

@end
