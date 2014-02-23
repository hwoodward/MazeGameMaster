//
//  Maze.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//
//

#import "Maze.h"
#import "MazeCell.h"

@interface Maze ()

@property (nonatomic) NSMutableArray *cells;

@end

@implementation Maze

- (id)init
{
    self = [super init];
    
    _numCols = 10;
    _numRows = 10;
    _cells = [[NSMutableArray alloc] init];
    for (int i = 0; i < _numRows; i++) {
        NSMutableArray *row = [[NSMutableArray alloc] init];
        for (int j = 0; j < _numCols; j++) {
            if (j == 0 || j == _numCols -1 ||
                i == 0 || i == _numRows -1) {
                MazeCell *cell = [[MazeCell alloc] initWithRow:i andColumn:j andContents:@"*"];
                [row addObject:cell];
            } else {
                MazeCell *cell = [[MazeCell alloc] initWithRow:i andColumn:j andContents:@" "];
                [row addObject:cell];
            }
            
        }
        [_cells addObject:row];
    }
    
    return self;
}

- (void)printMaze
{
    NSMutableString* maze = [[NSMutableString alloc] init];
    
    for (int i = 0; i < _numRows; i++) {
        [maze appendString:@"\n"];
        
        for (int j = 0; j < _numCols; j++) {
            MazeCell* cell = [[_cells objectAtIndex:i] objectAtIndex:j];
            [maze appendString: [cell contents]];
        }
    }
    
    NSLog(@"%@", maze);
}

- (BOOL)isWallCellWithRow:(int)row andColumn:(int)col
{
    MazeCell* cell = [[_cells objectAtIndex:row] objectAtIndex:col];
    return [cell isWall];
}

- (id)initMazeWithString:(NSString*) mazeString
                andWidth:(int) width
{
    self = [super init];
    
    int height = [mazeString length] / width;
    
    _numRows = height;
    _numCols = width;
    _cells = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < height; i++) {
        NSMutableArray* row = [[NSMutableArray alloc] init];
        for (int j = 0; j < width; j++) {
            NSString *contents =[mazeString substringWithRange:NSMakeRange((i*width)+j, 1)];
            MazeCell* cell =
            [[MazeCell alloc] initWithRow:j andColumn:i
                              andContents:contents];
            [row addObject:cell];
            if (![contents compare:@"S"]) {
                _startLoc = CGPointMake(j, i);
            } else if (![contents compare:@"E"]) {
                _endLoc = CGPointMake(j, i);
            }
        }
        [_cells addObject: row];
    }
    return self;
}


@end
