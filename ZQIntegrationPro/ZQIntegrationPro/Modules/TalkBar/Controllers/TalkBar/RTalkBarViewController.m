//
//  RTalkBarViewController.m
//  FinancialList
//
//  Created by hzq on 2019/3/6.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RTalkBarViewController.h"
#import "RTalkBarContentCell.h"
#import "RPublishTalkViewController.h"
#import "RTalkBarDetailViewController.h"
#import "ZQBaseNavigationController.h"

@interface RTalkBarViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation RTalkBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerCellNib:NSStringFromClass(RTalkBarContentCell.class)];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"r_add_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(addTalkDidClick)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark - UITableViewDelegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTalkBarContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RTalkBarContentCell.class)];
    if (indexPath.row % 2 == 0) {
        cell.pics = @[@"",@"",@"",@""];
    } else {
       cell.pics = @[@""];
    }
    @weakify(self);
    [cell setCommentClickBlock:^{
        @strongify(self);
        RTalkBarDetailViewController *vc = [RTalkBarDetailViewController controllerFromXIB];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}


#pragma mark - event response

- (void)addTalkDidClick {
    ZQBaseNavigationController *nvc = [[ZQBaseNavigationController alloc]initWithRootViewController:[RPublishTalkViewController controllerFromXIB]];
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma mark - getters & setters
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
