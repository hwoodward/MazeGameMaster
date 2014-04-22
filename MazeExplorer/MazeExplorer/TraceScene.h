//
//  TraceScene.h
//  MazeExplorer
//
//  Created by CS121 on 4/17/14.
//
//

#import <SpriteKit/SpriteKit.h>
#import "Obstacle.h"

@interface TraceScene : SKScene <Obstacle>

@property id <ObstacleSceneDelegate> delegate;

@end
