//
//  ResourceScene.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 3/1/14.
//
//
/* The ResourceScene is responsible for creating, displaying, and handleing user interaction with resources.
 * To do this it needs to create resources when informed that hey were encountered by the player.
 * It also needs to pass on the information that a resource has been used when one is used along with removing it.
 */

#import <SpriteKit/SpriteKit.h>
#import "typedef.h"

@protocol ResourceSceneDelegate

// This is where the talking methods should go for MazeScene/ResourceScene
// They will be sent to MyScene, which will pass along the information to MazeScene

-(void) useResource:(ResourceType) type;

@end

@interface ResourceScene : SKScene

@property (nonatomic) id <ResourceSceneDelegate> delegate;
@property (nonatomic) int magicCounter;
@property (nonatomic) int notepadCounter;
@property (nonatomic) int potionCounter;
@property (nonatomic) SKLabelNode *instr1;
@property (nonatomic) SKLabelNode *magicLabel;
@property (nonatomic) SKLabelNode *notepadLabel;
@property (nonatomic) SKLabelNode *potionLabel;
@property (nonatomic) SKLabelNode *instr2;


-(void) increaseCounterByOne:(ResourceType)type;
-(void) useResourceConfirmed:(ResourceType) type;

@end
