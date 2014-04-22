//
//  AvalancheScene.h
//  MazeExplorer
//
//  Created by CS121 on 4/12/14.
//
//

#import <SpriteKit/SpriteKit.h>
#import "Obstacle.h"

@interface AvalancheScene : SKScene <Obstacle>

@property id <ObstacleSceneDelegate> delegate;

@end
