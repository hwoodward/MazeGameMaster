//
//  CatapultScene.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 4/28/14.
//
//

#import <SpriteKit/SpriteKit.h>
#import "Obstacle.h"

@interface CatapultScene : SKScene <SKPhysicsContactDelegate, Obstacle>

@property id <ObstacleSceneDelegate> delegate;

@end
