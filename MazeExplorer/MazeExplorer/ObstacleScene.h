//
//  ObstacleScene.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 3/2/14.
//
//
/* This is the scene that launches on encountering an obstacle and handles the user interaction with the obstacle.
 * Currently this is the only obstacle class, but that will change as we create actual obstacles.
 * 
 * In general an obstacle class is responsible for responding to user interaction with the obstacle puzzle and 
 * dismissing itself when the puzzle issolved, either by completing the challenge presented or using a resource.
 */

#import <SpriteKit/SpriteKit.h>
#import "Obstacle.h"

@interface ObstacleScene : SKScene <Obstacle>

@property id <ObstacleSceneDelegate> delegate;

@end


