//
//  UCSScanerView.m
//  QRCodeTest
//
//  Created by UCSAPP on 2017/5/15.
//  Copyright © 2017年 UCSMY. All rights reserved.
//

#import "UCSScanerView.h"

@interface UCSScanerView ()

@property (weak, nonatomic) IBOutlet UIImageView *leftUpper;
@property (weak, nonatomic) IBOutlet UIImageView *rightUpper;
@property (weak, nonatomic) IBOutlet UIImageView *leftBottom;
@property (weak, nonatomic) IBOutlet UIImageView *rightBottom;

@property (nonatomic, strong) UIView *loadXibView;

@end

@implementation UCSScanerView

- (void)dealloc{
    
    NSLog(@"****UCSScanerView Dealloced");
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
    
        CGFloat widthAndHeight = SCREEN_WIDTH - 2*UCSGQRCodeWindowLeading;
        _loadXibView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
        _loadXibView.frame = CGRectMake(0, 0, widthAndHeight, widthAndHeight);
        _leftUpper.image = [UIImage loadFromQRCodeBundleWithName:UCSGQRCodeWindowLeftUpImage];
        _leftBottom.image = [UIImage loadFromQRCodeBundleWithName:UCSGQRCodeWindowLeftBottomImage];
        _rightUpper.image = [UIImage loadFromQRCodeBundleWithName:UCSGQRCodeWindowRightUpImage];
        _rightBottom.image = [UIImage loadFromQRCodeBundleWithName:UCSGQRCodeWindowRightBottomImage];
        [self addSubview:_loadXibView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat widthAndHeight = SCREEN_WIDTH - 2*UCSGQRCodeWindowLeading;
    _loadXibView.frame = CGRectMake(0, 0, widthAndHeight, widthAndHeight);
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]objectAtIndex:0];
        view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:view];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
