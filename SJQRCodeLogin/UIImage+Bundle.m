//
//  UIImage+Bundle.m
//  QRCodeTest
//
//  Created by UCSAPP on 2017/5/15.
//  Copyright © 2017年 UCSMY. All rights reserved.
//

#import "UIImage+Bundle.h"

@implementation UIImage (Bundle)

+ (UIImage *)loadFromQRCodeBundleWithName:(NSString *)name{
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"UCSQRCodeAssets" ofType:@"bundle"];
    NSString *imgPath = [bundlePath stringByAppendingPathComponent:name];
    UIImage *bundleImage = [UIImage imageWithContentsOfFile:imgPath];
    return bundleImage;
}

+ (UIImage*)createImageWithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
