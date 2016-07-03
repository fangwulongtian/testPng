//
//  DragView2.m
//  testPng
//
//  Created by 方武显 on 16/7/2.
//  Copyright © 2016年 小五哥学Swift. All rights reserved.
//

#import "DragView2.h"

@interface DragView2(){
    UIButton *contorlBtn;
    UIButton *deleteBTn;
    CGPoint tempPoint;
    CGPoint previousLocation;
}
@end

@implementation DragView2

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        self.gestureRecognizers = @[pan];
        
        //拉伸按钮，点击时反色
        contorlBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [contorlBtn setImage:[UIImage imageNamed:@"scale.png"] forState:UIControlStateNormal];
        [contorlBtn setImage:[UIImage imageNamed:@"scaled.png"] forState:UIControlStateSelected];
        [contorlBtn setFrame:CGRectMake(self.frame.size.width-40, self.frame.size.height-40, 40, 40)];
       [self addSubview:contorlBtn];
        
        UILongPressGestureRecognizer * tapL=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPress:)];
        tapL.minimumPressDuration=0.0;//0.7
        [contorlBtn addGestureRecognizer:tapL];
        tempPoint = CGPointMake(0, 0);
        
        //移除按钮
        deleteBTn=[UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBTn setImage:[UIImage imageNamed:@"deleteTitle.png"] forState:UIControlStateNormal];
        [deleteBTn setFrame:CGRectMake(0,0, 40, 40)];
        [deleteBTn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBTn];
        
        //给个框
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor greenColor].CGColor;
    }
    return self;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 点击的图片马上移到最前面
    [self.superview bringSubviewToFront:self];
    
    //记住原始中心点，方便计算移动后的位置
    previousLocation = self.center;
}

//拖动后改变中心位置
- (void) handlePan: (UIPanGestureRecognizer *) uigr
{
    CGPoint translation = [uigr translationInView:self.superview];
    CGPoint newcenter = CGPointMake(previousLocation.x + translation.x, previousLocation.y + translation.y);
    
    // Bound movement into parent bounds
    float halfx = CGRectGetMidX(self.bounds);
    newcenter.x = MAX(halfx, newcenter.x);
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
    // Set new location
    self.center = newcenter;
}

/**
 *  拉伸按钮的长时间点击手势
 *
 *  @param LG
 */
-(void)LongPress:(UILongPressGestureRecognizer * )LG
{
    CGPoint point = [LG locationInView:self.superview];
    //刚点击时，记录坐标
    if (LG.state == UIGestureRecognizerStateBegan)
    {
        tempPoint = CGPointMake(point.x, point.y);
        [contorlBtn setImage:[UIImage imageNamed:@"scaled.png"] forState:UIControlStateNormal];
    }
    [self adjust:point];
}


/**
 *  调整图片的大小
 *
 *  @param point
 */
-(void)adjust:(CGPoint)point
{
    float _x=point.x-tempPoint.x;
    float _y=point.y-tempPoint.y;
    
    float _w=self.frame.size.width;
    float _h=self.frame.size.height;
    
    float _x_new=0;
    float _y_new=0;
    
    if ((_x*_x)>(_y*_y))
    {
        _x_new=_x;
        _y_new=_x*_h/_w;
    }
    else{
        _x_new=_y*_w/_h;
        _y_new=_y;
        
    }
    
    if (_x_new+_w<150)
    {
        return;
    }
    CGPoint old=CGPointMake(self.center.x, self.center.y);
    [self setFrame:CGRectMake(self.frame.origin.x
                              , self.frame.origin.y, _x_new+_w, _y_new+_h)];
    [self setCenter:old];
    
    [contorlBtn setFrame:CGRectMake(self.frame.size.width-40, self.frame.size.height-40, 40, 40)];

    tempPoint = CGPointMake(point.x, point.y);//add
    
}

-(void)clickDeleteBtn:(UIButton*)sender{
    NSLog(@"这里移动图层，暂时不做");
}

@end
