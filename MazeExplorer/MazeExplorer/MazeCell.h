//
//  MazeCell.h
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//
//
/* MazeCell's store the contents of a given part, cell, of the array. * 
 */

#import <Foundation/Foundation.h>
#import "typedef.h"

@interface MazeCell : NSObject

@property (readonly) int cellRow;
@property (readonly) int cellCol;
@property CellType contents;
@property SecondaryType secondaryType;

- (id)initWithRow: (int) row
           andColumn: (int) col
      andStringContents: (NSString *) contents;
- (id)initWithRow: (int) row
        andColumn: (int) col
      andContents: (CellType) contents;
- (id)initWithRow: (int) row
        andColumn: (int) col
      andContents: (CellType) contents
 andSecondaryType: (SecondaryType) secondaryType;
- (void)makeCellIntoObstacle;
- (void)makeCellIntoResource;

@end
