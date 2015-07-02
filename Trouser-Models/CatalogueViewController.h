//
//  CatalogueViewController.h
//  Trouser-Models
//
//  Created by umut on 28/06/15.
//  Copyright (c) 2015 Umut Afacan. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface CatalogueViewController : UIViewController
@property (nonatomic,strong) NSString *listName;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTest;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;


@end
