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
    
    self.resourceCounter = 0;
    
    self.backgroundColor = [SKColor purpleColor];
    
    _label = [[SKLabelNode alloc] init];
    _label.text = [NSString stringWithFormat:@"Resource Counter: %i", 0];
    _label.fontSize = 42;
    _label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    
    [self addChild:_label];
    
    return self;
}

-(void) increaseCounterByOne
{
    ++self.resourceCounter;
    NSLog(@"The resource counter is now: %i", self.resourceCounter);
    _label.text = [NSString stringWithFormat:@"Resource Counter: %i", self.resourceCounter];
}

@end
