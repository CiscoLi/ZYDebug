//
//  ZYDebugServerListVC.m
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/29.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "ZYDebugServerListVC.h"


@interface ZYDebugServerListVC ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableViewList;

@property (nonatomic, strong) UITextField *urlField;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation ZYDebugServerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(245, 245, 245, 1.0)];
    
    // 数据初始化
    [self initDataSource];
    
    
    // 创建Root View的子视图
    [self setupViewRootSubs:[self view]];
}

// =======================================================================
#pragma mark- 布局函数
// =======================================================================
// 创建Root View的子界面
- (void)setupViewRootSubs:(UIView *)viewParent
{
    // 子窗口
    NSInteger spaceYStart = 0;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定  " style:UIBarButtonItemStyleDone target:self action:@selector(confirm)];
    
    
    // 间隔
    spaceYStart += 44+20;
    
    // 间隔
    spaceYStart += 10;
    
    // 提示label
    NSString *serverTip = @"选定的服务器地址：";
    
    CGSize tipSize = [serverTip sizeWithFont:kCurNormalFontOfSize(15)];
    
    UILabel *labelTip = [[UILabel alloc] init];
    [labelTip setFrame:CGRectMake(10, spaceYStart, tipSize.width, tipSize.height)];
    [labelTip setBackgroundColor:[UIColor clearColor]];
    [labelTip setFont:kCurNormalFontOfSize(15)];
    [labelTip setTextAlignment:NSTextAlignmentCenter];
    [labelTip setTextColor:RGBACOLOR(38, 38, 38, 1)];
    [labelTip setText:serverTip];
    [viewParent addSubview:labelTip];
    
    // 子界面大小
    spaceYStart += tipSize.height;
    
    // 间隔
    spaceYStart += 10;
    
    
    // 地址显示栏
    _urlField = [[UITextField alloc] initWithFrame:CGRectMake(0, spaceYStart, SCREEN_WIDTH, 40)];
    _urlField.borderStyle = UITextBorderStyleRoundedRect;
    _urlField.placeholder = @"Server URL";
    //_urlField.text = [self getServerName:[NetworkUtil getServerUrl]];
    _urlField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _urlField.font = kCurNormalFontOfSize(14);
    _urlField.delegate = self;
    _urlField.returnKeyType = UIReturnKeyDone;
    _urlField.enabled = NO;
    [viewParent addSubview:_urlField];
    
    // 子界面大小
    spaceYStart += 40;
    
    // 间隔
    spaceYStart += 10;
    
    // =======================================================================
    // TableView
    // =======================================================================
    UITableView *tableViewListTmp = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableViewListTmp setFrame:CGRectMake(0, spaceYStart, SCREEN_WIDTH, SCREEN_HEIGHT-44-20-spaceYStart)];
    [tableViewListTmp setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableViewListTmp setSeparatorColor:[UIColor clearColor]];
    [tableViewListTmp setDataSource:self];
    [tableViewListTmp setDelegate:self];
    [tableViewListTmp setShowsVerticalScrollIndicator:NO];
    [tableViewListTmp setBackgroundColor:[UIColor clearColor]];
    
    //保存
    [self setTableViewList:tableViewListTmp];
    [viewParent addSubview:tableViewListTmp];
}

// =======================================================================
#pragma mark- 事件函数
// =======================================================================
- (void) cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// =======================================================================
#pragma mark- 辅助函数
// =======================================================================
- (void)initDataSource
{
    NSString *serverUrl = [[NSUserDefaults standardUserDefaults] objectForKey:SERVERURL];
    
    if (STRINGHASVALUE(serverUrl))
    {
        NSArray *arrayServerList = [PublicMethods fetchArrayAtPathComponent:kServerListFile forKey:kServerListArchiverKey];
        
        if (ARRAYHASVALUE(arrayServerList))
        {
            NSInteger urlIndex = [arrayServerList indexOfObject:serverUrl];
            if (urlIndex != NSNotFound)
            {
                _selectIndex = urlIndex;
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
