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
    
    _testCounter = 0;
    _notepadCounter = 0;
    self.backgroundColor = [SKColor purpleColor];
/*
    _label = [[SKLabelNode alloc] init];
    _label.text = [NSString stringWithFormat:@"Resource Counter: %i", 0];
    _label.fontSize = 42;
    _label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    
    [self addChild:_label];
*/
    _instr1 = [[SKLabelNode alloc] init];
    _instr1.text = @"The orange boxes are resources. Collect them!";
    _instr1.fontSize = 30;
    _instr1.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-25);
    
    [self addChild:_instr1];
    
    _instr2 = [[SKLabelNode alloc] init];
    _instr2.text = @"Select an image to use that resource.";
    _instr2.fontSize = 30;
    _instr2.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMinY(self.frame)+20);
    
    [self addChild:_instr2];
    
    
    // Adding buttons and counter labels for each resource.
    //Test resource
    SKSpriteNode *testButton = [[SKSpriteNode alloc] initWithImageNamed:@"magic.png"];
    testButton.position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)+20);
    testButton.name = @"test";
    [self addChild:testButton];
    _testLabel = [[SKLabelNode alloc] init];
    _testLabel.text = [NSString stringWithFormat:@"%i",_testCounter];
    _testLabel.fontSize = 25;
    _testLabel.position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)-60);
    [self addChild:_testLabel];
    
    SKSpriteNode *notepadButton = [[SKSpriteNode alloc] initWithImageNamed:@"Notepad.png"];
    notepadButton.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)+20);
    notepadButton.name = @"notepad";
    [self addChild:notepadButton];
    _notepadLabel = [[SKLabelNode alloc] init];
    _notepadLabel.text = [NSString stringWithFormat:@"%i",_notepadCounter];
    _notepadLabel.fontSize = 25;
    _notepadLabel.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)-60);
    [self addChild:_notepadLabel];
    
    return self;
}

-(void) increaseCounterByOne:(ResourceType) type
{
    switch(type) {
        case Notepad:{
            _notepadCounter++;
            _notepadLabel.text = [NSString stringWithFormat:@"%i",_notepadCounter];
            break;
        }
        default: {//Default is test and handles that case
            ++_testCounter;
            _testLabel.text = [NSString stringWithFormat:@"%i",_testCounter];
            break;
        }
    }
}

-(void) decreaseCounterByOne:(ResourceType) type
{
    switch(type) {
        case Notepad:{
            _notepadCounter--;
            _notepadLabel.text = [NSString stringWithFormat:@"%i",_notepadCounter];
            break;
        }
        default: {//Default is test and handles that case
            --_testCounter;
            _testLabel.text = [NSString stringWithFormat:@"%i",_testCounter];
            break;
        }
    }
}

-(void) useResource:(ResourceType) type
{
    [self.delegate useResource:(ResourceType) type];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
 	CGPoint location = [touch locationInNode:self];
    
    //what node am I in?
    SKNode *clickedNode = [self nodeAtPoint:location];
    
    if ([clickedNode.name isEqualToString:@"test"]) {
        if (_testCounter > 0){
            [self useResource:Test];
        }
    }
    if ([clickedNode.name isEqualToString:@"notepad"]) {
        if (_notepadCounter > 0){
            [self useResource:Notepad];
        }
    }
    
}

-(void)useResourceConfirmed:(ResourceType) type
{
    [self decreaseCounterByOne:(ResourceType) type];
}

@end
