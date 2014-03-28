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

@protocol ResourceSceneDelegate

// This is where the talking methods should go for MazeScene/ResourceScene
// They will be sent to MyScene, which will pass along the information to MazeScene

-(void) useResource;

@end

@interface ResourceScene : SKScene

@property (nonatomic) id <ResourceSceneDelegate> delegate;
@property (nonatomic) int resourceCounter;
@property (nonatomic) SKLabelNode *instr;
@property (nonatomic) SKLabelNode *label;


-(void) increaseCounterByOne;

@end
