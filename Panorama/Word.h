//
//  Word.h
//  Space
//
//  Created by Robby Kraft on 12/7/13.
//  Copyright (c) 2013 Robby Kraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject

@property (nonatomic, strong) NSString *text;

-(id)initWithString:(NSString*)string;
-(void)execute;

@end
