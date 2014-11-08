//
//  ViewController.m
//  Panorama
//
//  Created by Robby Kraft on 8/24/13.
//  Copyright (c) 2013 Robby Kraft. All Rights Reserved.
//

#import "ViewController.h"
#import "PanoramaView.h"
#import <OpenGLES/ES1/gl.h>
#import "CHCSVParser.h"

@interface ViewController (){
    PanoramaView *panoramaView;
    float *stars;
    unsigned long numStars;
}
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadStars];
    panoramaView = [[PanoramaView alloc] init];
    [panoramaView setImage:@"tycho_cyl_glow.png"];
    [panoramaView setOrientToDevice:YES];
    [panoramaView setTouchToPan:NO];
    [panoramaView setPinchToZoom:YES];
    [panoramaView setShowTouches:NO];
    [self setView:panoramaView];
}

-(void)loadStars{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"visible_stars_hacky" ofType:@"csv"];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfCSVFile:path];
//    [array removeObjectAtIndex:0];  // database has one line of header
    NSLog(@"%d stars loaded",(int)array.count);
//    NSLog(@"%@",array);
    numStars = array.count - 1;
    stars = malloc(sizeof(float)*numStars*3);
    for(int i = 0; i < numStars; i++){
        stars[i*3+0] = [[[array objectAtIndex:i] objectAtIndex:1] floatValue];
        stars[i*3+1] = [[[array objectAtIndex:i] objectAtIndex:2] floatValue];
        stars[i*3+2] = [[[array objectAtIndex:i] objectAtIndex:3] floatValue];
    }
    for(int i = 0; i < numStars; i++){
        NSLog(@"X:%.3f  Y:%.3f  Z:%.3f", stars[i*3+0], stars[i*3+1], stars[i*3+2]);
    }
}


-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [panoramaView updateOrientation];
    glPushMatrix(); // begin device orientation
        glMultMatrixf(panoramaView.attitudeMatrix.m);

//        [panoramaView draw];
    
        glPushMatrix();
            // object code
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
    
        glEnableClientState(GL_VERTEX_ARRAY);
        glVertexPointer(3, GL_FLOAT, 0, stars);
        glDrawArrays(GL_POINTS, 0, numStars);
        glDisableClientState(GL_VERTEX_ARRAY);
    
//        static const GLfloat triVertices[] = {
//            0.0f, 0.57735f,
//            .5, -0.288675f,
//            -.5, -0.288675f,
//        };
//        glEnableClientState(GL_VERTEX_ARRAY);
//        glVertexPointer(2, GL_FLOAT, 0, triVertices);
//        glDrawArrays(GL_LINE_LOOP, 0, 3);
//        glDisableClientState(GL_VERTEX_ARRAY);

        glPopMatrix();

    glPopMatrix(); // end device orientation
}

@end