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

@interface MazeCell : NSObject

@property (readonly) int cellRow;
@property (readonly) int cellCol;
@property NSString* contents;

- (id)initWithRow: (int) row
           andColumn: (int) col
      andContents: (NSString*) contents;
- (BOOL)isWall;

@end
