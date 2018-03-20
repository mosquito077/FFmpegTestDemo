//
//  LocalViewController.m
//  FFmpegTestDemo
//
//  Created by mosquito on 2018/2/11.
//  Copyright © 2018年 mosquito. All rights reserved.
//

#import "LocalViewController.h"
#include "avformat.h"
#include "avcodec.h"
#import "KxMovieViewController.h"

@interface LocalViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *localTableView;
@property (nonatomic, strong) NSArray *localArray;

@end

@implementation LocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.localArray = @[@"5156.wmv", @"Ad.avi", @"brutal.rmvb",
                        @"brutal2.ogg", @"IMG.mp4", @"spot1.asf",
                        ];
    
    self.localTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                       style:UITableViewStylePlain];
    self.localTableView.backgroundColor = [UIColor whiteColor];
    self.localTableView.delegate = self;
    self.localTableView.dataSource = self;
    self.localTableView.tableFooterView = [UIView alloc];
    self.localTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:self.localTableView];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.localArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.localArray[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row >= self.localArray.count) {
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *path = [[NSBundle mainBundle] pathForResource:self.localArray[indexPath.row] ofType:nil];
    
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
