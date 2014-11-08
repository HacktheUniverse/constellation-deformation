//
//  ViewController.h
//  Panorama
//
//  Created by Robby Kraft on 8/24/13.
//  Copyright (c) 2013 Robby Kraft. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "PanoramaView.h"

@interface ViewController : GLKViewController <PanoramaDelegate>
@property (nonatomic) BOOL buttonTouched;
@property float touchStartX;
@property float delorianStartX;
@end
