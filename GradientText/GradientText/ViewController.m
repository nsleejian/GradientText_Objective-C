//
//  ViewController.m
//  GradientText
//
//  Created by Cocoa Lee on 15/7/6.
//  Copyright (c) 2015年 Cocoa Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>
@property(nonatomic,strong) UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _textView = [UITextView new];
    _textView.frame = self.view.bounds;
    _textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_textView];
    _textView.textAlignment = NSTextAlignmentCenter;
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
   layer.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor];
    layer.locations= @[[NSNumber numberWithFloat:0.3],[NSNumber numberWithFloat:0.6],[NSNumber numberWithFloat:0.9]];
        layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    layer.frame = _textView.bounds;
    [self.view.layer addSublayer:layer];
    layer.mask = _textView.layer;
     _textView.font = [UIFont systemFontOfSize:20];
    [_textView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
    
    
    UITextView *textViewTop = [UITextView new];
    textViewTop.frame = _textView.bounds;
    [self.view addSubview:textViewTop];
    textViewTop.backgroundColor = [UIColor clearColor];
    textViewTop.textAlignment = NSTextAlignmentCenter;
    textViewTop.textColor = [UIColor clearColor];
    textViewTop.font = _textView.font;
    textViewTop.delegate = self;
    [textViewTop addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];

    
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    _textView.text = textView.text;

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UITextView *txtview = object;
    CGFloat topoffset = ([txtview bounds].size.height - [txtview contentSize].height * [txtview zoomScale])/2.0;
    topoffset = ( topoffset < 0.0 ? 0.0 : topoffset );
    txtview.contentOffset = (CGPoint){.x = 0, .y = -topoffset};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
