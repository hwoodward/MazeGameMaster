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

@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property int inTarget;

@property id <ObstacleSceneDelegate> delegate;

- (void) moveSelectedNode:(CGPoint)translation;
- (void) addTargetBox:(CGPoint) location;
- (void) notCrossingLines;


@end
