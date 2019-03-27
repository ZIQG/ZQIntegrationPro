//
//  RLocationSearchResultViewController.m
//  Rong518
//
//  Created by hzq on 2019/3/22.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RLocationSearchResultViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "RLocationEntity.h"
#import "RLocationCell.h"

@interface RLocationSearchResultViewController ()<UITableViewDelegate, UITableViewDataSource, BMKSuggestionSearchDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<RLocationEntity *> *searchArr;

@property (nonatomic ,strong)BMKSuggestionSearch *sugSearcher;

@end

#define kResultCellIdentifier @"kResultCellIdentifier"

@implementation RLocationSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _searchArr = [NSMutableArray array];
    self.sugSearcher = [[BMKSuggestionSearch alloc]init];
    self.sugSearcher.delegate = self;
    self.searchController.searchResultsUpdater = self;
    
    [self configUI];
}

- (void)dealloc {
    self.sugSearcher.delegate = nil;
}

- (void)configUI {
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [_tableView registerCellNib:RLocationCell.cellIdentifier];
    _tableView.tableFooterView = [[UIView alloc]init];
    
    if(@available(iOS 11.0,*)){
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;//不加的话，table会下移
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;//不加的话，UISearchBar返回后会上移
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kResultCellIdentifier];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RLocationCell *cell=[tableView dequeueReusableCellWithIdentifier:RLocationCell.cellIdentifier];
    RLocationEntity *entity = self.searchArr[indexPath.row];
    cell.entity = entity;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.itemSeletectedBlock) {
        self.itemSeletectedBlock(self.searchArr[indexPath.row].name);
    }
    [self.searchController.searchBar endEditing:YES];
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (searchController.searchBar.text.length ==0) {
        [self.searchArr removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    searchController.searchResultsController.view.hidden = NO;
    [self startSugSearchWihtCity:self.city keyword:searchController.searchBar.text];
    
}

- (void)startSugSearchWihtCity:(NSString*)city keyword:(NSString *)keyword {
    
    //初始化检索对象
    BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
    option.cityname = city ? : @"北京";
    option.keyword  = keyword;
    BOOL flag = [self.sugSearcher suggestionSearch:option];
    if(flag) {
        NSLog(@"Sug检索发送成功");
    }
    else {
        NSLog(@"Sug检索发送失败");
    }
}


#pragma mark --BMKSuggestionSearchDelegate 地点输入提示检索（Sug检索)
- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        [self.searchArr removeAllObjects];
        for (BMKSuggestionInfo * info in result.suggestionList) {
            RLocationEntity *entity = [[RLocationEntity alloc]init];
            entity.name = info.key;
            entity.address = [NSString stringWithFormat:@"%@:%@",info.city,info.district];
            [self.searchArr addObject:entity];
        }
        [self.tableView reloadData];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}


@end
