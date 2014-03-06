//
//  MazeScene.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/23/14.
//
//
/* MazeScene is a scene which renders the maze and lets the user interact with it.
 * It possess a Maze object which it renders into nodes, a player node that it keeps displayed.
 * This class is responsible for movement of the maze, launching obstacles, and passing information
 * about encountered resources along to the appropriate place.
 */

#import <SpriteKit/SpriteKit.h>
#import "ObstacleScene.h"


@protocol MazeSceneDelegate

// This is where the talking methods should go for MazeScene/ResourceScene
// They will be sent to MyScene, which will pass along the information to ResourceScene

//This function should call the function in MyScene that calls the function in ResourceScene that increases the counter.
-(void)tellMySceneToIncreaseResourceCounter;


@end

@interface MazeScene : SKScene <ObstacleSceneDelegate>

@property (nonatomic) id <MazeSceneDelegate> delegate;

-(void) obstacleDidFinish;

@end
