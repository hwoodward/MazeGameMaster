//
//  PitFillScene.h
//  MazeExplorer
//
//  Created by Helen Woodward on 4/6/14.
//
//
/* This is an obstacle where you will drag a number of "boulders" into a pit to fill it. When they are all inside the "pit" it will dismiss.
 */


#import <SpriteKit/SpriteKit.h>
#import "Obstacle.h"

@interface PitFillScene : SKScene <Obstacle>

@property id <ObstacleSceneDelegate> delegate;

@end
