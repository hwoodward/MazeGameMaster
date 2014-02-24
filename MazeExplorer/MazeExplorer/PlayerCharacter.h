//
//  PlayerCharacter.h
//  MazeExplorer
//
//  Created by Marjorie Principato on 2/19/14.
//
//

// Honestly, we'll probably end up replacing our character with a node. This can hopefully at least hold inventory stuff. 

#import <Foundation/Foundation.h>

@interface PlayerCharacter : NSObject

@property int *xValue;
@property int *yValue;

@property NSMutableArray *inventory; //Not sure if this will actually be useful. 

@property bool *haveYarn;

-(void) moveUp;
-(void) moveDown;
-(void) moveLeft;
-(void) moveRight;

@end