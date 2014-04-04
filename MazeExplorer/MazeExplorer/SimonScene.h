//
//  SimonScene.h
//  MazeExplorer
//
//  Created by Marjorie Principato (based on code written by Emily Stansbury) on 4/3/14.
//
//


#import <SpriteKit/SpriteKit.h>

@protocol SimonSceneDelegate

- (void)obstacleDidFinish;

@end

@interface SimonScene : SKScene

@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) SKSpriteNode *checkNode;

@property (nonatomic) NSInteger *userarray;
@property (nonatomic) NSInteger *comparray; 
@property (nonatomic) NSInteger currentlength;
@property (nonatomic) NSInteger touchcount; 

@property float buttonWidth;

@property id <SimonSceneDelegate> delegate;

@end


