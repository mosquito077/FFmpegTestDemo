//
//  RemoteViewController.m
//  FFmpegTestDemo
//
//  Created by mosquito on 2018/2/11.
//  Copyright © 2018年 mosquito. All rights reserved.
//

#import "RemoteViewController.h"
#include "avformat.h"
#include "avcodec.h"
#import "KxMovieViewController.h"

@interface RemoteViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *remoteTableView;
@property (nonatomic, strong) NSArray *remoteArray;

@end

@implementation RemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.remoteArray = @[@"http://imgboys1.yohobuy.com/cmsimg01/2018/01/18/00/05/013bdfbfd4ab31502838cd28980d05a2d5.mp4",
                         @"http://imgboys1.yohobuy.com/cmsimg01/2017/12/21/10/26/01f793376481e64edad03d9c5d0566eefe.mp4"];
    
    self.remoteTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                       style:UITableViewStylePlain];
    self.remoteTableView.backgroundColor = [UIColor whiteColor];
    self.remoteTableView.delegate = self;
    self.remoteTableView.dataSource = self;
    self.remoteTableView.tableFooterView = [UIView alloc];
    self.remoteTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:self.remoteTableView];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.remoteArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.remoteArray[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row >= self.remoteArray.count) {
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *path = self.remoteArray[indexPath.row];
    
    if ([path.pathExtension isEqualToString:@"wmv"]) {
        parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                               parameters:parameters];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
