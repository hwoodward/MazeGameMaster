//
//  TraceScene.h
//  MazeExplorer
//
//  Created by CS121 on 4/17/14.
//
//

#import <SpriteKit/SpriteKit.h>
#import "Obstacle.h"

@interface TraceScene : SKScene <Obstacle>

@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property int inTarget;

@property id <ObstacleSceneDelegate> delegate;

- (void) moveSelectedNode:(CGPoint)translation;
- (void) addTargetBox:(CGPoint) location;
- (void) notCrossingLines;

@end
