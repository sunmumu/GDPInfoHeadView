
//  Created by sunmumu

#import "GDPInfoHeadView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

@interface GDPInfoHeadView ()

@property (nonatomic, strong) UIImageView       *headImageView;
@property (nonatomic, strong) UILabel           *headLabel;

@property (nonatomic, copy) ImageBlock          imageBlock;
@property (nonatomic, copy) NSString            *placeImageName;
@property (nonatomic, weak) UIViewController    *target;

@end

@implementation GDPInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame headImageName:(NSString *)headImageName headLabelName:(NSString *)headLabelName target:(UIViewController *)target imageBlock:(ImageBlock)imageBlock {
    if (self = [super initWithFrame:frame]) {
        self.placeImageName = headImageName;
        self.headLabelName = headLabelName;
        self.target = target;
        self.imageBlock = imageBlock;
        [self setupSubViews];
    }
    return self;
}

+ (instancetype)_alloc {
    return [super allocWithZone:NSDefaultMallocZone()];
}

- (instancetype)init {
    NSCAssert(NO, @"请使用`- (instancetype)initWithFrame:(CGRect)frame headImageName:(NSString *)headImageName headLabelName:(NSString *)headLabelName target:(UIViewController *)target imageBlock:(ImageBlock)imageBlock`方法创建对象");
    return nil;
}

// MARK: - setupUI
- (void)setupSubViews {
    [self addSubview:self.headImageView];
    [self addSubview:self.headLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_top).offset(40);
        make.width.equalTo(@(70));
        make.height.equalTo(@(70));
    }];
    [self.headLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headImageView.mas_centerX).offset(0);
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.width.equalTo(@(100));
        make.height.equalTo(@(17));
    }];
}

// MARK: - Action -
- (void)didClickHeadImageView {
    [self showAlertController];
}

// MARK: - 弹出AlertController
- (void)showAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了拍照");
        [self selectImageFromCamera:self.target];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了相册");
        [self selectImageFromAlbum:self.target];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self.target presentViewController:alert animated:true completion:nil];
}

// MARK: - 弹出相机界面
- (void)selectImageFromCamera:(UIViewController *)target{
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [target presentViewController:picker animated:YES completion:nil];
    } else {
//        DebugLog(@"该设备无摄像头");
    }
}

// MARK: - 弹出相册界面
- (void)selectImageFromAlbum:(UIViewController *)target{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [target presentViewController:picker animated:YES completion:nil];
}

// MARK: - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (img == nil) {
        img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    NSData *data = UIImagePNGRepresentation(img);
    float mb = 1024.0 * 1024.0 * 0.5;
    float size = [data length];
    if (size > mb) {
        img = [self imageWithImageSimple:img scaledToSize:CGSizeMake(img.size.width * mb / size, img.size.height * mb / size)];
    }
    self.headImageView.image = img;
    __weak typeof(self) weakSelf = self;
    if (weakSelf.imageBlock) {
        weakSelf.imageBlock(img);
    }
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// MARK: - Setter -
- (void)setHeadImageName:(NSString *)headImageName {
    _headImageName = headImageName;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:headImageName] placeholderImage:[UIImage imageNamed:self.placeImageName]];
}

// MARK: - Getter -
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 35;
        _headImageView.image = [UIImage imageNamed:self.placeImageName];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickHeadImageView)];
        [_headImageView addGestureRecognizer:tap];
    }
    return _headImageView;
}

- (UILabel *)headLabel {
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        _headLabel.text = @"点击更换头像";
        [_headLabel setTextAlignment:NSTextAlignmentCenter];
        _headLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
        _headLabel.font = [UIFont systemFontOfSize:13];
    }
    return _headLabel;
}

@end
