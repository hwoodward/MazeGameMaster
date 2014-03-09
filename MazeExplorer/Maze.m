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


/*
 * Method: init
 * 
 * This generates a basic maze. 
 * A basic maze is a 10x10 area enclosed by walls. There isn't a start or an end. 
 * Don't make a basic maze. Use a string initialized maze.
 */
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

/*
 * Method: printMaze
 * 
 * This combines all the strings from the MazeCells' contents and prints
 * it out to the console. 
 * This is for debugging purposes, and shouldn't be called in final code.
 */
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

/*
 * Method: isWallCellWithRow: and Column:
 *
 * inputs: row and column indeces
 * The method will ask the MazeCell if it is a wall, and return the results of that.
 */
- (BOOL)isWallCellWithRow:(int)row andColumn:(int)col
{
    MazeCell* cell = [[_cells objectAtIndex:row] objectAtIndex:col];
    return [cell isWall];
}

/*
 * Method: returnCellWithRow: and Column:
 *
 * inputs: row and column indeces
 * The method will return the MazeCell at a particular row and column.
 */
-(MazeCell*)returnCellWithRow:(int)row andColumn:(int)col
{
    MazeCell* cell = [[_cells objectAtIndex:row] objectAtIndex:col];
    return cell;
}

/*
 * Method: emptyContentsWithRow: and Column:
 *
 * inputs: row and column indeces
 * The method will change the MazeCell's contents to a space.
 */
-(void)emptyContentsWithRow:(int)row andColumn:(int)col
{
    MazeCell* cell = [[_cells objectAtIndex:row] objectAtIndex:col];
    cell.contents = @" ";
    NSLog(@"emptyContentsWithRow has run!");
}



// This should be changed to the enum type later
- (NSString*)getContentsWithRow:(int)row andColumn:(int)col
{
    MazeCell* cell = [[_cells objectAtIndex:row] objectAtIndex:col];
    return [cell contents];
}


/*
 * Method: initMazeWithString: andWidth:
 * Use this init. Not the basic init.
 * 
 * inputs: an NSString that contains all of the rows of the maze and the desired width.
 * The method will calculate the height based on the string length and the width input,
 * and then will convert each width of the NSString into a row of the maze. 
 * There is no checking to make sure that the string is the right length to come out evenly,
 * so don't be silly (unless you feel like adding checks). The program will error and exit
 * if you do that. 
 * Key for string to maze translation:
 * "*" --> wall
 * " " --> empty space (corridor)
 * "S" --> starting location (NOTE: There should only be ONE of these per maze, or weirdness will ensue)
 * "E" --> End location (NOTE: For now, there should only be one of these. If you want to build support
 *                       multiple exits, be my guest)
 *
 * Final note: I am sorry for the fact that it is impossible to follow the row/column of a cell in this
 * piece of code. I got it backwards about five times, finally got it straight, and haven't had the 
 * heart to touch it since. Again, apologies. 
 */
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
