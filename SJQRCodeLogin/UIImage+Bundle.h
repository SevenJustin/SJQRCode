//
//  UIImage+Bundle.h
//  QRCodeTest
//
//  Created by UCSAPP on 2017/5/15.
//  Copyright © 2017年 UCSMY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Bundle)

+ (UIImage *)loadFromQRCodeBundleWithName:(NSString *)name;

+ (UIImage*)createImageWithColor:(UIColor *)color;

@end
