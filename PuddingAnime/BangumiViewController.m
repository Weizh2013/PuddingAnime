//
//  BangumiViewController.m
//  PuddingAnime
//
//  Created by apple on 15/10/7.
//  Copyright (c) 2015年 Weizh. All rights reserved.
//

#import "BangumiViewController.h"
#import "RecommendViewController.h"
#import "CategoryViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface BangumiViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
//    UIViewController *_currentViewCtrl;
    RecommendViewController *_recommendCtrl;
    CategoryViewController *_categoryCtrl;
    NSArray *_viewArray;
}
@end

@implementation BangumiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageViewInit];
    
}

#pragma mark init
- (void)pageViewInit{
    _recommendCtrl = [RecommendViewController new];
    _categoryCtrl = [CategoryViewController new];
    _viewArray = @[_recommendCtrl,_categoryCtrl];
    [self setViewControllers:@[_viewArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.dataSource = self;
    self.delegate = self;
    [self gestureDeal];
}

#pragma mark pageView delegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if ([_viewArray indexOfObject:viewController] == 0) {
        return nil;
    }else{
        return _viewArray[0];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if ([_viewArray indexOfObject:viewController] == 1) {
        return nil;
    }else{
        return _viewArray[1];
    }
}


#pragma mark gestrue deal
- (void)gestureDeal{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSValue *value = change[@"new"];
    CGPoint point = value.CGPointValue;
    UIScrollView *scrollView = object;
    if (point.x <= self.view.bounds.size.width && [_viewArray indexOfObject:self.viewControllers.firstObject] == 0) {
        scrollView.panGestureRecognizer.enabled = NO;
        scrollView.panGestureRecognizer.enabled = YES;
    }else{
        self.mm_drawerController.panGestureRecongnizer.enabled = NO;
        self.mm_drawerController.panGestureRecongnizer.enabled = YES;
    }
}

#pragma mark self view delegate
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
