//
//  Word.m
//  Space
//
//  Created by Robby Kraft on 12/7/13.
//  Copyright (c) 2013 Robby Kraft. All rights reserved.
//

#import "Delorean.h"
#import <OpenGLES/ES1/gl.h>
#import <GLKit/GLKit.h>

@interface Delorean (){
    NSDictionary *fontBank;
    GLKTextureInfo *texture;
}
@end

@implementation Delorean

-(id) init{
    self = [super init];
    if(self){
        texture = [self loadTexture:@"delorean.png"];
//        fontBank = [NSDictionary dictionaryWithObjectsAndKeys:
//                    [self loadTexture:[CAP stringByAppendingString:@"a.png"]], @"A",
//                    [self loadTexture:[CAP stringByAppendingString:@"b.png"]], @"B",
//                    [self loadTexture:[CAP stringByAppendingString:@"c.png"]], @"C",
//                    [self loadTexture:[CAP stringByAppendingString:@"d.png"]], @"D",
//                    [self loadTexture:[CAP stringByAppendingString:@"e.png"]], @"E",
//                    [self loadTexture:[CAP stringByAppendingString:@"f.png"]], @"F",
//                    [self loadTexture:[CAP stringByAppendingString:@"g.png"]], @"G",
//                    [self loadTexture:[CAP stringByAppendingString:@"h.png"]], @"H",
//                    [self loadTexture:[CAP stringByAppendingString:@"i.png"]], @"I",
//                    [self loadTexture:[CAP stringByAppendingString:@"j.png"]], @"J",
//                    [self loadTexture:[CAP stringByAppendingString:@"k.png"]], @"K",
//                    [self loadTexture:[CAP stringByAppendingString:@"l.png"]], @"L",
//                    [self loadTexture:[CAP stringByAppendingString:@"m.png"]], @"M",
//                    [self loadTexture:[CAP stringByAppendingString:@"n.png"]], @"N",
//                    [self loadTexture:[CAP stringByAppendingString:@"o.png"]], @"O",
//                    [self loadTexture:[CAP stringByAppendingString:@"p.png"]], @"P",
//                    [self loadTexture:[CAP stringByAppendingString:@"q.png"]], @"Q",
//                    [self loadTexture:[CAP stringByAppendingString:@"r.png"]], @"R",
//                    [self loadTexture:[CAP stringByAppendingString:@"s.png"]], @"S",
//                    [self loadTexture:[CAP stringByAppendingString:@"t.png"]], @"T",
//                    [self loadTexture:[CAP stringByAppendingString:@"u.png"]], @"U",
//                    [self loadTexture:[CAP stringByAppendingString:@"v.png"]], @"V",
//                    [self loadTexture:[CAP stringByAppendingString:@"w.png"]], @"W",
//                    [self loadTexture:[CAP stringByAppendingString:@"x.png"]], @"X",
//                    [self loadTexture:[CAP stringByAppendingString:@"y.png"]], @"Y",
//                    [self loadTexture:[CAP stringByAppendingString:@"z.png"]], @"Z",
//                    [self loadTexture:[LOW stringByAppendingString:@"a.png"]], @"a",
//                    [self loadTexture:[LOW stringByAppendingString:@"b.png"]], @"b",
//                    [self loadTexture:[LOW stringByAppendingString:@"c.png"]], @"c",
//                    [self loadTexture:[LOW stringByAppendingString:@"d.png"]], @"d",
//                    [self loadTexture:[LOW stringByAppendingString:@"e.png"]], @"e",
//                    [self loadTexture:[LOW stringByAppendingString:@"f.png"]], @"f",
//                    [self loadTexture:[LOW stringByAppendingString:@"g.png"]], @"g",
//                    [self loadTexture:[LOW stringByAppendingString:@"h.png"]], @"h",
//                    [self loadTexture:[LOW stringByAppendingString:@"i.png"]], @"i",
//                    [self loadTexture:[LOW stringByAppendingString:@"j.png"]], @"j",
//                    [self loadTexture:[LOW stringByAppendingString:@"k.png"]], @"k",
//                    [self loadTexture:[LOW stringByAppendingString:@"l.png"]], @"l",
//                    [self loadTexture:[LOW stringByAppendingString:@"m.png"]], @"m",
//                    [self loadTexture:[LOW stringByAppendingString:@"n.png"]], @"n",
//                    [self loadTexture:[LOW stringByAppendingString:@"o.png"]], @"o",
//                    [self loadTexture:[LOW stringByAppendingString:@"p.png"]], @"p",
//                    [self loadTexture:[LOW stringByAppendingString:@"q.png"]], @"q",
//                    [self loadTexture:[LOW stringByAppendingString:@"r.png"]], @"r",
//                    [self loadTexture:[LOW stringByAppendingString:@"s.png"]], @"s",
//                    [self loadTexture:[LOW stringByAppendingString:@"t.png"]], @"t",
//                    [self loadTexture:[LOW stringByAppendingString:@"u.png"]], @"u",
//                    [self loadTexture:[LOW stringByAppendingString:@"v.png"]], @"v",
//                    [self loadTexture:[LOW stringByAppendingString:@"w.png"]], @"w",
//                    [self loadTexture:[LOW stringByAppendingString:@"x.png"]], @"x",
//                    [self loadTexture:[LOW stringByAppendingString:@"y.png"]], @"y",
//                    [self loadTexture:[LOW stringByAppendingString:@"z.png"]], @"z",
//                    [self loadTexture:[NUM stringByAppendingString:@"0.png"]], @"0",
//                    [self loadTexture:[NUM stringByAppendingString:@"1.png"]], @"1",
//                    [self loadTexture:[NUM stringByAppendingString:@"2.png"]], @"2",
//                    [self loadTexture:[NUM stringByAppendingString:@"3.png"]], @"3",
//                    [self loadTexture:[NUM stringByAppendingString:@"4.png"]], @"4",
//                    [self loadTexture:[NUM stringByAppendingString:@"5.png"]], @"5",
//                    [self loadTexture:[NUM stringByAppendingString:@"6.png"]], @"6",
//                    [self loadTexture:[NUM stringByAppendingString:@"7.png"]], @"7",
//                    [self loadTexture:[NUM stringByAppendingString:@"8.png"]], @"8",
//                    [self loadTexture:[NUM stringByAppendingString:@"9.png"]], @"9",
//                    [self loadTexture:@"Incos_space.png"], @" ",nil];
    }
    return self;
}

-(void) execute{

    static const GLfloat rectangleVertices[] = {
        -2.0,  1,
        2.0,  1,
        -2.0, -1,
        2.0, -1
    };
    static const GLfloat quadTextureCoords[] = {
        0.0, 1.0,
        1.0, 1.0,
        0.0, 0.0,
        1.0, 0.0
    };
    
    glEnable(GL_TEXTURE_2D);
    glEnable(GL_BLEND);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);
    glFrontFace(GL_CW);
     
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    
    glPushMatrix();
        glBindTexture(GL_TEXTURE_2D, [texture name]);
        glVertexPointer(2, GL_FLOAT, 0, rectangleVertices);
        glTexCoordPointer(2, GL_FLOAT, 0, quadTextureCoords);
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glPopMatrix();
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_BLEND);
    glDisable(GL_CULL_FACE);
}

-(GLKTextureInfo *) loadTexture:(NSString *) filename
{
    NSError *error;
    GLKTextureInfo *info;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], GLKTextureLoaderOriginBottomLeft, nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:NULL];
    info=[GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    glBindTexture(GL_TEXTURE_2D, info.name);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    return info;
}

@end
