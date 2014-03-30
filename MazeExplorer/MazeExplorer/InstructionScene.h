//
//  InstructionScene.h
//  MazeExplorer
//
//  Created by Helen Woodward on 3/30/14.
//
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import "DSMultilineLabelNode.h"

@protocol InstructionSceneDelegate

- (void)instructionsDone;

@end


@interface InstructionScene : SKScene
@property id <InstructionSceneDelegate> delegate;

@end
