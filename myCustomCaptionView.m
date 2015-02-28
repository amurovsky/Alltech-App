//
//  myCustomCaptionView.m
//  Alltech
//
//  Created by Tejuino developers on 16/02/15.
//  Copyright (c) 2015 Tejuino developers. All rights reserved.
//

#import "myCustomCaptionView.h"

static const CGFloat labelPadding = 10;

@implementation myCustomCaptionView{

    id <MWPhoto> _photo;
    UILabel *_label;

}


- (id)initWithPhoto:(id<MWPhoto>)photo{

    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]; // Random initial frame
    if (self) {
        self.userInteractionEnabled = NO;
        _photo = photo;
            // Use iOS 7 blurry goodness
            self.barStyle = UIBarStyleBlackTranslucent;
            self.tintColor = nil;
            self.barTintColor = nil;
            self.barStyle = UIBarStyleBlackTranslucent;
            [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
            self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self setupCaption];
    }
    return self;


}

- (void)setupCaption{



}
- (CGSize)sizeThatFits:(CGSize)size{

    CGFloat maxHeight = 9999;
    if (_label.numberOfLines > 0) maxHeight = _label.font.leading*_label.numberOfLines;
    CGSize textSize;
    if ([NSString instancesRespondToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        textSize = [_label.text boundingRectWithSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:_label.font}
                                             context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        textSize = [_label.text sizeWithFont:_label.font
                           constrainedToSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                               lineBreakMode:_label.lineBreakMode];
#pragma clang diagnostic pop
    }
    return CGSizeMake(size.width, textSize.height + labelPadding * 2);



}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
