//
//  ListViewController.h
//  Trouser-Models
//
//  Created by umut on 27/06/15.
//  Copyright (c) 2015 Umut Afacan. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;



@interface ListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableViewMain;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;

@end
