//
//  MyScene.h
//  MazeExplorer
//

//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

/* This is the main scene. It possesses the resource and maze view controllers and thus scenes.
 * It's job is to initialize them when needed, and pass information between them (hence its delegate status).
 */

#import <SpriteKit/SpriteKit.h>
#import "MazeScene.h"
#import "ResourceScene.h"
#import "InstructionScene.h"

@interface MyScene : SKScene <MazeSceneDelegate, ResourceSceneDelegate, ResourceConfirmDelegate, InstructionSceneDelegate>

// Any methods that MazeScene or ResourceScene calls on their delegates
// must appear here, and be implemented in the .m file.

-(void)increaseResourceCounter;
-(void)useResourceConfirmed; 
-(void)mazeSolved;
-(void)instructionsDone;
@end
