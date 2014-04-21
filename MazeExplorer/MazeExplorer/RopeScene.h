//
//  RopeObstacle.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 4/21/14.
//
//

#import <SpriteKit/SpriteKit.h>
#import "Obstacle.h"

@interface RopeScene : SKScene <Obstacle>

@property id <ObstacleSceneDelegate> delegate;

@end
