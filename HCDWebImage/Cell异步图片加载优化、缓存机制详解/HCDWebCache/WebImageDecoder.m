
#import "WebImageDecoder.h"

@implementation UIImage (ForceDecode)

size_t FICByteAlign(size_t width, size_t alignment) {
    return ((width + (alignment - 1)) / alignment) * alignment;
}

size_t FICByteAlignForCoreAnimation(size_t bytesPerRow) {
    return FICByteAlign(bytesPerRow, 64);
}

+ (UIImage *)decodedImageWithImage:(UIImage *)image {
    
    CGImageRef imageRef = image.CGImage;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    CGRect imageRect = (CGRect){.origin = CGPointZero, .size = imageSize};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    int infoMask = (bitmapInfo & kCGBitmapAlphaInfoMask);
    BOOL anyNonAlpha = (infoMask == kCGImageAlphaNone ||
                        infoMask == kCGImageAlphaNoneSkipFirst ||
                        infoMask == kCGImageAlphaNoneSkipLast);
    
    // CGBitmapContextCreate doesn't support kCGImageAlphaNone with RGB.
    // https://developer.apple.com/library/mac/#qa/qa1037/_index.html
    if (infoMask == kCGImageAlphaNone && CGColorSpaceGetNumberOfComponents(colorSpace) > 1) {
        // Unset the old alpha info.
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
        
        // Set noneSkipFirst.
        bitmapInfo |= kCGImageAlphaNoneSkipFirst;
    }
    // Some PNGs tell us they have alpha but only 3 components. Odd.
    else if (!anyNonAlpha && CGColorSpaceGetNumberOfComponents(colorSpace) == 3) {
        // Unset the old alpha info.
        bitmapInfo &= ~kCGBitmapAlphaInfoMask;
        bitmapInfo |= kCGImageAlphaPremultipliedFirst;
    }
    // It calculates the bytes-per-row based on the bitsPerComponent and width arguments.
    size_t bytesPerRow = FICByteAlignForCoreAnimation(imageSize.width * 4);
    void * data = (void *)malloc(imageSize.height * bytesPerRow);
    CGContextRef context = CGBitmapContextCreate(data,   //分配最小内存
                                                 imageSize.width,
                                                 imageSize.height,
                                                 CGImageGetBitsPerComponent(imageRef),
                                                 bytesPerRow,  //字节对齐
                                                 colorSpace,
                                                 bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    
    // If failed, return undecompressed image
    if (!context)
    {
        free(data);
        return image;
    }
    
    CGContextDrawImage(context, imageRect, imageRef);
    
    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(context);
    
    UIImage * dImage = [UIImage imageWithCGImage:decompressedImageRef];
    
    CGContextRelease(context);
    
    free(data);
    
    CGImageRelease(decompressedImageRef);
    
    return dImage;
}

@end
