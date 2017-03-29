//
//  BFLocalCityViewController.m
//  EasyBuy
//
//  Created by zt on 17/3/28.
//  Copyright © 2017年 晴天微笑. All rights reserved.
//

#import "ZTLocalCityViewController.h"
#import "NSString+PinYin.h"
#import "ZTIndexView.h"
#import "ZTCityResultTableView.h"
#import "ZTHotCityTableViewCell.h"
@interface ZTLocalCityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)ZTIndexView *indexView;
@property(nonatomic,strong)ZTCityResultTableView *resultTable;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UITextField *field;

@end
#define headViewH 40
#define stateH 20
#define indexViewW 25
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@implementation ZTLocalCityViewController
{
    NSArray *enumArray;
    NSMutableArray *firstLetterArray;
    NSMutableArray *allCityArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    
    [self initSearchUI];

    [self initTable];
    
    [self initIndexView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    allCityArray = [NSMutableArray arrayWithCapacity:0];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"plist"];
    NSArray *fileArray =  [NSDictionary dictionaryWithContentsOfFile:filePath][@"address"];
    
    [fileArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *citysArray = obj[@"sub"];
        [citysArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [allCityArray addObject:obj[@"name"]];
            
        }];
    }];
    
    enumArray = [NSArray array];
    enumArray = [allCityArray arrayWithPinYinFirstLetterFormat];
    firstLetterArray = [NSMutableArray arrayWithCapacity:0];
    [enumArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [firstLetterArray addObject:obj[@"firstLetter"]];
    }];
}

-(void)initSearchUI{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, stateH, 30, headViewH-10)];
    [backBtn setTitle:@"<" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [backBtn setTag:0];
    [backBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    _field = [[UITextField alloc]initWithFrame:CGRectMake(40, stateH, self.view.frame.size.width-110, headViewH-10)];
    [self.view addSubview:_field];
    _field.delegate = self;
    _field.layer.borderWidth = 1;
    _field.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _field.borderStyle = UITextBorderStyleRoundedRect;
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_field.frame)+10, stateH, 50, headViewH-10)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    [cancelBtn setTag:1];
    [cancelBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, stateH+headViewH-1, SCREEN_W, 1)];
    lab.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lab];
}

-(void)initTable{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, headViewH+stateH, self.view.frame.size.width-indexViewW, self.view.frame.size.height-headViewH-stateH) style:UITableViewStylePlain];
    _table.showsVerticalScrollIndicator = NO;
    [_table setSectionHeaderHeight:15];
    [_table setSectionFooterHeight:0];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }
    return ((NSArray *)enumArray[section-1][@"content"]).count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  firstLetterArray.count+1; //enumArray ? enumArray.count : 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 15)];
    lab.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:.8]; // RGB(240, 240, 240, .8);
    if (section==0) {
        lab.text=@"热门";
    }else{
        lab.text = firstLetterArray[section-1]; //enumArray[section][@"firstLetter"];
    }
    return lab;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        UITableViewCell *cell = [self tableView:_table cellForRowAtIndexPath:indexPath];
//               UITableViewCell *cell = [self tableView:table cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
//        return 100;
    }
    
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CELL";
    
    if (indexPath.section ==0) {
        ZTHotCityTableViewCell *cell = [[ZTHotCityTableViewCell alloc]initWithFrame:CGRectMake(0, 0, _table.frame.size.width, 1000)];
        __block typeof(self)blockSelf = self;
        cell.hotCityCallBack = ^(NSString *cityName){
            [blockSelf sendNotifityWithObj:cityName];
            
        };
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = ((NSArray *)enumArray[indexPath.section-1][@"content"])[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.callBack(enumArray[indexPath.section][indexPath.row]);
    NSString *str = enumArray[indexPath.section-1][@"content"][indexPath.row];
    [self sendNotifityWithObj:str];
    
}

//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//
//    return firstLetterArray;
//}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return firstLetterArray[section];
//}

//索引 右侧
-(void)initIndexView{
    _indexView = [[ZTIndexView alloc]initWithFrame:CGRectMake(SCREEN_W-25, self.view.frame.size.width-indexViewW, indexViewW, _table.frame.size.height-50) andArray:firstLetterArray];
    _indexView.indexViewBackColor = [UIColor lightGrayColor];
    [_indexView setTitlefont:14 andTitleColor:[UIColor greenColor] andTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:_indexView];
    
    __block typeof(self)blockSelf = self;
    _indexView.callBack = ^(NSInteger index){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index+1];
        [blockSelf.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    };
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *str;
    
    if (textField.text.length<1) {
        str = string;
    }else if([string isEqualToString:@""]){
        str = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
    }
    else{
        str = [textField.text stringByAppendingString:string];
    }
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF contains %@", str];
    NSArray *results = [allCityArray filteredArrayUsingPredicate:predicate1];
    NSLog(@"%@",results);
    if (results) {
        [self initResultTableView:results];

    }
    
    return YES;
}


#pragma mark ----取消、返回－－－－
-(void)headClick:(UIButton *)sender{
    if (sender.tag == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [_resultTable removeFromSuperview];
        _resultTable = nil;
    }
}

//搜索结果显示
-(void)initResultTableView:(NSArray *)array{
    if (!_resultTable) {
        _resultTable = [[ZTCityResultTableView alloc]initWithFrame:CGRectMake(0, headViewH+stateH, self.view.frame.size.width, self.view.frame.size.height-headViewH-stateH) style:UITableViewStylePlain];
        [self.view addSubview:_resultTable];
    }
    
    _resultTable.array = array;
    __block typeof(self)block = self;
    _resultTable.resultCallBack = ^(NSString *cityName){
       
        [block sendNotifityWithObj:cityName];
        
        [block.resultTable removeFromSuperview];
        block.resultTable = nil;
    };
    
}

-(void)sendNotifityWithObj:(NSString *)cityName{

    USERDEF_SET_OBJ(cityName, LOCAL_ADDRESS);
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFY_CURRENTLOCAL object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_CURRENTLOCAL object:nil];
}

@end
