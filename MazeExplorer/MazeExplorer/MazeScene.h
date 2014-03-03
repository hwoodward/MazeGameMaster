//
//  MazeScene.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/23/14.
//
//

#import <SpriteKit/SpriteKit.h>
#import "ObstacleScene.h"


@protocol MazeSceneDelegate

// This is where the talking methods should go for MazeScene/ResourceScene
// They will be sent to MyScene, which will pass along the information to ResourceScene

@end

@interface MazeScene : SKScene <ObstacleSceneDelegate>

@property (nonatomic) id <MazeSceneDelegate> delegate;

-(void) obstacleDidFinish;

@end
