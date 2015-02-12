//
//  UIImage+Resize.h
//  CoagmentoIOS
//
//  Created by Josue Reyes on 10/12/13.
//  Copyright (c) 2013 Josue Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage_Resize : UIImage

+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;

@end
