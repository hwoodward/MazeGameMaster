//
//  MazeScene.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/23/14.
//
//

#import <SpriteKit/SpriteKit.h>
#import "ObstacleScene.h"

@interface MazeScene : SKScene <ObstacleSceneDelegate>

-(void) obstacleDidFinish;

@end
