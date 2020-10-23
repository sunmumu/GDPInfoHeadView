
//  Created by sunmumu

#import <UIKit/UIKit.h>

@interface GDPInfoHeadView : UIView <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

typedef void (^ImageBlock)(UIImage *image);

/**
 头像图片URL string
 */
@property (nonatomic, copy) NSString            *headImageName;
/**
 头像下面Label名称
 */
@property (nonatomic, copy) NSString            *headLabelName;

- (instancetype)initWithFrame:(CGRect)frame headImageName:(NSString *)headImageName headLabelName:(NSString *)headLabelName target:(UIViewController *)target imageBlock:(ImageBlock)imageBlock;

@end
