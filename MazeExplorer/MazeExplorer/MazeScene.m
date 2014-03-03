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
//Gesture recognizer is currently broken
@property (nonatomic) UISwipeGestureRecognizer* swipeGR;
@property float cellWidth;
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) Maze* maze;

@property CGPoint playerLoc;
//@property CGPoint startLoc;
@property CGPoint endLoc;
@property CGPoint obstLoc;

@end

/* 
 * Constant: CELLNUM
 * Gives the length of the side of the square of the maze that will be displayed.
 */
static const int CELLNUM = 11;

@implementation MazeScene

/*
 * Method: initWithSize:
 *
 * This initializes itself, sets the background to white,
 * and calls methods to initialize the maze and player.
 */
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

/*
 * Method: update:
 * 
 * Currently an auto-generated stub.
 */
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

/*
 * Method: mazeSetup
 *
 * This method string initializes a maze (currently a hardcoded maze. Should select appropriate,
 * randomish string in the future). It then reads the maze, creating SKSpriteNodes for all of the
 * walls. It then calls startAndEndInitialization to finish setting up the maze.
 */
- (void)mazeSetUp
{
    _maze = [[Maze alloc]
             initMazeWithString:@"*E*********  *     **      *******     **     *  ** O   * *** *  *   ****  *  ***    *   ***S*******"
             andWidth:10];
    [_maze printMaze];
    
    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
    for (int i = 0; i < [_maze numCols]; i++)
    {
        for (int j = 0; j < [_maze numRows]; j++)
        {
            NSString *cont = [_maze getContentsWithRow:j andColumn:i];
            if (![cont compare:@"*"]) {
                SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: [SKColor blackColor] size:cellSize];
                cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                self.frame.size.height - _cellWidth*j - _cellWidth/2);
                
                [self addChild:cellNode];
            } else if (![cont compare:@"O"]) {
                SKSpriteNode *cellNode = [[SKSpriteNode alloc] initWithColor: [SKColor brownColor] size:cellSize];
                cellNode.position = CGPointMake(_cellWidth*i + (_cellWidth/2),
                                                self.frame.size.height - _cellWidth*j - _cellWidth/2);
                
                [self addChild:cellNode];
            }
            
        }
    }
    [self startAndEndInitialization];
}

/*
 * Method: startAndEndInitialization
 *
 * This method specially goes and finds the start and end of the maze, and colors them 
 * differently than the rest of the maze. It then shifts all of the cells so that the
 * start will be centered underneath the player.
 */
- (void)startAndEndInitialization
{
    CGSize cellSize = CGSizeMake(_cellWidth, _cellWidth);
    CGPoint start = [_maze startLoc];
    SKSpriteNode *startNode = [[SKSpriteNode alloc] initWithColor:[SKColor cyanColor] size:cellSize];
    startNode.position = CGPointMake(_cellWidth*start.x + (_cellWidth/2),
                                     self.frame.size.height - _cellWidth*start.y - _cellWidth/2);
    _playerLoc = start;
    [self addChild:startNode];
    
    _endLoc = [_maze endLoc];
    SKSpriteNode *endNode = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:cellSize];
    endNode.position = CGPointMake(_cellWidth*_endLoc.x + (_cellWidth/2),
                                   self.frame.size.height - _cellWidth*_endLoc.y - _cellWidth/2);
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

/*
 * Method: addPlayer
 *
 * This adds the player as an SKSpriteNode to the middle of the area designated for the maze.
 * It should end up right over the start of the maze.
 */
-(void)addPlayer
{
    _player = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake(_cellWidth-20, _cellWidth-20)];
    float playerX = (CELLNUM*_cellWidth)/2;
    float playerY = self.frame.size.height - ((CELLNUM*_cellWidth)/2);
    _player.position = CGPointMake(playerX, playerY); //Will change later
    [self addChild:_player];
}

/*
 * Method: isNode
 *
 * Takes in a direction relative to the player and the player's location.
 * Returns a boolean saying if there's another node in that direction.
 *
 */

-(bool)isNode: (NSString*)relativeDirection withPoint:(CGPoint*) playerPoint
{
    CGPoint pointToCompare;
    SKNode* returnedNode;
    // Tests to see if there's a node north of you.
    if ([relativeDirection isEqualToString:@"north"]){
        pointToCompare.x = playerPoint->x;
        pointToCompare.y = playerPoint->y-1;
        
        returnedNode = [self nodeAtPoint:pointToCompare];
    }
    // Tests to see if there's a node south of you.
    else if ([relativeDirection isEqualToString:@"south"]){
        pointToCompare.x = playerPoint->x;
        pointToCompare.y = playerPoint->y+1;
        
        returnedNode = [self nodeAtPoint:pointToCompare];
    }
    // Tests to see if there's a node east of you.
    else if ([relativeDirection isEqualToString:@"east"]){
        pointToCompare.x = playerPoint->x+1;
        pointToCompare.y = playerPoint->y;
        
        returnedNode = [self nodeAtPoint:pointToCompare];
    }
    // Tests to see if there's a node west of you.
    else if ([relativeDirection isEqualToString:@"west"]){
        pointToCompare.x = playerPoint->x-1;
        pointToCompare.y = playerPoint->y;
        
        returnedNode = [self nodeAtPoint:pointToCompare];
    }
    
    //nodeAtPoint returns the node it was called on if there's no node at the point.
    if (returnedNode == self){
        return false;
    }
    else
    {
        return true;
    }
}

/*
 * Method: touchesBegan: withEvent:
 *
 * Currently commented out. This will just shift the maze down, leaving the 
 * player in the same place. It was a prrof of concept, and will be properly 
 * implemented/replaced as soon as possible. 
 */
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

/*
 Method: touchesBegan: Allows the player to move up, down, left, and right 
 in the maze. Shifts the maze appropriately.
 */

//Attempting to make a version of this that responds to up, down, left, right touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint fingerpos = [[touches anyObject] locationInView:self.view];
    
    NSLog(@"%@", NSStringFromCGPoint(fingerpos));
    
    // I'm sorry, there's a simpler way to get the midpoint,
    // and it works with or without the resource panel. -E
    float xMidpoint = self.view.frame.size.width/2;
    float yMidpoint = self.view.frame.size.height/2;
    
    //float xMidpoint = 400;
    //float yMidpoint = 400;
    
    //The farthest point I've been able to touch: {760, 996}
    
    //The midpoint on the left: {6, 444}
    //The midpoint on the right: {763, 509}
    //The midpoint on top: {384, 23}
    //The midpoint on the bottom: {397, 1008}
    
    //So, the x midpoint is about 400, and the y midpoint is about 500.
    //The origin is at the top-left-hand corner. Y'know, because that makes sense.
    
    //For now, I'll ignore the fact that we'll theoretically have an inventory panel at the bottom.
    
    NSArray *cells = [self children];
    SKAction *moveDown = [SKAction moveByX:0.0 y:-_cellWidth duration:1.0];
    SKAction *moveUp = [SKAction moveByX:0.0 y:_cellWidth duration:1.0];
    SKAction *moveLeft = [SKAction moveByX:-_cellWidth y:0.0 duration:1.0];
    SKAction *moveRight = [SKAction moveByX:_cellWidth y:0.0 duration:1.0];
    
    //Going up:
    if (fingerpos.y < yMidpoint-100 && fingerpos.x > xMidpoint-100 && fingerpos.x < xMidpoint+100){
        
        _playerLoc.y--;
        NSString *cont = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
        if (![cont compare:@"O"]) {
            NSLog(@"Obstacle!!");
        }
        for (int i = 0; i< [cells count]; i++) {
            SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
            [cell runAction:moveDown];
        }
        
        [_player runAction: moveUp];
    }
    
    //Going down:
    else if (fingerpos.y > yMidpoint+100 && fingerpos.x > xMidpoint-100 && fingerpos.x < xMidpoint+100){
        
        _playerLoc.y++;
        NSString *cont = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
        if (![cont compare:@"O"]) {
            NSLog(@"Obstacle!!");
        }
        for (int i = 0; i< [cells count]; i++) {
            SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
            [cell runAction:moveUp];
        }
        [_player runAction: moveDown];
       
    }
    
    //Going left:
    else if (fingerpos.x < xMidpoint-100 && fingerpos.y > yMidpoint-100 && fingerpos.y < yMidpoint+100){
        
        _playerLoc.x--;
        NSString *cont = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
        if (![cont compare:@"O"]) {
            NSLog(@"Obstacle!!");
        }
        for (int i = 0; i< [cells count]; i++) {
            SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
            [cell runAction:moveRight];
        }
        [_player runAction: moveLeft];
    }
    
    //Going right:
    else if (fingerpos.x > xMidpoint+100 && fingerpos.y > yMidpoint-100 && fingerpos.y < yMidpoint+100){
        
        _playerLoc.x++;
        NSString *cont = [_maze getContentsWithRow:_playerLoc.y andColumn:_playerLoc.x];
        if (![cont compare:@"O"]) {
            NSLog(@"Obstacle!!");
        }
        for (int i = 0; i< [cells count]; i++) {
            SKSpriteNode *cell = (SKSpriteNode *)[cells objectAtIndex:i];
            [cell runAction:moveLeft];
        }
        [_player runAction: moveRight];
    }
    
}


@end
