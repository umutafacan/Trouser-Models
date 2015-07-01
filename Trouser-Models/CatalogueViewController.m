//
//  CatalogueViewController.m
//  Trouser-Models
//
//  Created by umut on 28/06/15.
//  Copyright (c) 2015 Umut Afacan. All rights reserved.
//

#import "CatalogueViewController.h"
#import <Parse/Parse.h>
#import "AFImageViewer.h"

#define h_navBar self.navigationController.navigationBar.bounds.size.height


@interface CatalogueViewController ()<UIScrollViewDelegate,AFImageViewerDelegate>

@property (nonatomic,strong) NSMutableArray *arrayPhotos;
@property (nonatomic,strong) UIScrollView *scrollViewPhotos;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *arrayPages;

@property (nonatomic,strong) AFImageViewer *imageViewer;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatior;

@end

@implementation CatalogueViewController

- (void)viewDidLoad {
    

    _arrayPhotos = [NSMutableArray array];
    
    
    _activityIndicatior = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatior.frame = CGRectMake(100,200 , 120, 120);

    [self.view addSubview:_activityIndicatior];
    [_activityIndicatior startAnimating];
    
    PFQuery *query = [PFQuery queryWithClassName:@"db"];
    [query whereKeyExists:@"objectId"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error)
        {
           [self getPhotoArrayFromParseArray:objects];
            
            
            
        }
        else
        {
            
        }
    }];

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - İmage Viewer Methods and Delegates
-(void)setupViewer
{
    _imageViewer = [[AFImageViewer alloc]initWithFrame:CGRectMake(0,self.navigationController.navigationBar.bounds.size.height , 320, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height)];
    [_imageViewer setInitialPage:0];
    [self.view addSubview:_imageViewer];
     [_imageViewer setImages:_arrayPhotos];
    [_activityIndicatior stopAnimating];
    [_activityIndicatior removeFromSuperview];

}
//-(int)numberOfImages
//{
//    return  (int)_arrayPhotos.count;
//}
//
//-(UIImageView *)imageViewForPage:(int)page
//{
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dark_blue.jpg"]];
//    imgView.image = [_arrayPhotos objectAtIndex:page];
//    return imgView;
//}

-(void)getPhotoArrayFromParseArray:(NSArray *)array
{
    
    
    dispatch_group_t group =  dispatch_group_create();
    
    for (int i=0; i<array.count; i++) {
        PFObject *obj = [array objectAtIndex:i];
        PFFile *file = [obj objectForKey:@"image"];
        dispatch_group_enter(group);
        [file getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
          
            if (!error) {
                UIImage *image = [UIImage imageWithData:imageData];
                [_arrayPhotos addObject:image];
                }
            dispatch_group_leave(group);
        }];
        
    }
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self setupViewer];
    
    });
    
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
