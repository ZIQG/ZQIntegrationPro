//
//  RTalkBarDetailViewController.m
//  Rong518
//
//  Created by hzq on 2019/3/26.
//  Copyright © 2019 hzq. All rights reserved.
//

#import "RTalkBarDetailViewController.h"
#import "RTalkDetailContentCell.h"
#import "RTalkDetailCommentCell.h"
#import "RTalkCommentHeaderView.h"
#import "ZQInputView.h"

@interface RTalkBarDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBotConstraint;
@property (weak, nonatomic) IBOutlet ZQInputView *inputView;

@end

@implementation RTalkBarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"说呗正文";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerCellNib:RTalkDetailContentCell.cellIdentifier];
    [self.tableView registerCellNib:RTalkDetailCommentCell.cellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(RTalkCommentHeaderView.class) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass(RTalkCommentHeaderView.class)];
    
    // 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 设置文本框占位文字
    _inputView.placeholder = @"想说点什么...";
    _inputView.textContainerInset = UIEdgeInsetsMake(10, 10, 5, 10);
    // 监听文本框文字高度改变
    @weakify(self);
    _inputView.r_textHeightChangeBlock = ^(NSString *text,CGFloat textHeight){
        @strongify(self);
        self.bottomHConstraint.constant = textHeight + 24;
    };
    // 设置文本框最大行数
    _inputView.maxNumberOfLines = 4;
}


// 键盘弹出会调用
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 获取键盘frame
    CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取键盘弹出时长
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 修改底部视图距离底部的间距
    _bottomBotConstraint.constant = endFrame.origin.y != screenH ? endFrame.size.height - (kTabBarHeight - 49) : 0;
    
    // 约束动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDelegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RTalkDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:RTalkDetailContentCell.cellIdentifier];
        if (indexPath.row % 2 == 0) {
            cell.pics = @[@"",@"",@"",@""];
        } else {
            cell.pics = @[@"",@""];
        }
        return cell;
    } else {
        RTalkDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:RTalkDetailCommentCell.cellIdentifier];
        return cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        RTalkCommentHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(RTalkCommentHeaderView.class)];
        headerView.frame = CGRectMake(0, 0, kScreenWidth, 48);
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        return headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 48;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    }
    return 0.01;
}


#pragma mark - event response


- (IBAction)sendBtnDidClick:(id)sender {
}

#pragma mark - getters & setters
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
