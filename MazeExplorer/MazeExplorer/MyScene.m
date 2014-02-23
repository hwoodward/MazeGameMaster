//
//  MyScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MyScene.h"
#import "Maze.h"

@interface MyScene () <UIGestureRecognizerDelegate>

@property (nonatomic) UISwipeGestureRecognizer* swipeGR;
@property float cellWidth;

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
        [self mazeSetUp];
    }
    
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    NSArray *cells = [self children];
    SKAction *move = [SKAction moveByX:0.0 y:-_cellWidth duration:1.0];
    for (int i = 0; i< [cells count]; i++) {
        SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
        [cell runAction:move];
    }
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)mazeSetUp
{
    Maze* stringMaze = [[Maze alloc]
                        initMazeWithString:@"***********  *     **      *******     **     *  ** *   * *** *  *   ****  *  ***    *   ***********"
                        andWidth:10];
    [stringMaze printMaze];
    
    _cellWidth = fmin(self.frame.size.width / [stringMaze numCols],
                          self.frame.size.height / [stringMaze numRows]);
    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
    for (int i = 0; i < [stringMaze numCols]; i++)
    {
        for (int j = 0; j < [stringMaze numRows]; j++)
        {
            SKColor *cellColor;
            if ([stringMaze isWallCellWithRow:j andColumn:i]) {
                cellColor = [SKColor blackColor];
                SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: cellColor size:cellSize];
                cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                self.frame.size.height - _cellWidth*j - _cellWidth/2);
                
                [self addChild:cellNode];
            }
        }
    }
}


@end
