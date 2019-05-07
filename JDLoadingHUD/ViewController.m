//
//  ViewController.m
//  JDLoadingHUD
//
//  Created by My Mac on 2019/5/7.
//  Copyright © 2019年 Jedediah. All rights reserved.
//

#import "ViewController.h"
#import "JDLoadingHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)didClickShowButton:(id)sender {
    
    [JDLoadingHUD showLoadingView];
}
- (IBAction)didClickHiddenButton:(id)sender {
    
    [JDLoadingHUD removeLoadingView];
}

@end
