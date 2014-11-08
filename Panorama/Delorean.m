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
        glTranslatef(-1.0, 0, 0);
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
