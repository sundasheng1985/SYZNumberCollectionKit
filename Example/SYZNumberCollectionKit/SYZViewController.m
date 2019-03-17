//
//  SYZViewController.m
//  SYZNumberCollectionKit
//
//  Created by sundasheng1985 on 03/17/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import "SYZViewController.h"
#import <SYZNumberCollectionKit/SYZNumberCollectionKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface SYZViewController ()
<
SYZNumberCollectionerDelegate,
SYZNumberCollectorSaverDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UILabel *rootLabel;
@property (nonatomic, strong) UILabel *rootMusicLabel;
@property (nonatomic, strong) UILabel *rootVideoLabel;
@property (nonatomic, strong) UILabel *rootVideListLabel;
@property (nonatomic, strong) UILabel *rootVideoDetailLabel;

@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSArray *labels;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *list;

@end

@implementation SYZViewController

- (void)_parameterAsset {
    NSArray* leafNames = [[SYZNumberCollector sharedInstance] leafNamesForType:@"/root/messagebox/message"];
    NSParameterAssert([leafNames.firstObject isEqualToString:@"root"]);
    NSParameterAssert([leafNames[1] isEqualToString:@"messagebox"]);
    NSParameterAssert([leafNames.lastObject isEqualToString:@"message"]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.list = @[@"插入信息",@"打印数据",@"保存数据",@"恢复数据",@"放弃数据",@"使用数据",@"放弃/root/video数据",@"添加数据",@"更新数据",@"更新数据"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.rootLabel];
    [self.view addSubview:self.rootMusicLabel];
    [self.view addSubview:self.rootVideListLabel];
    [self.view addSubview:self.rootMusicLabel];
    [self.view addSubview:self.rootVideoDetailLabel];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    [self _parameterAsset];
    self.types = @[NUMBER_COL_ROOT_LEAF_NAME,
                   @"/root/music",
                   @"/root/video",
                   @"/root/video/list",
                   @"/root/video/detail"];
    self.labels = @[self.rootLabel,
                    self.rootMusicLabel,
                    self.rootVideoLabel,
                    self.rootVideListLabel,
                    self.rootVideoDetailLabel];
    SYZNumberCollectorTypeBuilder* builder = [SYZNumberCollectorTypeBuilder new];
    [[builder addChildPath:@"video"] addChildPath:@"detail"];
    NSLog(@"%@",builder.build);
    
    NSString* root = NUMBER_COL_ROOT_LEAF_NAME;
    NSString* rootVideo = [NUMBER_COL_ROOT_LEAF_NAME stringByAppendingString:@"/video"];
    NSString* rootVideoDetail = [rootVideo stringByAppendingString:@"/detail"];
    NSString* rootVideoList = [rootVideo stringByAppendingString:@"/list"];
    NSString* rootMusic = [root stringByAppendingString:@"/music"];
    
    [[SYZNumberCollector sharedInstance] updateDataSaver:[SYZCollectionNumberDefaultSaver new]];
    [[SYZNumberCollector sharedInstance] addObserver:self forType:root];
    [[SYZNumberCollector sharedInstance] addObserver:self forType:rootVideoDetail];
    [[SYZNumberCollector sharedInstance] addObserver:self forType:rootVideo];
    [[SYZNumberCollector sharedInstance] addObserver:self forType:rootVideoList];
    [[SYZNumberCollector sharedInstance] addObserver:self forType:rootMusic];

}

- (void)_printNewLine {
    NSLog(@"<--------------------------->");
}

- (void)_printLog:(NSString*)name num:(NSString*)num {
    NSLog(@"更新%@为%@",name,num);
}

/** 根据type对响应的UI进行数量更新，进行通知*/
- (void)numberCollectorType:(NSString *)type name:(NSString *)name didUpdateToNum:(long)num {
    NSUInteger index = [self.types indexOfObject:type];
    UILabel* label = [self.labels objectAtIndex:index];
    label.text = @(num).stringValue;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.list[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self insertDatas];
            break;
        case 1:
            [self printDatas];
            break;
        case 2:
            [self saveDatas];
            break;
        case 3:
            [self resumeDatas];
            break;
        case 4:
            [self dropDatas];
            break;
        case 5:
            [self consumeData];
            break;
        case 6:
            [self dropVideoData];
            break;
        case 7:
            [self addNumber];
            break;
        case 8:
            [self transactionUpdate];
            break;
        case 9:
            [self transactionAdd];
            break;
            
        default:
            break;
    }
}

/** 插入信息 */
- (void)insertDatas{
    NSString* root = NUMBER_COL_ROOT_LEAF_NAME;
    NSString* rootVideo = [NUMBER_COL_ROOT_LEAF_NAME stringByAppendingString:@"/video"];
    NSString* rootVideoDetail = [rootVideo stringByAppendingString:@"/detail"];
    NSString* rootVideoList = [rootVideo stringByAppendingString:@"/list"];
    NSString* rootMusic = [root stringByAppendingString:@"/music"];
    
    [self _printLog:@"root" num:@"5"];
    [[SYZNumberCollector sharedInstance] updateNumber:5 forType:root];
    [self _printNewLine];
    
    [self _printLog:@"rootVideo" num:@"6"];
    [[SYZNumberCollector sharedInstance] updateNumber:6 forType:rootVideo];
    [self _printNewLine];
    
    [self _printLog:@"rootVideoDetail" num:@"10"];
    [[SYZNumberCollector sharedInstance] updateNumber:10 forType:rootVideoDetail];
    [self _printNewLine];
    
    [self _printLog:@"rootVideoDetail" num:@"20"];
    [[SYZNumberCollector sharedInstance] updateNumber:20 forType:rootVideoDetail];
    [self _printNewLine];
    
    [self _printLog:@"rootVideoList" num:@"30"];
    [[SYZNumberCollector sharedInstance] updateNumber:30 forType:rootVideoList];
    
    [self _printNewLine];
    
    [self _printLog:@"rootVideoList" num:@"3"];
    [[SYZNumberCollector sharedInstance] updateNumber:3 forType:rootMusic];
}

/** 打印数据 */
- (void)printDatas{
    [self _printNewLine];
    NSString* root = NUMBER_COL_ROOT_LEAF_NAME;
    NSString* rootVideo = [NUMBER_COL_ROOT_LEAF_NAME stringByAppendingString:@"/video"];
    NSString* rootVideoDetail = [rootVideo stringByAppendingString:@"/detail"];
    NSString* rootVideoList = [rootVideo stringByAppendingString:@"/list"];
    NSString* rootMusic = [root stringByAppendingString:@"/music"];
    for (NSString* type in @[root,rootVideo,rootVideoList,rootVideoDetail,rootMusic]) {
        NSLog(@" %@ ---- %ld",type,[[SYZNumberCollector sharedInstance] fetchNumberForType:type]);
    }
}

/** 保存 */
- (void)saveDatas{
    NSLog(@"----------- 保存数据");
    [[SYZNumberCollector sharedInstance] saveForKey:@"123"];
}

/** 恢复 */
- (void)resumeDatas{
    NSLog(@"----------- 恢复数据");
    [[SYZNumberCollector sharedInstance] resumeForKey:@"123"];
}

/** 放弃 */
- (void)dropDatas{
    NSLog(@"----------- 放弃数据数据");
    [[SYZNumberCollector sharedInstance] drop];
}

/** 消费 */
- (void)consumeData{
    [[SYZNumberCollector sharedInstance] consumeNumber:6 forType:@"/root/video/detail"];
}

/** 放弃 */
- (void)dropVideoData{
    [[SYZNumberCollector sharedInstance] dropType:@"/root/video/"];
}

/** 添加 */
- (void)addNumber{
     [[SYZNumberCollector sharedInstance] addNumber:70 forType:@"/root/video/detail"];
}

/** 事物更新 */
- (void)transactionUpdate{
    SYZNumberCollectionTransaction* transaction = [[SYZNumberCollector sharedInstance] beginTransactionForType:@"/root/video"];
    [transaction updateNumber:4 forType:@"/root/video/list"];
    [transaction updateNumber:4 forType:@"/root/video/detail"];
    [transaction commit];
}

/** 事物更新 */
- (void)transactionAdd {
    SYZNumberCollectionTransaction* transaction = [[SYZNumberCollector sharedInstance] beginTransactionForType:@"/root/video"];
    [transaction addNumber:10 forType:@"/root/video/list"];
    [transaction addNumber:10 forType:@"/root/video/detail"];
    [transaction commit];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

- (UILabel *)rootLabel{
    if (!_rootLabel) {
        _rootLabel = [self createLabelWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame) - 200, 70, 30) title:@"0"];
    }
    return _rootLabel;
}

- (UILabel *)rootMusicLabel{
    if (!_rootMusicLabel) {
        _rootMusicLabel = [self createLabelWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 150, CGRectGetHeight(self.view.frame) - 200 + 50, 70, 30) title:@"0"];
    }
    return _rootMusicLabel;
}

- (UILabel *)rootVideListLabel{
    if (!_rootVideListLabel) {
        _rootVideListLabel = [self createLabelWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 + 100, CGRectGetHeight(self.view.frame) - 200 + 50, 70, 30) title:@"0"];
    }
    return _rootVideListLabel;
}

- (UILabel *)rootVideoLabel{
    if (!_rootVideoLabel) {
        _rootVideoLabel = [self createLabelWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 , CGRectGetHeight(self.view.frame) - 200 + 100, 70, 30) title:@"0"];
    }
    return _rootVideoLabel;
}

- (UILabel *)rootVideoDetailLabel{
    if (!_rootVideoDetailLabel) {
        _rootVideoDetailLabel = [self createLabelWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 + 150, CGRectGetHeight(self.view.frame) - 200 + 100, 70, 30) title:@"0"];
    }
    return _rootVideoDetailLabel;
}

- (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

@end
