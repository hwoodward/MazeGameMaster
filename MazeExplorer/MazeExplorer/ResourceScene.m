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
    
    _magicCounter = 0;
    _notepadCounter = 0;
    self.backgroundColor = [SKColor purpleColor];

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
    //magic resource
    SKSpriteNode *magicButton = [[SKSpriteNode alloc] initWithImageNamed:@"magic.png"];
    magicButton.position = CGPointMake(CGRectGetMidX(self.frame)-150,CGRectGetMidY(self.frame)+20);
    magicButton.name = @"magic";
    [self addChild:magicButton];
    _magicLabel = [[SKLabelNode alloc] init];
    _magicLabel.text = [NSString stringWithFormat:@"%i",_magicCounter];
    _magicLabel.fontSize = 25;
    _magicLabel.position = CGPointMake(CGRectGetMidX(self.frame)-150,CGRectGetMidY(self.frame)-60);
    [self addChild:_magicLabel];
    
    //notepad resource
    SKSpriteNode *notepadButton = [[SKSpriteNode alloc] initWithImageNamed:@"Notepad.png"];
    notepadButton.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)+20);
    notepadButton.name = @"notepad";
    [self addChild:notepadButton];
    _notepadLabel = [[SKLabelNode alloc] init];
    _notepadLabel.text = [NSString stringWithFormat:@"%i",_notepadCounter];
    _notepadLabel.fontSize = 25;
    _notepadLabel.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-60);
    [self addChild:_notepadLabel];
    
    //potion resource
    SKSpriteNode *potionButton = [[SKSpriteNode alloc] initWithImageNamed:@"potion.png"];
    potionButton.position = CGPointMake(CGRectGetMidX(self.frame)+150,CGRectGetMidY(self.frame)+20);
    potionButton.name = @"potion";
    [self addChild:potionButton];
    _potionLabel = [[SKLabelNode alloc] init];
    _potionLabel.text = [NSString stringWithFormat:@"%i",_potionCounter];
    _potionLabel.fontSize = 25;
    _potionLabel.position = CGPointMake(CGRectGetMidX(self.frame)+150,CGRectGetMidY(self.frame)-60);
    [self addChild:_potionLabel];
    
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
        case Potion:{
            _potionCounter++;
            _potionLabel.text = [NSString stringWithFormat:@"%i",_potionCounter];
            break;
        }
        default: {//Default is magic and handles that case
            ++_magicCounter;
            _magicLabel.text = [NSString stringWithFormat:@"%i",_magicCounter];
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
        case Potion:{
            _potionCounter--;
            _potionLabel.text = [NSString stringWithFormat:@"%i",_potionCounter];
            break;
        }
        default: {//Default is magic and handles that case
            --_magicCounter;
            _magicLabel.text = [NSString stringWithFormat:@"%i",_magicCounter];
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
    
    if ([clickedNode.name isEqualToString:@"magic"]) {
        if (_magicCounter > 0){
            [self useResource:Magic];
        }
    }
    if ([clickedNode.name isEqualToString:@"notepad"]) {
        if (_notepadCounter > 0){
            [self useResource:Notepad];
        }
    }
    if ([clickedNode.name isEqualToString:@"potion"]) {
        if (_potionCounter > 0){
            [self useResource:Potion];
        }
    }
    
}

-(void)useResourceConfirmed:(ResourceType) type
{
    [self decreaseCounterByOne:(ResourceType) type];
}

@end
