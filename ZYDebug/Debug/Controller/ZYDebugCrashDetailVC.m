//
//  ZYDebugCrashDetailVC.m
//  ZYDebug
//
//  Created by zhaoyang on 2016/12/2.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "ZYDebugCrashDetailVC.h"

// ==================================================================
// 布局参数
// ==================================================================
//
#define kCrashDetailCopyButtonHeight                    50

//控件间距
#define	kCrashDetailTableViewHMargin					10
#define	kCrashDetailTableViewVMargin					10
#define	kCrashDetailTableViewMiddleVMargin				20
#define kCrashDetailCellHMargin                         10
#define kCrashDetailCellVMargin                         5

//控件字体
#define	kCrashDetailContentLabelFont                    [UIFont systemFontOfSize:10.0f]
#define	kCrashDetailCrashTitleLabelFont                 [UIFont boldSystemFontOfSize:16.0f]

@interface ZYDebugCrashDetailVC ()

@end

@implementation ZYDebugCrashDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBACOLOR(245, 245, 245, 1.0)];
    
    // 创建Root View的子视图
    [self setupViewRootSubs:[self view]];
}

// 复制详情
- (void)copyDetailBtnPressed:(id)sender
{
    NSString *crashDesc = [_crashDetail description];
    
    if ((crashDesc != nil) && ([crashDesc length] > 0))
    {
        [[UIPasteboard generalPasteboard] setPersistent:YES];
        
        [[UIPasteboard generalPasteboard] setValue:crashDesc forPasteboardType:[UIPasteboardTypeListString objectAtIndex:0]];
        
        //[AlertView addNotifierWithText:@"已复制到剪贴板" dismissAutomatically:YES];
        
    }
}

// =======================================================================
#pragma mark- 布局函数
// =======================================================================
// 创建Root View的子界面
- (void)setupViewRootSubs:(UIView *)viewParent
{
    // =======================================================================
    // TableView
    // =======================================================================
    UITableView *tableViewInfo = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableViewInfo setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20 -44)];
    [tableViewInfo setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableViewInfo setSeparatorColor:[UIColor clearColor]];
    [tableViewInfo setDataSource:self];
    [tableViewInfo setDelegate:self];
    [tableViewInfo setShowsVerticalScrollIndicator:NO];
    [tableViewInfo setBackgroundColor:[UIColor clearColor]];
    
    //保存
    [viewParent addSubview:tableViewInfo];
    
}



// 创建crash详情子界面
- (void)setupTableCellIntroduceSubs:(UIView *)viewParent inSize:(CGSize *)pViewSize
{
    // 子窗口高宽
    NSInteger spaceXStart = 0;
    NSInteger spaceXEnd = pViewSize->width;
    NSInteger subsHeight = 0;
    NSInteger spaceYStart = 0;
    
    /* 间隔 */
    spaceXStart += kCrashDetailTableViewHMargin;
    spaceXEnd -= kCrashDetailTableViewHMargin;
    spaceYStart += kCrashDetailTableViewVMargin;
    
    // =======================================================================
    // crash详情 Label
    // =======================================================================
    NSString *crashDesc = [_crashDetail description];
    
    
    if ((crashDesc != nil) && ([crashDesc length] > 0))
    {
        CGSize introductionSize = [crashDesc sizeWithFont:kCrashDetailContentLabelFont
                                        constrainedToSize:CGSizeMake(spaceXEnd - spaceXStart, CGFLOAT_MAX)
                                            lineBreakMode:NSLineBreakByWordWrapping];
        
        UITextView *textInfo = [[UITextView alloc] initWithFrame:CGRectZero];
        [textInfo setBackgroundColor:[UIColor clearColor]];
        [textInfo setEditable:NO];
        [textInfo setScrollEnabled:NO];
        [textInfo setFont:kCrashDetailContentLabelFont];
        [textInfo setTextColor:[UIColor blackColor]];
        [textInfo setAutoresizesSubviews:YES];
        [textInfo setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [textInfo setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [textInfo setFrame:CGRectMake(spaceXStart, spaceYStart, spaceXEnd - spaceXStart, introductionSize.height+5)];
        [textInfo setText:crashDesc];
        
        // 保存
        [viewParent addSubview:textInfo];
        
        // 调整子窗口高宽
        spaceYStart += textInfo.frame.size.height;
        
        // 间隔
        spaceYStart += kCrashDetailTableViewMiddleVMargin*4;
        
    }
    
    
    // 间隔
    spaceYStart += kCrashDetailTableViewVMargin;
    
    
    // =======================================================================
    // 设置父窗口的尺寸
    // =======================================================================
    subsHeight = spaceYStart;
    pViewSize->height = subsHeight;
    if(viewParent != nil)
    {
        [viewParent setViewHeight:subsHeight];
    }
}

// =======================================================================
// TabelViewDataSource的代理函数
// =======================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 父窗口尺寸
    CGRect parentFrame = [tableView frame];
    
    // Item
    NSString *reusedIdentifer = @"CrashDetailTCID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifer];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:reusedIdentifer];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        // 创建contentView
        CGSize contentViewSize = CGSizeMake(parentFrame.size.width, 0);
        [[cell contentView] setFrame:CGRectMake(0, 0, contentViewSize.width, contentViewSize.height)];
        [self setupTableCellIntroduceSubs:[cell contentView] inSize:&contentViewSize];
    }
    
    return cell;
}

// =======================================================================
// TableViewDelegate的代理函数
// =======================================================================
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 父窗口尺寸
    CGRect parentFrame = [tableView frame];
    
    // Item
    CGSize contentViewSize = CGSizeMake(parentFrame.size.width, 0);
    [self setupTableCellIntroduceSubs:nil inSize:&contentViewSize];
    
    return contentViewSize.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
