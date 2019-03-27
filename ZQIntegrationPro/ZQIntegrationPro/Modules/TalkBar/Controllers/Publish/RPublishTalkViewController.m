//
//  RPublishTalkViewController.m
//  Rong518
//
//  Created by hzq on 2019/3/20.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RPublishTalkViewController.h"
#import "RTalkPublishInputCell.h"
#import "RTalkPublishPicsCell.h"
#import "RTalkPublishLimitCell.h"
#import "ZQImagePickerController.h"
#import "RSelectLocationViewController.h"

@interface RPublishTalkViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, assign) BOOL allowComment;

@end

@implementation RPublishTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setupTableView];
    
    [self setupNavigationBar];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerCellNib:RTalkPublishInputCell.cellIdentifier];
    [self.tableView registerCellNib:RTalkPublishPicsCell.cellIdentifier];
    
    self.tableView.tableFooterView = [[UITableView alloc]init];

}

- (void)setupNavigationBar {
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelDidClick)];
    leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"#212121"];
    [leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:16],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateSelected];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [searchBtn setTitle:@"发表" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    searchBtn.layer.cornerRadius = 5;
    searchBtn.clipsToBounds = YES;
    searchBtn.backgroundColor = [UIColor colorWithHexString:@"#FF5722"];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    [searchBtn addTarget:self action:@selector(publishDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark - UITableViewDelegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RTalkPublishInputCell *cell = [tableView dequeueReusableCellWithIdentifier:RTalkPublishInputCell.cellIdentifier];
        return cell;
    } else if (indexPath.section == 1) {
        RTalkPublishPicsCell *cell = [tableView dequeueReusableCellWithIdentifier:RTalkPublishPicsCell.cellIdentifier];
        cell.images = self.images;
        @weakify(self);
        [cell setSelectImageBlock:^{
            @strongify(self);
            [self selectImage];
        }];
        return cell;
    } else {
        if (indexPath.row == 0) {
            RTalkPublishSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:RTalkPublishSwitchCell.cellIdentifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"RTalkPublishLimitCell" owner:nil options:nil] firstObject];
                @weakify(self);
                [cell setSwitchValueChangeBlock:^(BOOL on) {
                    @strongify(self);
                    self.allowComment = on;
                }];
            }
            return cell;
        } else {
            RTalkPublishLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:RTalkPublishLocationCell.cellIdentifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"RTalkPublishLimitCell" owner:nil options:nil] lastObject];
            }
            cell.titleLabel.text = self.location ? : @"所在位置";
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 1) {
        //选择位置
        RSelectLocationViewController *vc = [RSelectLocationViewController controllerFromXIB];
        [self.navigationController pushViewController:vc animated:YES];
        [vc setSelectConfirmBlock:^(NSString * _Nonnull location) {
            if (![location isEqualToString:@"不显示位置"]) {
                self.location = location;
            } else {
                self.location = nil;
            }
            [self.tableView reloadData];
        }];
    }
}

#pragma mark - event response

- (void)selectImage {
    @weakify(self);
    [ZQImagePickerController showWithMaxImagesCount:9 - self.images.count controller:self finishPickingPhotosHandle:^(NSArray<UIImage *> * _Nonnull photos, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
        @strongify(self);
        [self.images addObjectsFromArray:photos];
        [self.tableView reloadData];
    }];
}

- (void)cancelDidClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishDidClick {
    
}

#pragma mark - getters & setters

- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

@end
