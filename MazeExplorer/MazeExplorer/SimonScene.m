//
//  SimonScene.m
//  MazeExplorer
//
//  Created by Marjorie Principato (based on code written by Emily Stansbury) on 4/3/14.
//
//

#import "SimonScene.h"

@implementation SimonScene

static const uint32_t targetCategory     =  0x1 << 0;
static const uint32_t outlineCategory    =  0x1 << 1;
static const uint32_t movableCategory    =  0x1 << 2;

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    
    _buttonWidth = 100;
    
    self.backgroundColor = [SKColor whiteColor];
    
    CGSize buttonSize = CGSizeMake(_buttonWidth, _buttonWidth);
    
    SKLabelNode *label = [[SKLabelNode alloc] init];
    label.text = @"Let's play Simon!.";
    label.fontSize = 27;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-100);
    label.fontColor = [SKColor blackColor];
    [self addChild:label];
    
    SKSpriteNode *redNode = [[SKSpriteNode alloc] initWithColor: [SKColor redColor] size:buttonSize];
    redNode.position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)+200);
    redNode.name = @"redButton";
    [self addChild:redNode];
    
    SKSpriteNode *blueNode = [[SKSpriteNode alloc] initWithColor: [SKColor redColor] size:buttonSize];
    redNode.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)+200);
    redNode.name = @"blueButton";
    [self addChild:blueNode];

    
    SKSpriteNode *yellowNode = [[SKSpriteNode alloc] initWithColor: [SKColor redColor] size:buttonSize];
    redNode.position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)+300);
    redNode.name = @"yellowButton";
    [self addChild:yellowNode];

    
    SKSpriteNode *greenNode = [[SKSpriteNode alloc] initWithColor: [SKColor redColor] size:buttonSize];
    redNode.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)+300);
    redNode.name = @"greenButton";
    [self addChild:greenNode];
    
    return self;
}

//Running the Simon game (i.e. combining user and computer interaction for a certain number of turns)
-(void)runSimonWithNoOfTurns: (NSInteger) turns
{
    
}

-(void)runOneCompSimonTurnWithLength: (NSInteger) length
{
    //Create a new computer array; clears out player's array
    [self generateSimonArrayOfLength:length];
    
    SKNode *currentNode;
    CGPoint position;
    
    //Taken from the iOS developer library SpriteKit Programmer's Guide (with changes)
    SKAction *pulseWhite = [SKAction sequence:@[
                                              [SKAction colorizeWithColor:[SKColor whiteColor] colorBlendFactor:1.0 duration:0.15],
                                              [SKAction waitForDuration:0.1],
                                              [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];
    
    //Makes the boxes light up according to the array it is given.
    for (NSInteger i = 0; i < _currentlength; i++) {
        if (_comparray[i] == 1) {
            // Light up the red node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)+200);
            currentNode = [self nodeAtPoint:position];
            [currentNode runAction:pulseWhite];
        }
        else if (_comparray[i] == 2) {
            // Light up the blue node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)+200);
            currentNode = [self nodeAtPoint:position];
            [currentNode runAction:pulseWhite];
        }
        else if (_comparray[i] == 3) {
            // Light up the yellow node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)+300);
            currentNode = [self nodeAtPoint:position];
            [currentNode runAction:pulseWhite];
        }
        else if (_comparray[i] == 4) {
            // Light up the green node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)+300);
            currentNode = [self nodeAtPoint:position];
            [currentNode runAction:pulseWhite];
        }
    }
}



// The following method is taken from Ray Wenderlich's procedural level generator.
- (NSInteger) randomNumberBetweenMin:(NSInteger)min andMax:(NSInteger)max
{
    return min + arc4random() % (max - min);
}

-(void)generateSimonArrayOfLength: (NSInteger) length
{
    NSInteger array[length];
    // Making sure the user input array is the same length as the computer's array.
    _comparray = array;
    _userarray = array;
    _currentlength = length;
    
    NSInteger element;
    for (NSInteger i=0; i <= length; i++) {
        element = [self randomNumberBetweenMin:0 andMax:4];
        _comparray[i] = element;
    }
    
}

// Handles the interactions with the user

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
 	CGPoint location = [touch locationInNode:self];
    
    //What is my current position in the array?
    NSInteger currentpos = 0;
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    //Did you click the red button?
    if ([clickedNode.name isEqualToString:@"redButton"]) {
        //Add 1 to the array
        _userarray[currentpos] = 1;
        ++currentpos;
    }
    //Did you click the blue button?
    else if ([clickedNode.name isEqualToString:@"blueButton"]) {
        //Add 2 to the array
        _userarray[currentpos] = 2;
        ++currentpos;
    }
    //Did you click the yellow button?
    else if ([clickedNode.name isEqualToString:@"yellowButton"]) {
        //Add 3 to the array
        _userarray[currentpos] = 3;
        ++currentpos;
    }
    //Did you click the green button?
    else if ([clickedNode.name isEqualToString:@"greenButton"]) {
        //Add 4 to the array
        _userarray[currentpos] = 4;
        ++currentpos;
    }
    
    //If our current position is one past the end of the array, check to see if the user's string is the same as the computer's string.
    if (currentpos == _currentlength){
        [self checkWasUserCorrect];
    }
    
    
}

-(bool)checkWasUserCorrect
{
    // Loop through and see if the arrays are equal
    for (NSInteger i = 0; i < _currentlength; i++) {
        if (_userarray[i] != _comparray[i]) {
            return NO;
        }
    }
    return YES;
}

-(void)userWasCorrect
{
    // Win conditions for one turn
}

-(void)userWasNotCorrect
{
    // Lose conditions; Kicks the user out of the game
}

-(void)winSimon
{
    // Overall win conditions for the game of Simon. Should end the game and get rid of the obstacle.
}


@end
