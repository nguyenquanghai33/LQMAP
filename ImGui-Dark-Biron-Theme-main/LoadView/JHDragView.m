
#import "JHDragView.h"

@implementation JHDragView

- (instancetype)initWithFrame:(CGRect)frame
{
  frame = CGRectMake(0.0, 0.0, 25, 25); // Set origin to (0, 0) for top left corner
  self = [super initWithFrame:frame];
  if (self) {
    //self.layer.borderColor = [UIColor colorWithRed: 0.50 green: 0.72 blue: 0.05 alpha: 0.50];
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        //self.layer.borderWidth = 0.95f;
       self.backgroundColor=  [UIColor colorWithRed: 0.00 green: 0.00 blue: 0.00 alpha: 0.20];
        
        self.transform = CGAffineTransformMakeScale(1.3,1.3);
        //self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
        self.alpha = 50.0f;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@""]];
            UIImage *decodedImage = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.layer.contents = (id)decodedImage.CGImage;
            });
        });
  }
  return self;
}

#pragma mark - override

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

// Comment out the following method to prevent dragging
// - (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

#pragma mark - private

- (void)shouldResetFrame
{
    CGFloat midX = CGRectGetWidth(self.superview.frame)*0.5;
    CGFloat midY = CGRectGetHeight(self.superview.frame)*0.5;
    CGFloat maxX = midX*2;
    CGFloat maxY = midY*2;
    CGRect frame = self.frame;

    if (CGRectGetMinX(frame) < 0 ||
        CGRectGetMidX(frame) <= midX) {
        frame.origin.x = 0;
    }else if (CGRectGetMidX(frame) > midX ||
              CGRectGetMaxX(frame) > maxX) {
        frame.origin.x = maxX - CGRectGetWidth(frame);
    }

    if (CGRectGetMinY(frame) < 0) {
        frame.origin.y = 0;
    }else if (CGRectGetMaxY(frame) > maxY) {
        frame.origin.y = maxY - CGRectGetHeight(frame);
    }

    [UIView animateWithDuration:0.25 animations:^{
        //CGFloat width = MAX([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
        //self.frame = CGRectMake(width-70, 100, 65, 65);
        //self.frame = frame;
    }];
}


@end
