//
//  ObstacleScene.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 3/2/14.
//
//

#import <SpriteKit/SpriteKit.h>

@protocol ObstacleSceneDelegate

- (void)obstacleDidFinish;

@end

@interface ObstacleScene : SKScene

@property id <ObstacleSceneDelegate> delegate;

@end


