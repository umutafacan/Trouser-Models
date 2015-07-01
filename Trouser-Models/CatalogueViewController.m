//
//  CatalogueViewController.m
//  Trouser-Models
//
//  Created by umut on 28/06/15.
//  Copyright (c) 2015 Umut Afacan. All rights reserved.
//

#import "CatalogueViewController.h"
#import <Parse/Parse.h>


@interface CatalogueViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *arrayPhotos;
@property (nonatomic,strong) UIScrollView *scrollViewPhotos;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *arrayPages;

@end

@implementation CatalogueViewController

- (void)viewDidLoad {
    
    
    
    

    _arrayPhotos = [NSMutableArray array];
    
    
    
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
//    RDImageViewerController *viewController = [[RDImageViewerController alloc]initWithImageHandler:^UIImage *(NSInteger pageIndex) {
//        
//        return [_arrayPhotos objectAtIndex:pageIndex];
//        
//    } numberOfImages:_arrayPhotos.count direction:RDPagingViewDirectionRight];
//    
//    viewController.loadAsync = YES;
//    
//    
//    [self.navigationController pushViewController:viewController animated:NO];
//    

}






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
