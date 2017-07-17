//
//  LockView.m
//  ZYDebug
//
//  Created by zhaoyang on 2017/7/17.
//  Copyright © 2017年 zhaoyang. All rights reserved.
//

#import "LockView.h"

@interface LockView ()

@property (nonatomic, strong) NSMutableArray *selectedsBtn;

@property (nonatomic, assign) CGPoint curP;

@end

@implementation LockView

+ (instancetype)lockView
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    
    return [nib instantiateWithOwner:nil options:nil].firstObject;
}

- (NSMutableArray *)selectedsBtn
{
    if (_selectedsBtn == nil) {
        _selectedsBtn = [NSMutableArray array];
    }
    
    return _selectedsBtn;
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    
    // 获取触摸点
    _curP = [sender locationInView:self];
    
    //判断触摸点在不在按钮上
    for (UIButton *btn  in self.subviews) {
        //点在不在某个范围内,并且按钮没有被选中
        if (CGRectContainsPoint(btn.frame, _curP)&& btn.selected == NO) {
            //点在按钮上
            btn.selected = YES;
            
            //保存到数组里
            [self.selectedsBtn addObject:btn];
        }
    }
    
    //重绘
    [self setNeedsDisplay];
    
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSMutableString *strM = [NSMutableString string];
        for (UIButton *btn  in self.selectedsBtn) {
            [strM appendFormat:@"%ld",btn.tag];
        }
        
        NSLog(@"选中数字%@",strM);
        
        [self.selectedsBtn makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
        
        [self.selectedsBtn removeAllObjects];
    }
    
   
    
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    // 创建九个按钮
    for (int i = 0; i < 9 ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        btn.tag = i;
        
        [self addSubview:btn];
    }

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    NSUInteger count = self.subviews.count;
    int cols = 3;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 74;
    CGFloat h = 74;
    CGFloat margin = (self.bounds.size.width - cols * w) / (cols + 1);
    
    CGFloat col = 0;
    CGFloat row = 0;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        // 获取当前按钮的列数
        col = i % cols;
        row = i / cols;
        x = margin + col * (margin + w);
        y = row * (margin + w);
        
        btn.frame = CGRectMake(x, y, w, h);
        
    }
}



- (void)drawRect:(CGRect)rect
{
    // 没有选中按钮，不需要连线
    if (self.selectedsBtn.count == 0) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSInteger count = self.selectedsBtn.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.selectedsBtn[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
    }
    
    [path addLineToPoint:_curP];
    [[UIColor greenColor] set];
    path.lineWidth = 10;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
}




























@end
