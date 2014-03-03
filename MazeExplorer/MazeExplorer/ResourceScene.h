//
//  ResourceScene.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 3/1/14.
//
//

#import <SpriteKit/SpriteKit.h>

@protocol ResourceSceneDelegate

// This is where the talking methods should go for MazeScene/ResourceScene
// They will be sent to MyScene, which will pass along the information to MazeScene

@end

@interface ResourceScene : SKScene

@property (nonatomic) id <ResourceSceneDelegate> delegate;

@end
