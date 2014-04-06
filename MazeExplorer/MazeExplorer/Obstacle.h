//
//  Obstacle.h
//  MazeExplorer
//
//  Created by Helen Woodward on 4/5/14.
//
//

#import <Foundation/Foundation.h>

@protocol ObstacleSceneDelegate

- (void)obstacleDidFinish;
- (void)obstacleDidFail;

@end


@protocol Obstacle <NSObject>

@property id <ObstacleSceneDelegate> delegate;

@end
