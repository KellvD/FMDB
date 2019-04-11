//
//  ViewController.m
//  FMDBD
//
//  Created by changdong on 2019/4/11.
//  Copyright © 2019 baize. All rights reserved.
//

#import "ViewController.h"
#import "FMDBModel.h"
#import "FMDBManager.h"

#define MainScreen_Width self.view.frame.size.width
#define MainScreen_Height self.view.frame.size.height
@interface ViewController ()
<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStylePlain target:self action:@selector(addNewData)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self updateList];
}

-(void)addNewData{
    int ids = [[FMDBManager instance]queryMaxIds]+1;
    FMDBModel *model = [[FMDBModel alloc]init];
    model.ids = ids;
    model.name = [NSString stringWithFormat:@"cell——%d",ids];
    model.title = [NSString stringWithFormat:@"我是第%d条数据",ids];
    [[FMDBManager instance]addOneDataWith:model];
    [self updateList];
 
}

-(void)updateList{
    self.dataArr = [[FMDBManager instance]queryAllData];
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        
        UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 45, 45)];
        iconImage.tag=200;
        [cell.contentView addSubview:iconImage];

        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame)+10, 10, MainScreen_Width-45-10-60, 20)];
        nameLabel.textColor=[UIColor blackColor];
        nameLabel.tag=201;
        nameLabel.backgroundColor=[UIColor clearColor];
        nameLabel.font=[UIFont systemFontOfSize:17];
        [cell.contentView addSubview:nameLabel];

        UILabel *creatTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame)+10, CGRectGetMaxY(nameLabel.frame)+5, MainScreen_Width-130, 20)];
        creatTimeLabel.tag=202;
        creatTimeLabel.backgroundColor=[UIColor clearColor];
        creatTimeLabel.textColor=[UIColor colorWithRed:141/255.0 green:151/255.0 blue:167/255.0 alpha:1.0];
        creatTimeLabel.font=[UIFont systemFontOfSize:12];
        [cell.contentView addSubview:creatTimeLabel];

        UILabel*_timeLength =[[UILabel alloc]initWithFrame:CGRectMake(MainScreen_Width-60,  CGRectGetMaxY(nameLabel.frame)+5, 45, 20)];
        _timeLength.tag=203;
        _timeLength.backgroundColor=[UIColor clearColor];
        _timeLength.textColor=[UIColor colorWithRed:141/255.0 green:151/255.0 blue:167/255.0 alpha:1.0];
        _timeLength.font=[UIFont systemFontOfSize:12];
        [cell.contentView addSubview:_timeLength];
        _timeLength.textAlignment=NSTextAlignmentRight;

    }
    FMDBModel *model = [_dataArr objectAtIndex:indexPath.row];
    UIImageView *iconImage =(UIImageView *)[cell.contentView viewWithTag:200];
    UILabel *nameLabel=(UILabel *)[cell.contentView viewWithTag:201];
    UILabel *creatTimeLabel=(UILabel *)[cell.contentView viewWithTag:202];
    UILabel *lengthTime=(UILabel *)[cell.contentView viewWithTag:203];
    iconImage.backgroundColor = [UIColor grayColor];

    nameLabel.text = model.name;
    creatTimeLabel.text = model.title;

    lengthTime.text = [NSString stringWithFormat:@"%d",model.ids];

    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
