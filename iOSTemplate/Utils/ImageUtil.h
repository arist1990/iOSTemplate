//
//  ImageUtil.h
// SayItAgain
//
//  Created by ARIST on 15/10/6.
//  Copyright (c) 2015年 ytd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtil : NSObject

+ (UIImage *)getCIGaussianBlurImageWithRadius:(CGFloat)radius image:(UIImage *)image;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (UIImage *)getImageFromColor:(UIColor *)color size:(CGSize)size;

@end
