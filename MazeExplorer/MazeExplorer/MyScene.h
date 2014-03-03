//
//  MyScene.h
//  MazeExplorer
//

//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MazeScene.h"
#import "ResourceScene.h"

@interface MyScene : SKScene <MazeSceneDelegate, ResourceSceneDelegate>

// Any methods that MazeScene or ResourceScene calls on their delegates
// must appear here, and be implemented in the .m file. 

@end
