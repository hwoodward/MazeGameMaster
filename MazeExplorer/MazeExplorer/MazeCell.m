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
 * "O" --> Obstacle (DragDrop)
 * "R" --> Resource (Test)
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
        _secondaryType.Obstacle = DragDrop;
    }
    else if (![contents compare:@"R"]) {
        _contents = Resource;
        _secondaryType.Resource = Test;
    }
    else if (![contents compare:@"S"]) {
        _contents = Start;
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
    
    if (_contents == Obstacle) {
        _secondaryType.Obstacle = DragDrop;
    }
    if (_contents == Resource) {
        _secondaryType.Resource = Test;
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
 andSecondaryType: (SecondaryType)secondaryType
{
    self = [super init];
    _cellCol = col;
    _cellRow = row;
    _contents = contents;
    _secondaryType = secondaryType;
    return self;
}

@end
