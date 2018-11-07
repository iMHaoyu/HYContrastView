//
//  ViewController.m
//  HYContrastView
//
//  Created by 徐浩宇 on 2018/10/30.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "ViewController.h"
#import "UIView+HYCategory.h"
//#import "HYConfigurationView.h"
#import "HYContrastView.h"
#import "YYModel.h"
#import "HYCarModel.h"

#define KHYISIphoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size))

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray<HYCarModel *> *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat tempY = 0;
    if (KHYISIphoneX) {
        tempY = 34;
    }
    NSLog(@"begin");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getTempData];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"end");
            HYContrastView *temp = [[HYContrastView alloc]initWithFrame:self.view.bounds];
            temp.y_hy = tempY;
            temp.dataArray = [self.dataArr copy];
            [self.view addSubview: temp];
        });
    });
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)getTempData {
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"comparedata" ofType:@"json"]];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    self.dataArr = [[NSArray yy_modelArrayWithClass:[HYCarModel class] json:dict[@"data"]] mutableCopy];
    
    // 加一组空数据,用来显示最后面的“+”
    HYCarModel *model = [[HYCarModel alloc] init];
    [self.dataArr addObject:model];
}


@end
