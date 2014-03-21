//
//  MazeCell.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//
//

#import "MazeCell.h"

@implementation MazeCell

/*
 * Method: initWithRow: andColumn
 * Do not use init. Things will be nil, or default, or something weird. Don't do it.
 *
 * initializes the MazeCell with the given inputs.
 * In this case it takes a NSStrig for contents, instead of a CellType and converts it here
 * this is used to initialize cells from strings. The translation from strings to CellTypes is below:
 * Key for string to maze translation:
 * "*" --> Wall
 * " " --> Path
 * "O" --> Obstacle
 * "R" --> Resource
 * "S" --> starting location (NOTE: There should only be ONE of these per maze, or weirdness will ensue)
 * "E" --> End location (NOTE: For now, there should only be one of these. If you want to build support
 *                       multiple exits, be my guest)
 */
- (id)initWithRow: (int) row
              andColumn: (int) col
         andStringContents: (NSString *) contents
{
    self = [super init];
    _cellCol = col;
    _cellRow = row;
    
    if (![contents compare:@"*"]) {
        _contents = Wall;
    }
    else if (![contents compare:@"O"]) {
        _contents = Obstacle;
    }
    else if (![contents compare:@"R"]) {
        _contents = Resource;
    }
    else if (![contents compare:@"S"]) {
        _contents = End;
    }
    else if (![contents compare:@"E"]) {
        _contents = End;
    }
    else {
        _contents = Path;
    }
    
    return self;
}

/*
 * Method: initWithRow: andColumn
 * Do not use init. Things will be nil, or default, or something weird. Don't do it.
 *
 * initializes the MazeCell with the given inputs.
 */
- (id)initWithRow: (int) row
        andColumn: (int) col
      andContents: (CellType) contents
{
    self = [super init];
    _cellCol = col;
    _cellRow = row;
    _contents = contents;

    return self;
}

/*
 * Method: isWall
 *
 * Checks that a MazeCell is a wall or not.
 * (Note: [<NSString> compare:] returns 0 if the strings are equal, so to make this
 * return the correct boolean, I had to flip the result. Yes, this makes me angry
 * too.)
 *
- (BOOL)isWall
{
    return ![_contents == (CellType)Wall];
}
*/
@end
