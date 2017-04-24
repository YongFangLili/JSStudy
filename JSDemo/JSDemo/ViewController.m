//
//  ViewController.m
//  JSDemo
//
//  Created by liyongfang on 2017/4/24.
//  Copyright © 2017年 liyongfang. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


/**
 
 JSContext:JS运行的上下文环境
 JSValue:JS和OC数据和方法交互的桥梁
 JSExport:添加了JSExport协议的协议，所规定的方法，变量等 就会对js开放
 
 
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self basicUse];
    
    //    [self methodSwithch];
    //    [self jsWithParam];
    
    [self exceptionHandl];
    // Do any additional setup after loading the view, typically from a nib.
}



/// 类型转化的基本使用
- (void)basicUse {
    
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:@"var arr = [21, 7 , 'iderzheng.com'];"];
    JSValue *jsArr = context[@"arr"];
    NSArray *ocArray = [jsArr toArray];
    NSLog(@"JS Array: %@;    Length: %@", jsArr, jsArr[@"length"]);
    NSLog(@"JSLength : %@",ocArray);
}



/// 方法转换
- (void)methodSwithch {
    
    JSContext *context = [[JSContext alloc] init];
    context[@"log"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        NSLog(@"-------End Log-------");
    };
    
    // 执行方法block
    [context evaluateScript:@"log('ider', [7, 21], { hello:'world', js:100 });"];
    
}

/// 传入参数
-(void)jsWithParam {
    
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:@"function add(a, b) { return a + b; }"];
    JSValue *add = context[@"add"];
    NSLog(@"Func:  %@", add);
    // 传入任意参数进去执行方法
    JSValue *sum = [add callWithArguments:@[@(7), @(21)]];
    NSLog(@"Sum:  %d",[sum toInt32]);
}


/// 异常处理
- (void)exceptionHandl{
    
    JSContext *context = [[JSContext alloc] init];
    context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"%@", exception);
        
    };
    
    [context evaluateScript:@"ider.zheng = 21"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
