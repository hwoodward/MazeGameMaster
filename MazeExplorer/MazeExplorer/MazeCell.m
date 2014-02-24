//
//  MazeCell.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//
//

#import "MazeCell.h"

@implementation MazeCell

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

- (BOOL)isWall
{
    return ![_contents compare:@"*"];
}

@end
