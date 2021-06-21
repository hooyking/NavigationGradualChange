//
//  FirstViewController.m
//  NavigationGradualChange
//
//  Created by hooyking on 2021/6/16.
//

#import "FirstViewController.h"
#import "Tools.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *rightBarBtnItem;
@property (nonatomic, assign) CGFloat navBarAlpha;




@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //extendedLayoutIncludesOpaqueBars设置为YES是为了保证设置导航栏translucent为NO时self.view的起点依然为(0, 0)
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = self.tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"buycarblack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.rightBarBtnItem = rightBarBtnItem;
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[Tools imageWithColor:[UIColor colorWithRed:246/255.0 green:18/255.0 blue:56/255.0 alpha:0] size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
}

/**
 注意，要在控制器里设置导航栏状态需要先设置View controller-based status bar appearance 为YES，在有导航栏的页面，一定要设置导航栏控制器preferredStatusBarStyle由visibleViewController即他的子控制决定（见BaseNavigationController），然后在子控制起设置preferredStatusBarStyle
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.navBarAlpha > 0.8) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试";
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *imageVi = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    imageVi.image = [UIImage imageNamed:@"girl"];
    return imageVi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = offset / 40;
    self.navBarAlpha = alpha;
    NSLog(@"y轴偏移量：%f*******透明度：%f",offset,alpha);
    [self.navigationController.navigationBar setBackgroundImage:[Tools imageWithColor:[UIColor colorWithRed:246/255.0 green:18/255.0 blue:56/255.0 alpha:alpha] size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    if (alpha > 0.8) {
        [self setLightStyle];
    } else {
        [self setBlackStyle];
    }
    [self setNeedsStatusBarAppearanceUpdate];//更新状态栏
}

- (void)setBlackStyle {
    self.rightBarBtnItem.image = [[UIImage imageNamed:@"buycarblack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
    self.navigationController.navigationBar.translucent = YES;
}

- (void)setLightStyle {
    self.rightBarBtnItem.image = [[UIImage imageNamed:@"buycarwhite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
    self.navigationController.navigationBar.translucent = NO;//这儿设置为NO是为了保证导航栏一点不透明，视觉不看到下一层
}

@end
