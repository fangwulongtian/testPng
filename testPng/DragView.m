//
//  DragView.m
//  testPng
//
//  Created by 方武显 on 16/7/2.
//  Copyright © 2016年 小五哥学Swift. All rights reserved.
//

#import "DragView.h"

//透明偏移
NSUInteger alphaOffset(NSUInteger x, NSUInteger y, NSUInteger w){return y * w * 4 + x * 4 + 0;}

//得到png图片字符数组值（计算是否透明时用到该值）
unsigned char *getBitmapFromImage (UIImage *image)
{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    CGSize size = image.size;
    unsigned char *bitmapData = calloc(size.width * size.height * 4, 1); // Courtesy of Dirk. Thanks!
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Error: Memory not allocated!");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    CGContextRef context = CGBitmapContextCreate (bitmapData, size.width, size.height, 8, size.width * 4, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace );
    if (context == NULL)
    {
        fprintf (stderr, "Error: Context not created!");
        free (bitmapData);
        return NULL;
    }
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    CGContextDrawImage(context, rect, image.CGImage);
    unsigned char *data = CGBitmapContextGetData(context);
    CGContextRelease(context);
    
    return data;
}


@interface DragView()
{
    CGPoint previousLocation;
    unsigned char *bytes;
}
@end

@implementation DragView

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        self.gestureRecognizers = @[pan];
        bytes =  getBitmapFromImage(image);
    }
    return self;
}

//控制点击透明部份不影响事件（重写super的方法）
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (!CGRectContainsPoint(self.bounds, point)) return NO;
    return (bytes[alphaOffset(point.x, point.y, self.image.size.width)] > 85);
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

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 点击的图片马上移到最前面
    [self.superview bringSubviewToFront:self];
    
    //记住原始中心点，方便计算移动后的位置
    previousLocation = self.center;
}
@end
