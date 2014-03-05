//
//  PlayerCharacter.h
//  MazeExplorer
//
//  Created by Marjorie Principato on 2/19/14.
//
//
/* The PlayerCharacter object was a first attempt to keep track of the player, but subsequent changes have made it
 * unnecessary. Now the player is the responsiblity of the MazeScene as a node.
 */

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