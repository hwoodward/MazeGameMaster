//
//  Maze.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//
//
/* This is the Maze class which stores the hard coded maze which a person moves around in.
 * This class uses an array of MazeCells to represent the maze and provides information about a given row and column
 * when needed.
 */

#import <Foundation/Foundation.h>
#import "MazeCell.h"

@interface Maze : NSObject

@property (readonly) int numRows;
@property (readonly) int numCols;
@property (readonly) CGPoint startLoc;
@property (readonly) CGPoint endLoc;

- (void)printMaze;

- (BOOL)isWallCellWithRow:(int)row andColumn:(int)col;

- (id)initMazeWithString:(NSString*) mazeString
                andWidth:(int) width;
- (NSString*)getContentsWithRow:(int)row
                      andColumn:(int)col;
-(MazeCell*)returnCellWithRow:(int)row
                    andColumn:(int)col;
-(void)emptyContentsWithRow:(int)row
                  andColumn:(int)col;

@end
