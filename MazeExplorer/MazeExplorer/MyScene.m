//
//  MyScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MyScene.h"
#import "Maze.h"
#import "MazeScene.h"


@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    }
    
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    SKTransition *transition = [SKTransition flipVerticalWithDuration:.5];
    SKScene *mazeScene = [[MazeScene alloc] initWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height - 50)];
    [self.view presentScene:mazeScene transition:transition];
    
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}



@end
