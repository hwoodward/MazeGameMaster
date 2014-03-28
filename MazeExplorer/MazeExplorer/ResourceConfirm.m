//
//  ResourceConfirm.m
//  MazeExplorer
//
//  Created by CS121 on 3/27/14.
//
//

#import "ResourceConfirm.h"

@implementation ResourceConfirm

-(id) initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    self.backgroundColor = [SKColor blueColor];
    
    _label = [[SKLabelNode alloc] init];
    _label.text = @"Do you want to use this resource?";
    _label.fontSize = 42;
    _label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    
    [self addChild:_label];
    
    return self;
}


@end
