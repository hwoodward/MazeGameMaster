//
//  MazeScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/23/14.
//
//

#import "MazeScene.h"
#import "Maze.h"

@interface MazeScene ()

@property (nonatomic) UISwipeGestureRecognizer* swipeGR;
@property float cellWidth;
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) Maze* maze;

@end

static const int CELLNUM = 11;

@implementation MazeScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _cellWidth = self.frame.size.width/CELLNUM;
        
        [self mazeSetUp];
        [self addPlayer];
    }
    
    return self;
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
    [self startAndEndInitialization];
}

- (void)startAndEndInitialization
{
    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
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
    
    int xDiff = (CELLNUM/2) - start.x;
    int yDiff = start.y - (CELLNUM/2);
    NSArray *cells = [self children];
    SKAction *move = [SKAction moveByX:_cellWidth*xDiff y:_cellWidth*yDiff duration:0.0];
    for (int i = 0; i < [cells count]; i++) {
        SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
        [cell runAction:move];
    }
}

-(void)addPlayer
{
    _player = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake(_cellWidth-20, _cellWidth-20)];
    float playerX = (CELLNUM*_cellWidth)/2;
    float playerY = self.frame.size.height - ((CELLNUM*_cellWidth)/2);
    _player.position = CGPointMake(playerX, playerY); //Will change later
    [self addChild:_player];
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
//    NSArray *cells = [self children];
//    SKAction *moveDown = [SKAction moveByX:0.0 y:-_cellWidth duration:1.0];
//    SKAction *moveUp = [SKAction moveByX:0.0 y:_cellWidth duration:1.0];
//    for (int i = 0; i< [cells count]; i++) {
//        SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
//        [cell runAction:moveDown];
//    }
//    [_player runAction: moveUp];
//    
//}



@end
