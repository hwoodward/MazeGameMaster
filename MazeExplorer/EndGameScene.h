//
//  EndGameScene.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 4/28/14.
//
//

#import <SpriteKit/SpriteKit.h>

@protocol EndGameSceneDelegate <NSObject>

-(void) endGameSceneDidFinish;
-(int) getScore;

@end

@interface EndGameScene : SKScene

@property id <EndGameSceneDelegate> delegate;
-(void)displayScore;

@end
