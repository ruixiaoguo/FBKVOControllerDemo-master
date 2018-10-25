//
//  ViewController.m
//  FBKVOControllerDemo
//
//  Created by 李林 on 2017/5/17.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "ViewController.h"
#import <KVOController/KVOController.h>
#import "Person.h"

@interface ViewController (){
    FBKVOController *_kvoCtrl;
}

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _person = [[Person alloc] init];
    _person.age = 22;
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    // FBKVOController监听
    _kvoCtrl = [FBKVOController controllerWithObserver:self];
    //=========1.@selector形式
    [_kvoCtrl observe:_person keyPath:@"age" options:0 action:@selector(changeColor)];
    //=========2.Block形式
//    [_kvoCtrl observe:_person keyPath:@"age" options:0 block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//        self.colorView.backgroundColor = [UIColor redColor];
//    }];
    
    // 系统的KVO监听
    [_person addObserver:self
              forKeyPath:@"age"
                 options:NSKeyValueObservingOptionNew
                 context:nil];
}

- (void)buttonClick {
    _person.age++;
}

// FBKVOController触发(无需移除)
- (void)changeColor {
    self.colorView.backgroundColor = [UIColor redColor];
}

// 系统的KVO监听触发
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}

// 系统的KVO监听移除
- (void)dealloc {
    [_person removeObserver:self forKeyPath:@"age"];
}


@end
