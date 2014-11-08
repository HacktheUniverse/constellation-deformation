//
//  Word.m
//  Space
//
//  Created by Robby Kraft on 12/7/13.
//  Copyright (c) 2013 Robby Kraft. All rights reserved.
//

#import "Word.h"
#import <OpenGLES/ES1/gl.h>
#import <GLKit/GLKit.h>

@interface Word (){
    NSDictionary *fontBank;
    NSArray *textures;
}
@end

@implementation Word

-(id)initWithString:(NSString*)string{
    self = [self init];
    [self setText:string];
    return self;
}

#define CAP @"Incos_Cap_"
#define LOW @"Incos_lower_"

-(id) init{
    self = [super init];
    if(self){
        fontBank = [NSDictionary dictionaryWithObjectsAndKeys:
                    [self loadTexture:[CAP stringByAppendingString:@"a.png"]], @"A",
                    [self loadTexture:[CAP stringByAppendingString:@"b.png"]], @"B",
                    [self loadTexture:[CAP stringByAppendingString:@"c.png"]], @"C",
                    [self loadTexture:[CAP stringByAppendingString:@"d.png"]], @"D",
                    [self loadTexture:[CAP stringByAppendingString:@"e.png"]], @"E",
                    [self loadTexture:[CAP stringByAppendingString:@"f.png"]], @"F",
                    [self loadTexture:[CAP stringByAppendingString:@"g.png"]], @"G",
                    [self loadTexture:[CAP stringByAppendingString:@"h.png"]], @"H",
                    [self loadTexture:[CAP stringByAppendingString:@"i.png"]], @"I",
                    [self loadTexture:[CAP stringByAppendingString:@"j.png"]], @"J",
                    [self loadTexture:[CAP stringByAppendingString:@"k.png"]], @"K",
                    [self loadTexture:[CAP stringByAppendingString:@"l.png"]], @"L",
                    [self loadTexture:[CAP stringByAppendingString:@"m.png"]], @"M",
                    [self loadTexture:[CAP stringByAppendingString:@"n.png"]], @"N",
                    [self loadTexture:[CAP stringByAppendingString:@"o.png"]], @"O",
                    [self loadTexture:[CAP stringByAppendingString:@"p.png"]], @"P",
                    [self loadTexture:[CAP stringByAppendingString:@"q.png"]], @"Q",
                    [self loadTexture:[CAP stringByAppendingString:@"r.png"]], @"R",
                    [self loadTexture:[CAP stringByAppendingString:@"s.png"]], @"S",
                    [self loadTexture:[CAP stringByAppendingString:@"t.png"]], @"T",
                    [self loadTexture:[CAP stringByAppendingString:@"u.png"]], @"U",
                    [self loadTexture:[CAP stringByAppendingString:@"v.png"]], @"V",
                    [self loadTexture:[CAP stringByAppendingString:@"w.png"]], @"W",
                    [self loadTexture:[CAP stringByAppendingString:@"x.png"]], @"X",
                    [self loadTexture:[CAP stringByAppendingString:@"y.png"]], @"Y",
                    [self loadTexture:[CAP stringByAppendingString:@"z.png"]], @"Z",
                    [self loadTexture:[LOW stringByAppendingString:@"a.png"]], @"a",
                    [self loadTexture:[LOW stringByAppendingString:@"b.png"]], @"b",
                    [self loadTexture:[LOW stringByAppendingString:@"c.png"]], @"c",
                    [self loadTexture:[LOW stringByAppendingString:@"d.png"]], @"d",
                    [self loadTexture:[LOW stringByAppendingString:@"e.png"]], @"e",
                    [self loadTexture:[LOW stringByAppendingString:@"f.png"]], @"f",
                    [self loadTexture:[LOW stringByAppendingString:@"g.png"]], @"g",
                    [self loadTexture:[LOW stringByAppendingString:@"h.png"]], @"h",
                    [self loadTexture:[LOW stringByAppendingString:@"i.png"]], @"i",
                    [self loadTexture:[LOW stringByAppendingString:@"j.png"]], @"j",
                    [self loadTexture:[LOW stringByAppendingString:@"k.png"]], @"k",
                    [self loadTexture:[LOW stringByAppendingString:@"l.png"]], @"l",
                    [self loadTexture:[LOW stringByAppendingString:@"m.png"]], @"m",
                    [self loadTexture:[LOW stringByAppendingString:@"n.png"]], @"n",
                    [self loadTexture:[LOW stringByAppendingString:@"o.png"]], @"o",
                    [self loadTexture:[LOW stringByAppendingString:@"p.png"]], @"p",
                    [self loadTexture:[LOW stringByAppendingString:@"q.png"]], @"q",
                    [self loadTexture:[LOW stringByAppendingString:@"r.png"]], @"r",
                    [self loadTexture:[LOW stringByAppendingString:@"s.png"]], @"s",
                    [self loadTexture:[LOW stringByAppendingString:@"t.png"]], @"t",
                    [self loadTexture:[LOW stringByAppendingString:@"u.png"]], @"u",
                    [self loadTexture:[LOW stringByAppendingString:@"v.png"]], @"v",
                    [self loadTexture:[LOW stringByAppendingString:@"w.png"]], @"w",
                    [self loadTexture:[LOW stringByAppendingString:@"x.png"]], @"x",
                    [self loadTexture:[LOW stringByAppendingString:@"y.png"]], @"y",
                    [self loadTexture:[LOW stringByAppendingString:@"z.png"]], @"z",
//                    [self loadTexture:@"0.png"], @"0",
//                    [self loadTexture:@"1.png"], @"1",
//                    [self loadTexture:@"2.png"], @"2",
//                    [self loadTexture:@"3.png"], @"3",
//                    [self loadTexture:@"4.png"], @"4",
//                    [self loadTexture:@"5.png"], @"5",
//                    [self loadTexture:@"6.png"], @"6",
//                    [self loadTexture:@"7.png"], @"7",
//                    [self loadTexture:@"8.png"], @"8",
//                    [self loadTexture:@"9.png"], @"9",
                    [self loadTexture:@"Incos_space.png"], @" ",nil];
    }
    return self;
}

-(void) setText:(NSString *)text{
    NSString *validCharacters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ";
    NSMutableArray *textureArray = [NSMutableArray array];
    for(int i = 0; i < text.length; i++){
        NSString *letter = [[text substringWithRange:NSMakeRange(i, 1)] uppercaseString];
        if ([validCharacters rangeOfString:letter].location != NSNotFound)
            [textureArray addObject:[fontBank objectForKey:letter]];
    }
    textures = textureArray;
    _text = text;
}

-(void) execute{

    static const GLfloat rectangleVertices[] = {
        -1.0,  2,
        1.0,  2,
        -1.0, -2,
        1.0, -2
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
    for(int i = 0; i < textures.count; i++){
        glPushMatrix();
            glTranslatef(i*2.5, 0.0, 0.0);
            glBindTexture(GL_TEXTURE_2D, [(GLKTextureInfo*)(textures[i]) name]);
            glVertexPointer(2, GL_FLOAT, 0, rectangleVertices);
            glTexCoordPointer(2, GL_FLOAT, 0, quadTextureCoords);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        glPopMatrix();
    }
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
