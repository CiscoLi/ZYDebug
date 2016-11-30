//
//  ZYDebugServerListVC.m
//  ZYDebug
//
//  Created by zhaoyang on 2016/11/29.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "ZYDebugServerListVC.h"
#import "LineView.h"

// ==================================================================
// 布局参数
// ==================================================================
// 控件大小
#define kServerListTableHeaderHeight                50
#define kServerListCellHeight                       44
#define kServerListCellDivideLineHeight             1

//控件间距
#define	kServerListTableViewHMargin					10
#define	kServerListTableViewVMargin					10


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
    _urlField.text = [self getServerName:[self getServerUrl]];
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

// 创建sectionHeaderView子界面
- (void)setupTableViewCellHeader:(UIView *)viewParent
{
    
    // 父窗口尺寸
    CGRect parentFrame = [viewParent frame];
    
    // 子界面高宽
    NSInteger spaceXStart = 0;
    
    // 间隔
    spaceXStart += 10;
    
    // 标题
    NSString *headTitle = @"服务器列表";
    CGSize titleSize = [headTitle sizeWithFont:kCurNormalFontOfSize(14)];
    
    UILabel *labelTitle = [[UILabel alloc] init];
    [labelTitle setFrame:CGRectMake(spaceXStart, (parentFrame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    [labelTitle setFont:kCurNormalFontOfSize(14)];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [labelTitle setTextColor:RGBACOLOR(38, 38, 38, 1)];
    [labelTitle setText:headTitle];
    [viewParent addSubview:labelTitle];
}


// =======================================================================
#pragma mark- 事件函数
// =======================================================================
- (void) cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) confirm
{
    // 保存服务器地址
    NSArray *arrayServerList = [self getServerList];
    NSString *serverUrl = [arrayServerList objectAtIndex:_selectIndex];
    [[NSUserDefaults standardUserDefaults] setObject:serverUrl forKey:SERVERURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
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

// 获取服务器列表
- (NSArray *)getServerList
{
    NSArray *arrayServerList = [PublicMethods fetchArrayAtPathComponent:kServerListFile forKey:kServerListArchiverKey];
    
    if (!ARRAYHASVALUE(arrayServerList))
    {
        arrayServerList = [NSArray arrayWithObjects:
                           kTestNetworkServer,
                           kFormalTestNetworkServer,
                           kFormalNetworkServer,
                           nil];
        
        
        // 保存
        [PublicMethods storeArray:arrayServerList atPathComponent:kServerListFile forKey:kServerListArchiverKey];
        
    }
    
    return arrayServerList;
}

// 获取服务器名称
- (NSString *)getServerName:(NSString *)serverLink
{
    // 获取服务器名称
    NSString *serverName = @"";
    if ([serverLink isEqualToString:kTestNetworkServer])
    {
        serverName = @"测试环境";
    }
    else if ([serverLink isEqualToString:kFormalTestNetworkServer])
    {
        serverName = @"线上测试环境";
    }
    else if ([serverLink isEqualToString:kFormalNetworkServer])
    {
        serverName = @"线上正式环境";
    }
    
    return serverName;
}

// 获取服务器地址
- (NSString *)getServerUrl
{
    // 调试栏是否存在
    if (DEBUGBAR_SWITCH)
    {
        NSString *serverUrl = [[NSUserDefaults standardUserDefaults] objectForKey:SERVERURL];
        
        if (!STRINGHASVALUE(serverUrl))
        {
            serverUrl = kTestNetworkServer;
            
            // 保存
            [[NSUserDefaults standardUserDefaults] setObject:serverUrl forKey:SERVERURL];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        return serverUrl;
        
    }
    // 使用正式地址
    else
    {
        return  kFormalNetworkServer;
    }
    
    
    return nil;
}

// =======================================================================
#pragma mark- TabelViewDataSource的数据源函数
// =======================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arrayServerList = [self getServerList];
    
    return [arrayServerList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 父窗口尺寸
    CGRect parentFrame = [tableView frame];
    
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSArray *arrayServerList = [self getServerList];
    
    cell.textLabel.text = [self getServerName:[arrayServerList objectAtIndex:indexPath.row]];
    cell.textLabel.font = kCurNormalFontOfSize(14);
    cell.textLabel.numberOfLines = 0;
    
    
    CGSize contentViewSize = CGSizeMake(parentFrame.size.width, kServerListCellHeight);
    [[cell contentView] setFrame:CGRectMake(0, 0, contentViewSize.width, contentViewSize.height)];
    
    
    CGSize divideLineSize = CGSizeMake(parentFrame.size.width, kServerListCellDivideLineHeight);
    LineView *divideLine = [[LineView alloc] init];
    [divideLine setFrame:CGRectMake(0, contentViewSize.height-kServerListCellDivideLineHeight, divideLineSize.width, divideLineSize.height)];
    [divideLine setArrayColor:[NSArray arrayWithObject:RGBACOLOR(235, 235, 235, 0.8)]];
    [[cell contentView] addSubview:divideLine];
    
    return cell;
    
}

// =======================================================================
#pragma mark- TableViewDelegate的代理函数
// =======================================================================
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kServerListCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arrayServerList = [self getServerList];
    
    _urlField.text = [self getServerName:[arrayServerList objectAtIndex:indexPath.row]];
    
    // 保存index
    _selectIndex = indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect parentFrame = [tableView frame];
    
    CGSize viewHeaderSize = CGSizeMake(parentFrame.size.width, kServerListTableHeaderHeight);
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewHeaderSize.width, viewHeaderSize.height)];
    [viewHeader setBackgroundColor:RGBACOLOR(245, 245, 245, 1.0)];
    
    [self setupTableViewCellHeader:viewHeader];
    
    return viewHeader;
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return kServerListTableHeaderHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [PublicMethods resignKeyboard];
}

#pragma mark textField 代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    // 与已保存的列表比较，如果不相同则保存
    
    
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
