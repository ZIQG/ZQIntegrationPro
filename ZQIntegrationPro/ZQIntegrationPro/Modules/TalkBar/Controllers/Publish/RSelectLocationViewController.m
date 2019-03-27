//
//  RSelectLocationViewController.m
//  Rong518
//
//  Created by hzq on 2019/3/21.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RSelectLocationViewController.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "RLocationSearchResultViewController.h"
#import "RLocationEntity.h"
#import "RLocationCell.h"

@interface RSelectLocationViewController ()<BMKLocationManagerDelegate, BMKGeoCodeSearchDelegate, UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//searchController
@property (strong, nonatomic) UISearchController *searchController;

@property (nonatomic, strong) RLocationSearchResultViewController *resultVC;

//数据源
@property (strong,nonatomic) NSMutableArray<RLocationEntity *>  *dataList;

@property (nonatomic, strong) BMKLocationManager *locationManager;

@property (nonatomic ,strong)BMKGeoCodeSearch *geoSearcher;

@property (nonatomic, assign) CLLocationCoordinate2D centerCoordinate;

@property (nonatomic, copy) NSString *currentCity;

@property (nonatomic, assign) NSInteger selectRow;


@end

@implementation RSelectLocationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"所在位置";
    
    self.selectRow = 0;
    _dataList = [NSMutableArray array];
    [self setupCustomData];
    
    [self setupLocation];
    
    [self setupUI];
    
    [self.locationManager startUpdatingLocation];
    
}

- (void)setupUI {
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [searchBtn setTitle:@"完成" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    searchBtn.layer.cornerRadius = 5;
    searchBtn.clipsToBounds = YES;
    searchBtn.backgroundColor = [UIColor colorWithHexString:@"#FF5722"];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    [searchBtn addTarget:self action:@selector(confirmDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerCellNib:RLocationCell.cellIdentifier];
    
    RLocationSearchResultViewController *resultVC = [[RLocationSearchResultViewController alloc]init];
    @weakify(self);
    [resultVC setItemSeletectedBlock:^(NSString * _Nonnull result) {
        @strongify(self);
        if (self.selectConfirmBlock) {
            self.selectConfirmBlock(result);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.resultVC = resultVC;
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultVC];
    [searchController.searchBar sizeToFit];
    searchController.searchBar.placeholder=@"搜索附近位置";
    searchController.searchBar.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [[[searchController.searchBar.subviews.firstObject subviews] firstObject] removeFromSuperview];
    UITextField*searchField = [searchController.searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor colorWithHexString:@"#757575"] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    searchField.backgroundColor = [UIColor whiteColor];
    [searchController.searchBar sizeToFit];
    searchController.dimsBackgroundDuringPresentation= NO;
    if (@available(iOS 9.1, *)) {
        searchController.obscuresBackgroundDuringPresentation= NO;
    } else {
        // Fallback on earlier versions
    }
    self.definesPresentationContext = YES;
    self.resultVC.searchController = searchController;
    _tableView.tableHeaderView = searchController.searchBar;
    self.searchController = searchController;
}

- (void)setupLocation {
    ///初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = YES;
    //设置是否允许后台定位
    _locationManager.allowsBackgroundLocationUpdates = NO;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 10;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 10;
    
    //初始化GEO检索服务
    self.geoSearcher = [[BMKGeoCodeSearch alloc]init];
    self.geoSearcher.delegate = self;
}

//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [self.dataList count];
}


//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RLocationCell *cell=[tableView dequeueReusableCellWithIdentifier:RLocationCell.cellIdentifier];
    RLocationEntity *entity = self.dataList[indexPath.row];
    cell.entity = entity;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectRow = indexPath.row;
}

#pragma mark - about location

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error {
    if (error) {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    }
    if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
            self.centerCoordinate = location.location.coordinate;
            [self startGeoSearchWithLocation:self.centerCoordinate];;
        }
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
            self.resultVC.city = location.rgcData.city;
        }
    }
}

//反地理编码查找周边 根据坐标查询 详细地址
- (void)startGeoSearchWithLocation:(CLLocationCoordinate2D)centerCoordinate {
    //反地理编码 根据坐标找地址
    BMKReverseGeoCodeSearchOption *geoCodeOption = [[BMKReverseGeoCodeSearchOption alloc]init];
    geoCodeOption.location = centerCoordinate;
    BOOL flag = [self.geoSearcher reverseGeoCode:geoCodeOption];
    if(flag){
        NSLog(@"geo检索发送成功");
    }else{
        NSLog(@"geo检索发送失败");
    }
}

#pragma mark --BMKGeoCodeSearchDelegate 反地理编码回调代理
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        [self.locationManager stopUpdatingLocation];
        [self.dataList removeAllObjects];
        [self setupCustomData];
        for (BMKPoiInfo * info in result.poiList) {
            RLocationEntity *entity = [[RLocationEntity alloc]init];
            entity.name = info.name;
            entity.address = info.address;
            [self.dataList addObject:entity];
        }
        [self.tableView reloadData];
        self.selectRow = 0;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    }
    else{
        NSLog(@"geo检索结果有误");
    }
}

- (void)setupCustomData {
    RLocationEntity *entity = [[RLocationEntity alloc]init];
    entity.name = @"不显示位置";
    [_dataList addObject:entity];
    
    if (self.resultVC.city.length > 0) {
        RLocationEntity *entity = [[RLocationEntity alloc]init];
        entity.name = self.resultVC.city;
        [_dataList addObject:entity];
    }
}


#pragma mark - event response

- (void)confirmDidClick {
    if (self.selectConfirmBlock) {
        self.selectConfirmBlock(self.dataList[self.selectRow].name);
    }
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    self.locationManager.delegate = nil;
    self.geoSearcher.delegate = nil;
    self.searchController = nil;
}

@end
