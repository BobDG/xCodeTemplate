# BDGScreenshot

Light class to easily create screenshots within your App.
You can switch between the older 'layer renderInContext' version or the newer 'drawViewHierarchyInRect' method.
It also provides methods to return halfs of images in case you want to do some slick animations.

## Installation using Cocoapods
```
pod 'BDGScreenshot'
```

## Examples

```
/* Take screenshot of all windows (thus including keyboard) */
+(UIImage *)screenshotFromAllWindows;

/* Take screenshot of different types */
+(UIImage *)screenshotFromView:(UIView *)view;
+(UIImage *)screenshotFromView:(UIView *)view side:(ScreenshotSide)screenshotSide;
+(UIImage *)screenshotFromView:(UIView *)view renderInContext:(BOOL)renderInContext;
+(UIImage *)screenshotFromView:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates;
+(UIImage *)screenshotFromView:(UIView *)view renderInContext:(BOOL)renderInContext afterScreenUpdates:(BOOL)afterScreenUpdates;

/* Take screenshot and get halfs of the screenshot back in a NSArray */
+(NSArray *)screenshotVerticalsFromView:(UIView *)view;
+(NSArray *)screenshotHorizontalsFromView:(UIView *)view;

/* Simply divide the given image into halfs */
+(NSArray *)verticalHalfsFromImage:(UIImage *)image;
+(NSArray *)horizontalHalfsFromImage:(UIImage *)image;
```