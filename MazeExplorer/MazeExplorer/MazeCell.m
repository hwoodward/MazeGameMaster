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
 */
- (id)initWithRow: (int) row
              andColumn: (int) col
         andContents: (NSString*) contents
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
 */
- (BOOL)isWall
{
    return ![_contents compare:@"*"];
}

@end
