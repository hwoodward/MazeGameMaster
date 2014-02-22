//
//  PlayerCharacter.h
//  MazeExplorer
//
//  Created by Marjorie Principato on 2/19/14.
//
//

#import <Foundation/Foundation.h>

@interface PlayerCharacter : NSObject

@property int *xValue;
@property int *yValue;

@property NSMutableArray *inventory; //Not sure if this will actually be useful. 

@property bool *haveString;

-(void) moveUp;
-(void) moveDown;
-(void) moveLeft;
-(void) moveRight;

@end