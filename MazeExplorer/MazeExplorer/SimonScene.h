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

@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) SKSpriteNode *checkNode;

@property (nonatomic) NSMutableArray *userarray;
@property (nonatomic) NSMutableArray *comparray;
@property (nonatomic) NSInteger currentlength;
@property (nonatomic) NSInteger touchcount;
@property (nonatomic) NSInteger currentpos; 
@property (nonatomic) NSInteger winLength;
@property float buttonWidth;

@property id <ObstacleSceneDelegate> delegate;

@end


