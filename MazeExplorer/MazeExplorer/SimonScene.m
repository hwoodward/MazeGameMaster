//
//  SimonScene.m
//  MazeExplorer
//
//  Created by Marjorie Principato (based on code written by Emily Stansbury) on 4/3/14.
//
//

#import "SimonScene.h"

@interface SimonScene ()

@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) SKSpriteNode *checkNode;

@property (nonatomic) NSMutableArray *userarray;
@property (nonatomic) NSMutableArray *comparray;
@property (nonatomic) NSInteger currentlength;
@property (nonatomic) NSInteger touchcount;
@property (nonatomic) NSInteger currentpos;
@property (nonatomic) NSInteger winLength;
@property float buttonWidth;

@end

@implementation SimonScene

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    _buttonWidth = 100;
    _winLength = 7;
    _comparray = [[NSMutableArray alloc] init];
    _userarray = [[NSMutableArray alloc] init];
    _currentlength = 0;
    
    self.backgroundColor = [SKColor whiteColor];
    
    CGSize buttonSize = CGSizeMake(_buttonWidth, _buttonWidth);
    
    //Creating the label node that you click to start the game.
    SKLabelNode *label = [[SKLabelNode alloc] init];
    label.text = @"Let's play Simon! Click here to start!";
    label.fontSize = 27;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-150);
    label.fontColor = [SKColor blackColor];
    label.name = @"clickToStart";
    [self addChild:label];
    
    SKLabelNode *instructions = [[SKLabelNode alloc] init];
    instructions.text = @"This is Simon, click the buttons in the order they wiggle.";
    instructions.fontSize = 30;
    instructions.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-75);
    instructions.fontColor = [SKColor blackColor];
    instructions.name = @"instructions";
    [self addChild:instructions];
    
    // Creating the red Simon button
    SKSpriteNode *redNode = [[SKSpriteNode alloc] initWithColor: [SKColor redColor] size:buttonSize];
    redNode.position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)+100);
    redNode.name = @"redButton";
    [self addChild:redNode];
    
    // Creating the blue Simon button
    SKSpriteNode *blueNode = [[SKSpriteNode alloc] initWithColor: [SKColor blueColor] size:buttonSize];
    blueNode.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)+100);
    blueNode.name = @"blueButton";
    [self addChild:blueNode];

    // Creating the yellow Simon button
    SKSpriteNode *yellowNode = [[SKSpriteNode alloc] initWithColor: [SKColor yellowColor] size:buttonSize];
    yellowNode.position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)-100);
    yellowNode.name = @"yellowButton";
    [self addChild:yellowNode];

    // Creating the green Simon button
    SKSpriteNode *greenNode = [[SKSpriteNode alloc] initWithColor: [SKColor colorWithRed:0.0 green:.7 blue:0.05 alpha:1.0]
                                                             size:buttonSize];
    greenNode.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)-100);
    greenNode.name = @"greenButton";
    [self addChild:greenNode];
    
    return self;
}

//Running the Simon game (i.e. combining user and computer interaction for a certain number of turns)
-(void)runSimon
{

    NSInteger element;

    if (_currentlength < _winLength){
        
        //Add another element to the end of the computer's sequence
        _currentlength++;
        element = [self randomNumberBetweenMin:1 andMax:5];
        [_comparray addObject: [NSNumber numberWithInteger: element]];

        //show the user the sequence
        [self displayCompArray];
        
    }
    
    else {
        [self winSimon];
    }
}

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}

-(void) displayCompArray {
    SKNode *currentNode;
    CGPoint position;
    
    //Taken from the iOS developer library SpriteKit Programmer's Guide (with changes)
    SKAction *indicate = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-10.0f) duration:.5],
                                              [SKAction rotateByAngle:degToRad(20.0f) duration:1],
                                              [SKAction rotateByAngle:degToRad(-10.0f) duration:.5]]];

    //Makes the boxes light up according to the array it is given.
    for (NSInteger i = 0; i < _currentlength; ++i) {
        if ([_comparray[i] intValue] == 1) {
            // Light up the red node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)+100);
            currentNode = [self nodeAtPoint:position];
            [currentNode performSelector:@selector(runAction:) withObject:indicate afterDelay:2*i];
        }
        else if ([_comparray[i] intValue] == 2) {
            // Light up the blue node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)+100);
            currentNode = [self nodeAtPoint:position];
            [currentNode performSelector:@selector(runAction:) withObject:indicate afterDelay:2*i];
        }
        else if ([_comparray[i] intValue] == 3) {
            // Light up the yellow node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)-100);
            currentNode = [self nodeAtPoint:position];
            [currentNode performSelector:@selector(runAction:) withObject:indicate afterDelay:2*i];
        }
        else if ([_comparray[i] intValue] == 4) {
            // Light up the green node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)-100);
            currentNode = [self nodeAtPoint:position];
            [currentNode performSelector:@selector(runAction:) withObject:indicate afterDelay:2*i];
        }
    }
}



// The following method is taken from Ray Wenderlich's procedural level generator.
- (NSInteger) randomNumberBetweenMin:(NSInteger)min andMax:(NSInteger)max
{
    return min + arc4random() % (max - min);
}

// Handles the interactions with the user

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
 	CGPoint location = [touch locationInNode:self];
    
    // Setting the value for each item in the user array.
    NSInteger userVal = 0;
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    //Did you click the start label?
    if ([clickedNode.name isEqualToString:@"clickToStart"]) {
        [clickedNode removeFromParent];
        [self runSimon];
    }
    
    //Did you click the red button?
    else if ([clickedNode.name isEqualToString:@"redButton"]) {
        //Add 1 to the array
        userVal = 1;
        [_userarray insertObject:[NSNumber numberWithInteger: userVal] atIndex:_currentpos];
        _currentpos++;
        [self userArrayIsFull];
    }
    //Did you click the blue button?
    else if ([clickedNode.name isEqualToString:@"blueButton"]) {
        //Add 2 to the array
        userVal = 2;
        [_userarray insertObject:[NSNumber numberWithInteger: userVal] atIndex:_currentpos];
        _currentpos++;
        [self userArrayIsFull];
    }
    //Did you click the yellow button?
    else if ([clickedNode.name isEqualToString:@"yellowButton"]) {
        //Add 3 to the array
        userVal = 3;
        [_userarray insertObject:[NSNumber numberWithInteger: userVal] atIndex:_currentpos];
        _currentpos++;
        [self userArrayIsFull];
    }
    //Did you click the green button?
    else if ([clickedNode.name isEqualToString:@"greenButton"]) {
        //Add 4 to the array
        userVal = 4;
        [_userarray insertObject:[NSNumber numberWithInteger: userVal] atIndex:_currentpos];
        _currentpos++;
        [self userArrayIsFull];
    }
    
}

-(void)userArrayIsFull
{
    //If our current position is one past the end of the array, check to see if the user's string is the same as the computer's string.
    if (((_currentpos) == _currentlength) && (_currentlength > 0)){
        [self checkWasUserCorrect];
    }
}

-(void)checkWasUserCorrect
{
    BOOL failFlag = false;
    // Loop through and see if the arrays are equal
    for (NSInteger i = 0; i < _currentlength; i++) {
        if (_userarray[i] != _comparray[i]) {
            [self userWasNotCorrect];
            failFlag = true;
            break; 
        }
    }
    if (failFlag == false)
    {
        [self userWasCorrect];
        _currentpos = 0;
    }
}

-(void)userWasCorrect
{
    //NSLog(@"You are correct!");
    [self runSimon];
}

-(void)userWasNotCorrect
{
    //NSLog(@"You are not correct!");
    [_delegate obstacleDidFail];
}

-(void)winSimon
{
    [_delegate obstacleDidFinish];
}


@end
