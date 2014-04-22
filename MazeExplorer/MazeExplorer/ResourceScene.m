//
//  ResourceScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 3/1/14.
//
//

#import "ResourceScene.h"

@interface ResourceScene ()

@property (nonatomic) int magicCounter;
@property (nonatomic) int notepadCounter;
@property (nonatomic) int potionCounter;
@property (nonatomic) int wingCounter;
@property (nonatomic) SKLabelNode *instr1;
@property (nonatomic) SKLabelNode *magicLabel;
@property (nonatomic) SKLabelNode *notepadLabel;
@property (nonatomic) SKLabelNode *potionLabel;
@property (nonatomic) SKLabelNode *wingLabel;
@property (nonatomic) SKLabelNode *instr2;


@end

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
    CGFloat magicX = CGRectGetMaxX(self.frame)*(2.0/9.0);
    magicButton.position = CGPointMake(magicX,CGRectGetMidY(self.frame)+20);
    magicButton.name = @"magic";
    [self addChild:magicButton];
    _magicLabel = [[SKLabelNode alloc] init];
    _magicLabel.text = [NSString stringWithFormat:@"%i",_magicCounter];
    _magicLabel.fontSize = 25;
    _magicLabel.position = CGPointMake(magicX,CGRectGetMidY(self.frame)-60);
    [self addChild:_magicLabel];
    
    //notepad resource
    SKSpriteNode *notepadButton = [[SKSpriteNode alloc] initWithImageNamed:@"Notepad.png"];
    CGFloat notepadX = CGRectGetMaxX(self.frame)*(5.0/9.0)*(1/3.0) + magicX;
    notepadButton.position = CGPointMake(notepadX,CGRectGetMidY(self.frame)+20);
    notepadButton.name = @"notepad";
    [self addChild:notepadButton];
    _notepadLabel = [[SKLabelNode alloc] init];
    _notepadLabel.text = [NSString stringWithFormat:@"%i",_notepadCounter];
    _notepadLabel.fontSize = 25;
    _notepadLabel.position = CGPointMake(notepadX,CGRectGetMidY(self.frame)-60);
    [self addChild:_notepadLabel];
    
    //potion resource
    SKSpriteNode *potionButton = [[SKSpriteNode alloc] initWithImageNamed:@"potion.png"];
    CGFloat potionX = CGRectGetMaxX(self.frame)*(5.0/9.0)*(2/3.0) + magicX;
    potionButton.position = CGPointMake(potionX,CGRectGetMidY(self.frame)+20);
    potionButton.name = @"potion";
    [self addChild:potionButton];
    _potionLabel = [[SKLabelNode alloc] init];
    _potionLabel.text = [NSString stringWithFormat:@"%i",_potionCounter];
    _potionLabel.fontSize = 25;
    _potionLabel.position = CGPointMake(potionX,CGRectGetMidY(self.frame)-60);
    [self addChild:_potionLabel];
    
    //wing resource
    SKSpriteNode *wingButton = [[SKSpriteNode alloc] initWithImageNamed:@"bricktexture.jpg"];
    CGFloat wingX = CGRectGetMaxX(self.frame)*(7.0/9.0);
    wingButton.position = CGPointMake(wingX,CGRectGetMidY(self.frame)+20);
    wingButton.name = @"wing";
    [self addChild:wingButton];
    _wingLabel = [[SKLabelNode alloc] init];
    _wingLabel.text = [NSString stringWithFormat:@"%i",_wingCounter];
    _wingLabel.fontSize = 25;
    _wingLabel.position = CGPointMake(wingX,CGRectGetMidY(self.frame)-60);
    [self addChild:_wingLabel];
    
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
        case Wing:{
            _wingCounter++;
            _wingLabel.text = [NSString stringWithFormat:@"%i",_wingCounter];
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
    if ([clickedNode.name isEqualToString:@"wing"]) {
        if (_wingCounter > 0){
            [self useResource:Wing];
        }
    }
    
}

-(void)useResourceConfirmed:(ResourceType) type
{
    [self decreaseCounterByOne:(ResourceType) type];
}

@end
