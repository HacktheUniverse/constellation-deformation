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
    
    // compute values (takes 
//    [self loadConstellations];
    
    NSString *constellationArrayString = @"1257, 339, 3, 76, 95, 274, 260, 53, 342, 141, 140, 234, 195, 548, 141, 837, 1663, 144, 251, 299, 365, 103, 405, 341, 433, 566, 341, 1313, 640, 576, 568, 973, 1160, 515, 394, 159, 34, 195, 387, 131, 598, 343, 67, 412, 989, 597, 1543, 729, 645, 763, 327, 113, 545, 336, 7, 155, 0, 180, 37, 22, 22, 275, 93, 1121, 679, 706, 1366, 275, 565, 375, 321, 270, 307, 51, 278, 375, 1048, 761, 208, 347, 360, 865, 512, 392, 760, 479, 400, 498, 760, 791, 348, 794, 264, 172, 527, 264, 449, 555, 612, 14, 782, 121, 251, 250, 648, 372, 528, 337, 393, 676, 830, 337, 688, 455, 58, 30, 146, 136, 224, 146, 46, 756, 625, 698, 1493, 174, 57, 698, 664, 126, 770, 520, 476, 533, 165, 294, 368, 1268, 460, 875, 563, 358, 673, 636, 1039, 1014, 891, 410, 500, 302, 609, 708, 972, 670, 152, 581, 1163, 654, 305, 353, 9, 50, 266, 454, 167, 715, 593, 370, 715, 2265, 2711, 1960, 1735, 37, 513, 88, 348, 287, 382, 1052, 245, 43, 590, 148, 233, 313, 184, 561, 690, 354, 145, 193, 575, 463, 502, 98, 64, 76, 10, 234, 324, 2468, 483, 775, 451, 396, 205, 197, 309, 252, 284, 213, 217, 89, 137, 65, 223, 814, 162, 202, 115, 406, 242, 137, 499, 350, 522, 56, 139, 92, 87, 56, 102, 220, 361, 303, 99, 230, 470, 1924, 864, 1116, 470, 276, 133, 418, 2174, 444, 646, 99, 132, 52, 380, 151, 472, 2608, 385, 509, 201, 471, 667, 232, 382, 746, 189, 35, 117, 135, 203, 101, 236, 52, 203, 511, 96, 77, 154, 450, 164, 611, 2564, 697, 783, 812, 991, 712, 2656, 840, 971, 480, 1064, 530, 56, 227, 54, 61, 546, 856, 557, 306, 1499, 594, 2523, 467, 102, 122, 220, 325, 344, 871, 878, 2608, 482, 768, 599, 386, 161, 87, 288, 496, 751, 560, 542, 904, 110, 2, 889, 399, 1733, 876, 1717, 800, 787, 346, 160, 28, 229, 120, 231, 254, 66, 40, 271, 1, 413, 442, 605, 201, 276, 624, 465, 642, 117, 168, 930, 236, 994, 829, 777, 585, 681, 92, 620, 257, 290, 82, 422, 357, 263, 806, 194, 471, 133, 128, 127, 241, 424, 963, 836, 241, 585, 492, 408, 851, 1088, 1393, 1075, 1129, 1250, 24, 12, 351, 173, 186, 269, 247, 267, 524, 128, 376, 26, 208, 27, 105, 41, 5, 181, 207, 356, 112, 27, 523, 179, 100, 163, 107, 179, 27, 295, 390, 338, 255, 13, 166, 130, 18, 338, 256, 374, 328, 121, 457, 318, 403, 619, 892, 429, 781, 765, 196, 106, 438, 855, 518, 1053, 917, 1231, 686, 1002, 630, 235, 60, 402, 34, 177, 156, 503, 142, 425, 262, 131, 248, 453, 261, 78, 109, 311, 494, 513, 776, 995, 4, 744, 292, 221, 631, 744, 478, 258, 2468, 84, 451, 1108, 1964, 74, 71, 63, 108, 246, 571, 282, 928, 123, 461, 260, 79, 198, 635, 436, 404, 384, 147, 70, 91, 212, 525, 171, 116, 11, 362, 218, 445, 247, 171, 47, 0, 774, 580, 559, 434, 2491, 2237, 2031, 1823, 196, 491, 31, 29, 73, 42, 138, 150, 42, 21, 240, 62, 97, 50, 277, 21, 398, 158, 164, 440, 339, 535, 637, 371, 539, 225, 349, 226, 608, 797, 86, 94, 215, 118, 417, 211, 59, 125, 86, 176, 867, 1241, 495, 58, 279, 579, 45, 265, 497, 517, 330, 734, 754, 629, 301, 265, 626, 135, 2752, 1013, 216, 650, 298, 721, 541, 574, 653, 844, 741, 541, 2, 310, 182, 283, 272, 81, 2, 148, 187, 811, 23, 16, 285, 514, 43, 191, 787, 17, 622, 857, 694, 907, 755, 1619, 2574, 2646, 616, 17, 36, 340, 243, 396, 80, 85, 351, 280, 111, 293, 90, 44, 32, 577, 544, 68, 323, 435, 421, 111, 125, 378, 237, 153, 649, 145, 910, 388, 895, 584, 589, 184, 554, 614, 252, 89, 259, 628, 1942, 1118, 546, 306, 1275, 1114, 373, 72, 129, 1392, 373, 188, 428, 852, 300, 970, 204, 119, 521, 228, 345, 432, 415, 592, 893, 1500, 359, 682, 592, 526, 832, 680, 846, 414, 668, 331, 1077, 1170, 918, 19, 70, 459, 1096, 1820, 38, 69, 33, 239, 85, 80, 36, 239, 912, 149, 508, 767, 644, 885, 508, 381, 316, 132, 210, 452, 104, 49, 326, 1081, 436, 1063, 8, 253, 26, 73, 244, 6, 55, 31, 8, 582, 848, 1859, 795, 821, 848, 437, 902, 219, 952, 790, 990, 529, 824, 199, 416, 489, 662, 1011, 758, 834, 553, 206, 879, 602, 909, 922, 956, 749, 958, 383, 817, 183, 113, 423, 77, 157, 15, 134, 75, 175, 332, 238, 39, 170, 83, 25, 114, 192, 714, 845, 601, 249, 192, 458, 462, 48, 578, 329, 420, 190, 297, 696, 1490, 169, 222, 672, 480, 296";
    
    NSString *constellationMetaString = @"0, 2, 2, 6, 8, 7, 15, 2, 17, 2, 19, 8, 27, 6, 33, 4, 37, 2, 39, 1, 40, 7, 47, 3, 50, 4, 54, 2, 56, 5, 61, 15, 76, 6, 82, 7, 89, 3, 92, 4, 96, 10, 106, 6, 112, 4, 116, 4, 120, 8, 128, 33, 161, 4, 165, 4, 169, 4, 173, 3, 176, 2, 178, 2, 180, 5, 185, 6, 191, 8, 199, 2, 201, 4, 205, 4, 209, 5, 214, 10, 224, 3, 227, 5, 232, 2, 234, 4, 238, 5, 243, 2, 245, 4, 249, 2, 251, 4, 255, 3, 258, 2, 260, 4, 264, 9, 273, 5, 278, 4, 282, 4, 286, 3, 289, 3, 292, 4, 296, 4, 300, 9, 309, 5, 314, 8, 322, 6, 328, 3, 331, 3, 334, 10, 344, 8, 352, 3, 355, 6, 361, 5, 366, 9, 375, 5, 380, 2, 382, 3, 385, 4, 389, 2, 391, 4, 395, 3, 398, 2, 400, 2, 402, 9, 411, 6, 417, 7, 424, 2, 426, 4, 430, 3, 433, 3, 436, 6, 442, 3, 445, 4, 449, 10, 459, 9, 468, 2, 470, 7, 477, 7, 484, 5, 489, 3, 492, 5, 497, 2, 499, 6, 505, 9, 514, 5, 519, 5, 524, 2, 526, 3, 529, 4, 533, 7, 540, 11, 551, 12, 563, 7, 570, 11, 581, 2, 583, 5, 588, 6, 594, 7, 601, 8, 609, 2, 611, 11, 622, 5, 627, 3, 630, 12, 642, 3, 645, 2, 647, 7, 654, 6, 660, 6, 666, 17, 683, 16, 699, 5, 704, 8, 712, 7, 719, 4, 723, 4, 727, 3, 730, 15, 745, 3, 748, 5, 753, 7, 760, 3, 763, 8, 771, 3, 774, 13, 787, 18, 805, 3";

    NSArray *cArray = [constellationArrayString componentsSeparatedByString:@", "];
    NSArray *cMetaArray = [constellationMetaString componentsSeparatedByString:@", "];
    numConstellations = (unsigned int)cArray.count;
    numConstellationMeta = (unsigned int)cMetaArray.count;
    constellations = malloc(sizeof(unsigned short)*numConstellations);
    constellationMeta = malloc(sizeof(unsigned short) * numConstellationMeta);
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    for(int i = 0; i < numConstellations; i++){
        constellations[i] = [[f numberFromString:[cArray objectAtIndex:i]] unsignedShortValue];
    }
    for(int i = 0; i < numConstellationMeta; i++){
        constellationMeta[i] = [[f numberFromString:[cMetaArray objectAtIndex:i]] unsignedShortValue];
    }
    
    numStars = (int)starArray.count - 1;
    stars = malloc(sizeof(float)*numStars*3);
    velocities = malloc(sizeof(float)*numStars*3);
    mag = malloc(sizeof(float)*numStars);

    for(int i = 0; i < numStars; i++){
        stars[i*3+0] = [[[starArray objectAtIndex:i] objectAtIndex:1] floatValue];
        stars[i*3+1] = [[[starArray objectAtIndex:i] objectAtIndex:2] floatValue];
        stars[i*3+2] = [[[starArray objectAtIndex:i] objectAtIndex:3] floatValue];
        velocities[i*3+0] = [[[starArray objectAtIndex:i] objectAtIndex:13] floatValue] / 1000 / 4;
        velocities[i*3+1] = [[[starArray objectAtIndex:i] objectAtIndex:14] floatValue] / 1000 / 4;
        velocities[i*3+2] = [[[starArray objectAtIndex:i] objectAtIndex:15] floatValue] / 1000 / 4;
        
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
//    increment = [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(incrementStars) userInfo:nil repeats:YES];
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
    
    glColor4f(0.5f, 0.5f, 0.5f, 1.0f);
    
    glEnableClientState(GL_VERTEX_ARRAY);
    for(int i = 0; i < numConstellationMeta*.5; i++){
        glVertexPointer(3, GL_FLOAT, 0, stars);
        glDrawElements(GL_LINE_STRIP, constellationMeta[i*2+1], GL_UNSIGNED_SHORT, &constellations[constellationMeta[i*2]]);
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

/*-(void) loadConstellations{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"constellations" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
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
    
    printf("\n\n");
    for(int i = 0; i < numConstellations; i++){
        printf("%d, ",constellations[i]);
    }
    printf("\n\n");
    for(int i = 0; i < numConstellationMeta; i++){
        printf("%d, ",constellationMeta[i]);
    }
    
    NSLog(@"constellations loaded");
}*/


@end