//
//  ResourceScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 3/1/14.
//
//

#import "ResourceScene.h"

@implementation ResourceScene

-(id) initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    self.backgroundColor = [SKColor purpleColor];
    
    SKLabelNode *label = [[SKLabelNode alloc] init];
    label.text = @"Resources will go here";
    label.fontSize = 42;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    
    [self addChild:label];
    
    return self;
}

@end
