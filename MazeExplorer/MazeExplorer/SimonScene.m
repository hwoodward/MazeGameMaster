//
//  SimonScene.m
//  MazeExplorer
//
//  Created by Marjorie Principato (based on code written by Emily Stansbury) on 4/3/14.
//
//

#import "SimonScene.h"

@implementation SimonScene

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    _buttonWidth = 100;
    
    self.backgroundColor = [SKColor whiteColor];
    
    CGSize buttonSize = CGSizeMake(_buttonWidth, _buttonWidth);
    
    //Creating the label node that you click to start the game.
    SKLabelNode *label = [[SKLabelNode alloc] init];
    label.text = @"Let's play Simon! Click here to start!";
    label.fontSize = 27;
    label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)+300);
    label.fontColor = [SKColor blackColor];
    label.name = @"clickToStart";
    [self addChild:label];
    
    //Creating the label node that you click to end the game prematurely.
    SKLabelNode *debuglabel = [[SKLabelNode alloc] init];
    debuglabel.text = @"Click to close Simon.";
    debuglabel.fontSize = 27;
    debuglabel.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)+250);
    debuglabel.fontColor = [SKColor blackColor];
    debuglabel.name = @"debugLabel";
    [self addChild:debuglabel];
    
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
    SKSpriteNode *greenNode = [[SKSpriteNode alloc] initWithColor: [SKColor greenColor] size:buttonSize];
    greenNode.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)-100);
    greenNode.name = @"greenButton";
    [self addChild:greenNode];
    
    return self;
}

//Running the Simon game (i.e. combining user and computer interaction for a certain number of turns)
-(void)runSimon
{
    // I may have to worry about it trying to continue running after the player loses, but I hope not.
    /*
    for (NSInteger i=1; i <= turns; ++i) {
        [self runOneSimonTurnWithLength:i];
    }
     */
    [self runOneSimonTurnWithLength: 3];
    
}

-(void)runOneSimonTurnWithLength: (NSInteger) length
{
    //Create a new computer array; clears out player's arrays
    [self generateSimonArrayOfLength:length];
    [SKAction waitForDuration:5];
    
    //What is my current position in the _userarray (used by touchesbegan)?
    _currentpos = 0;
    
    SKNode *currentNode;
    CGPoint position;
    
    //Taken from the iOS developer library SpriteKit Programmer's Guide (with changes)
    SKAction *pulsePurple = [SKAction sequence:@[
                                              [SKAction colorizeWithColor:[SKColor purpleColor] colorBlendFactor:1.0 duration:0.15],
                                              [SKAction waitForDuration:0.5],
                                              [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];
    
    //Makes the boxes light up according to the array it is given.
    for (NSInteger i = 0; i < _currentlength; ++i) {
        if (_comparray[i] == 1) {
            // Light up the red node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)+100);
            currentNode = [self nodeAtPoint:position];
            [currentNode runAction:pulsePurple];
            NSLog(@"The red node should pulse.");
        }
        else if (_comparray[i] == 2) {
            // Light up the blue node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)+100);
            currentNode = [self nodeAtPoint:position];
            [currentNode runAction:pulsePurple];
            NSLog(@"The blue node should pulse.");
        }
        else if (_comparray[i] == 3) {
            // Light up the yellow node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)-100);
            currentNode = [self nodeAtPoint:position];
            [currentNode runAction:pulsePurple];
            NSLog(@"The yellow node should pulse.");
        }
        else if (_comparray[i] == 4) {
            // Light up the green node
            // Wait
            position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)-100);
            currentNode = [self nodeAtPoint:position];
            [currentNode runAction:pulsePurple];
            NSLog(@"The green node should pulse.");
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
    NSLog(@"GenerateSimonArrayofLength was called.");
    NSInteger array1[length];
    NSInteger array2[length];
    // Making sure the user input array is the same length as the computer's array.
    _comparray = array1;
    _userarray = array2;
    _currentlength = length;
    
    NSInteger element;
    for (NSInteger i=0; i < length; ++i) {
        element = [self randomNumberBetweenMin:1 andMax:5];
        _comparray[i] = element;
    }
    NSLog(@"_comparray is:");
    for (NSInteger i=0; i < length; ++i) {
        NSLog(@"%i", _comparray[i]);
    }
}

// Handles the interactions with the user

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
 	CGPoint location = [touch locationInNode:self];
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    //Did you click the start label?
    if ([clickedNode.name isEqualToString:@"clickToStart"]) {
        NSLog(@"You clicked the start label!");
        [clickedNode removeFromParent];
        [self runSimon];
    }
    //Did you click the debug label?
    else if ([clickedNode.name isEqualToString:@"debugLabel"]) {
        [self userWasNotCorrect];
        NSLog(@"You clicked the debug label!");
    }
    
    //Did you click the red button?
    else if ([clickedNode.name isEqualToString:@"redButton"]) {
        //Add 1 to the array
        _userarray[_currentpos] = 1;
        _currentpos = _currentpos + 1;
        [self userArrayIsFull];
        NSLog(@"You clicked the red button.");
    }
    //Did you click the blue button?
    else if ([clickedNode.name isEqualToString:@"blueButton"]) {
        //Add 2 to the array
        _userarray[_currentpos] = 2;
        _currentpos = _currentpos + 1;
        [self userArrayIsFull];
        NSLog(@"You clicked the blue button.");
    }
    //Did you click the yellow button?
    else if ([clickedNode.name isEqualToString:@"yellowButton"]) {
        //Add 3 to the array
        _userarray[_currentpos] = 3;
        _currentpos = _currentpos + 1;
        [self userArrayIsFull];
        NSLog(@"You clicked the yellow button.");
    }
    //Did you click the green button?
    else if ([clickedNode.name isEqualToString:@"greenButton"]) {
        //Add 4 to the array
        _userarray[_currentpos] = 4;
        _currentpos = _currentpos + 1;
        [self userArrayIsFull];
        NSLog(@"You clicked the green button.");
    }
    
}

-(void)userArrayIsFull
{
    //If our current position is one past the end of the array, check to see if the user's string is the same as the computer's string.
    if (((_currentpos) == _currentlength) && (_currentlength > 0)){
        NSLog(@"The _userarray is full! The _userarray is:");
        for (NSInteger i = 0; i < _currentlength; ++i) {
            NSLog(@"%i", _userarray[i]);
        }
        
        [self checkWasUserCorrect];
    }
    else{
        NSLog(@"The userarray is either not full or too full!");
        NSLog(@"currentpos is: %i", _currentpos);
        NSLog(@"currentlength is: %i", _currentlength);
    }
}

-(void)checkWasUserCorrect
{
    // Loop through and see if the arrays are equal
    for (NSInteger i = 0; i < _currentlength; i++) {
        if (_userarray[i] != _comparray[i]) {
            [self userWasNotCorrect];
        }
    }
    [self userWasCorrect];
}

-(void)userWasCorrect
{
    // For now, only handles one turn.
    NSLog(@"You are correct!");
    [self winSimon];
}

-(void)userWasNotCorrect
{
    NSLog(@"You are not correct!");
    [_delegate obstacleDidFail];
}

-(void)winSimon
{
    [_delegate obstacleDidFinish];
}


@end
