封装个人中心,头像视图, 可以更改头像.

# 效果: 
个人中心,头像视图,可拍照和获取相册图片

如下GIF

![GDPInfoHeadView](https://github.com/sunmumu/GDPInfoHeadView/blob/master/images/head.GIF)

## Use
下载GDPInfoHeadView框架,把GDPInfoHeadView文件夹拷贝到项目中.
在控制器中#import "GDPInfoHeadView.h".

## 创建方法
```
- (instancetype)initWithFrame:(CGRect)frame 
 
 headImageName:(NSString *)headImageName  
 headLabelName:(NSString *)headLabelName 
 target:(UIViewController *)target 
 imageBlock:(ImageBlock)imageBlock;
 
```

## License

GDPInfoHeadView is released under a MIT License. See LICENSE file for details.

