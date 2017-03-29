//
//  ViewController.m
//  Ctiy
//
//  Created by zt on 17/3/29.
//  Copyright © 2017年 zt. All rights reserved.
//

#import "ViewController.h"
#import "ZTLocalCityViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cityNameLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify) name:NOTIFY_CURRENTLOCAL object:nil];
}

-(void)notify{
    _cityNameLab.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOCAL_ADDRESS];
}

- (IBAction)btn:(id)sender {
    ZTLocalCityViewController *local = [[ZTLocalCityViewController alloc]init];
    local.callBack = ^(NSString *cityName){
        
    };
    [self presentViewController:local animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
