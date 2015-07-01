//
//  ListViewController.m
//  Trouser-Models
//
//  Created by umut on 27/06/15.
//  Copyright (c) 2015 Umut Afacan. All rights reserved.
//

#import "ListViewController.h"
#import <Parse/Parse.h>
#import "CatalogueViewController.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *tableData;
}


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge ];
    activity.layer.cornerRadius = 5.0f;
    activity.backgroundColor = [UIColor grayColor];
    activity.frame = CGRectMake(130, 200, 120, 120);
    self.view.userInteractionEnabled=NO;
    [self.view addSubview:activity];
    [activity startAnimating];
    
    PFQuery *query = [PFQuery queryWithClassName:@"ListOfLists"];
    
    [query whereKeyExists:@"objectId"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error)
        {
            tableData = objects;
            
            [_tableViewMain reloadData];
            self.view.userInteractionEnabled=YES;
            [activity stopAnimating];
            [activity removeFromSuperview];
            
        }
        else
        {
            
        }
    }];
    
    _tableViewMain.delegate=self;
    _tableViewMain.dataSource=self;
    
    // Do any additional setup after loading the view.
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogueViewController *catalogueVC = [[CatalogueViewController alloc]init];
    PFObject *obj=[tableData objectAtIndex:indexPath.row];
    NSString *str= [obj objectForKey:@"listName"];
    catalogueVC.listName=str;
    
    [self.navigationController pushViewController:catalogueVC animated:NO];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"tableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    PFObject *obj =[tableData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [obj objectForKey:@"ListName"];
    return cell;
    
}

@end

