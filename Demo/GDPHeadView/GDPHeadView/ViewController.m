//
//  ViewController.m
//  GDPHeadView
//
//  Created by ule on 2020/10/23.
//

#import "ViewController.h"
#import "GDPInfoHeadView.h"

@interface ViewController ()

@property (nonatomic, strong) GDPInfoHeadView           *headView;
@property (nonatomic, strong) UIImage                   *headImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.headView];
}


#pragma mark - Getter && Setter
- (GDPInfoHeadView *)headView {
    if (!_headView) {
        CGRect rect = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, 150);
        __weak typeof(self) weakSelf = self;
        _headView = [[GDPInfoHeadView alloc] initWithFrame:rect headImageName:@"mine_upload_headimage" headLabelName:@"点击更换头像" target:self imageBlock:^(UIImage *image) {
            weakSelf.headImage = image;
        }];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

@end
