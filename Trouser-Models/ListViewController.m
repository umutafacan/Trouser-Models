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
    NSMutableArray *tableData;
}


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.bannerView.adUnitID = @"ca-app-pub-1799297564432270/5226414140";
    self.bannerView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[
                            @"9E14CECB-4E78-40F5-8710-103C2F8ADCF7"
                            ];
    
    
    
    
    [self.bannerView loadRequest:request];

    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge ];
    activity.layer.cornerRadius = 5.0f;
    activity.backgroundColor = [UIColor grayColor];
    activity.frame = CGRectMake(130, 200, 120, 120);
    self.view.userInteractionEnabled=NO;
    [self.view addSubview:activity];
    [activity startAnimating];
    tableData = [[NSMutableArray alloc]initWithObjects: nil];

    PFQuery *query = [PFQuery queryWithClassName:@"ListOfLists"];
    
    [query whereKeyExists:@"objectId"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error)
        {
            [tableData addObjectsFromArray:objects];
            
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
    CatalogueViewController *catalogueVC = [self.storyboard instantiateViewControllerWithIdentifier:@"catalogVC"];
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

