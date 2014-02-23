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
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) Maze* maze;


@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
        [self mazeSetUp];
        [self addPlayer];
    }
    
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    NSArray *cells = [self children];
    SKAction *moveDown = [SKAction moveByX:0.0 y:-_cellWidth duration:1.0];
    SKAction *moveUp = [SKAction moveByX:0.0 y:_cellWidth duration:1.0];
    for (int i = 0; i< [cells count]; i++) {
        SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
        [cell runAction:moveDown];
    }
    [_player runAction: moveUp];
    
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)mazeSetUp
{
    _maze = [[Maze alloc]
                        initMazeWithString:@"*E*********  *     **      *******     **     *  ** *   * *** *  *   ****  *  ***    *   ***S*******"
                        andWidth:10];
    [_maze printMaze];
    
    _cellWidth = fmin(self.frame.size.width / [_maze numCols],
                          self.frame.size.height / [_maze numRows]);
    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
    for (int i = 0; i < [_maze numCols]; i++)
    {
        for (int j = 0; j < [_maze numRows]; j++)
        {
            SKColor *cellColor = [SKColor blackColor];
            if ([_maze isWallCellWithRow:j andColumn:i]) {
                SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: cellColor size:cellSize];
                cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                self.frame.size.height - _cellWidth*j - _cellWidth/2);
                
                [self addChild:cellNode];
            }
        }
    }
    CGPoint start = [_maze startLoc];
    SKSpriteNode *startNode = [[SKSpriteNode alloc] initWithColor:[SKColor cyanColor] size:cellSize];
    startNode.position = CGPointMake(_cellWidth*start.x + (_cellWidth/2),
                                     self.frame.size.height - _cellWidth*start.y - _cellWidth/2);
    [self addChild:startNode];
    CGPoint end = [_maze endLoc];
    SKSpriteNode *endNode = [[SKSpriteNode alloc] initWithColor:[SKColor magentaColor] size:cellSize];
    endNode.position = CGPointMake(_cellWidth*end.x + (_cellWidth/2),
                                     self.frame.size.height - _cellWidth*end.y - _cellWidth/2);
    [self addChild:endNode];
}

-(void)addPlayer
{
    _player = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake(_cellWidth-20, _cellWidth-20)];
    float playerX = (_maze.numCols*_cellWidth)/2;
    float playerY = self.frame.size.height - ((_maze.numRows*_cellWidth)/2);
    _player.position = CGPointMake(playerX, playerY); //Will change later
    [self addChild:_player];
}


@end
