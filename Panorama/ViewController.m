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
    float *stars, *velocities;
    float *mag;
    unsigned int numStars;
    NSTimer *increment;
    unsigned short *constellations;
    unsigned int numConstellations;
    unsigned short *constellationMeta;
    unsigned int numConstellationMeta;
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
//id,x,y,z,colorb_v,lum,absmag,appmag,texnum,distly,dcalc,plx,plxerr,vx,vy,vz,speed,hipnum,name
-(void)loadStars{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"visible_stars" ofType:@"csv"];
    NSMutableArray *starArray = [NSMutableArray arrayWithContentsOfCSVFile:path];

    NSLog(@"%d stars loaded",(int)starArray.count);
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"constellations" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];

    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
//    NSLog(@"(%@) %@", error, json);
    
    NSLog(@"%@",[json allValues]);
    
    NSArray *jsonArray = [json allValues];
    NSMutableArray *constellationIndexes = [NSMutableArray array];
    NSMutableArray *constellationMetaM = [NSMutableArray array];
    
    
    for(int i = 0; i < jsonArray.count; i++){  //iterate over constellations
        NSArray *constellationPoints = jsonArray[i];
        // begin operations on 1 constellation
        int constellationStartIndex = -1;
        int constellationLength = 0;
        for(int j = 0; j < constellationPoints.count; j++){ // iterate over individual points in constellation
            for(int k = 0; k < starArray.count; k++){  // search for a match in the big star database
                NSArray *starData = [starArray objectAtIndex:k];
                if(starData.count >= 19){
                    NSString *starNames = [starData objectAtIndex:18];
                    NSArray *HIP = [starNames componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    if([[HIP objectAtIndex:0] isEqualToString:constellationPoints[j]]){
                        if(constellationStartIndex == -1) constellationStartIndex = constellationIndexes.count;
                        [constellationIndexes addObject:[NSNumber numberWithInt:k]];
                        constellationLength++;
                    }
                }
            }
        }
        // store metadata
        if(constellationStartIndex != -1){
            [constellationMetaM addObject:[NSNumber numberWithInt:constellationStartIndex]];
            [constellationMetaM addObject:[NSNumber numberWithInt:constellationLength]];
        }
    }
    numConstellations = (unsigned int)constellationIndexes.count;
    numConstellationMeta = (unsigned int)constellationMetaM.count;

    constellations = malloc(sizeof(unsigned short)*numConstellations);
    constellationMeta = malloc(sizeof(unsigned short) * numConstellationMeta);
    for(int i = 0; i < numConstellations; i++){
        constellations[i] = [[constellationIndexes objectAtIndex:i] unsignedShortValue];
    }
    for(int i = 0; i < numConstellationMeta; i++){
        constellationMeta[i] = [[constellationMetaM objectAtIndex:i] unsignedShortValue];
    }
//    NSLog(@"%@", constellationIndexes);
//    NSLog(@"%@", constellationMetaM);
    for(int i = 0; i < numConstellations; i++){
        NSLog(@"%d",constellations[i]);
    }
    for(int i = 0; i < numConstellationMeta; i++){
        NSLog(@"%d",constellationMeta[i]);
    }
    
    NSLog(@"constelltions loaded");

    numStars = (int)starArray.count - 1;
    stars = malloc(sizeof(float)*numStars*3);
    velocities = malloc(sizeof(float)*numStars*3);
    mag = malloc(sizeof(float)*numStars);

    for(int i = 0; i < numStars; i++){
        stars[i*3+0] = [[[starArray objectAtIndex:i] objectAtIndex:1] floatValue];
        stars[i*3+1] = [[[starArray objectAtIndex:i] objectAtIndex:2] floatValue];
        stars[i*3+2] = [[[starArray objectAtIndex:i] objectAtIndex:3] floatValue];
        velocities[i*3+0] = [[[starArray objectAtIndex:i] objectAtIndex:13] floatValue] / 1000 /5;
        velocities[i*3+1] = [[[starArray objectAtIndex:i] objectAtIndex:14] floatValue] / 1000 /5;
        velocities[i*3+2] = [[[starArray objectAtIndex:i] objectAtIndex:15] floatValue] / 1000 /5;
        
//        float distance = sqrt(powf(stars[i*3+0],2) + powf(stars[i*3+1],2) + powf(stars[i*3+2],2));
//        mag[i] = 2.5*log10f( powf((distance/10.0),2) ) + [[[array objectAtIndex:i] objectAtIndex:7] floatValue];
//        if(mag[i] < -2) mag[i] = 5;
//        else if(mag[i] > 6.5) mag[i] = 1;
//        else{
//            mag[i] = 4*(1/((mag[i]+2)/8.5)) + 1;
//        }

//        mag[i] = ( (2.44 + 6.5) / (2.44 + ([[[array objectAtIndex:i] objectAtIndex:7] floatValue])) - 1);// * 4 + 1;
        
        mag[i] = 1.44+[[[starArray objectAtIndex:i] objectAtIndex:7] floatValue];
        mag[i] /= (1.44 + 6.5);
        mag[i] = 1-mag[i];
        
        mag[i] = powf(mag[i], .75);
        
//        mag[i] *= 4;
//        mag[i] = 1/mag[i];
//        mag[i] = ( 1.0 / (1.44 + [[[array objectAtIndex:i] objectAtIndex:7] floatValue]) );  // * 4 + 1;

//        mag[i] = powf(mag[i], .25);
        //[[[array objectAtIndex:i] objectAtIndex:7] floatValue]; //5
//        NSLog(@"%f",mag[i]);
    }
    
//    for(int i = 0; i < numStars; i++){
//        NSLog(@"X:%.3f  Y:%.3f  Z:%.3f", stars[i*3+0], stars[i*3+1], stars[i*3+2]);
//    }
    increment = [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(incrementStars) userInfo:nil repeats:YES];
}

-(void) incrementStars{
    for(int i = 0; i < numStars; i++){
        stars[i*3+0] += velocities[i*3+0];
        stars[i*3+1] += velocities[i*3+1];
        stars[i*3+2] += velocities[i*3+2];
    }
}

-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    glEnable(GL_POINT_SMOOTH);
    [panoramaView updateOrientation];
    glPushMatrix(); // begin device orientation
        glMultMatrixf(panoramaView.attitudeMatrix.m);

//        [panoramaView draw];
    
        glPushMatrix();
            // object code
    
// constellation lines
    
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
    
    glEnableClientState(GL_VERTEX_ARRAY);
    for(int i = 0; i < numConstellationMeta*.5; i++){
        glVertexPointer(3, GL_FLOAT, 0, stars);
        glDrawElements(GL_LINE_LOOP, constellationMeta[i*2+1], GL_UNSIGNED_SHORT, &constellations[constellationMeta[i*2]]);
    }
    glDisableClientState(GL_VERTEX_ARRAY);

    
    
// star points
    
    glPointSize(1);
    for(int i = 0; i < numStars; i++){
        glPointSize( mag[i]*3.0 );
        glColor4f(mag[i], mag[i], mag[i], 1.0f);
        glEnableClientState(GL_VERTEX_ARRAY);
        glVertexPointer(3, GL_FLOAT, 0, &stars[i]);
        glDrawArrays(GL_POINTS, 0, 1);
        glDisableClientState(GL_VERTEX_ARRAY);
    }
    
    
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