//
//  Maze.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//
//

#import <Foundation/Foundation.h>

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

@end
