//
//  SimonScene.h
//  MazeExplorer
//
//  Created by Marjorie Principato (based on code written by Emily Stansbury) on 4/3/14.
//
//


#import <SpriteKit/SpriteKit.h>
#import "Obstacle.h"

@interface SimonScene : SKScene <Obstacle>

@property id <ObstacleSceneDelegate> delegate;

@end


