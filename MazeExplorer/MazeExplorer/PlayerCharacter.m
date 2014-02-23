//
//  PlayerCharacter.m
//  MazeExplorer
//
//  Created by CS121 on 2/19/14.
//
//

#import "PlayerCharacter.h"

@implementation PlayerCharacter

-(void) moveUp{
    self.yValue = self.yValue+1;
}

-(void) moveDown{
    self.yValue = self.xValue-1;
}

-(void) moveLeft{
    self.xValue = self.xValue-1;
}

-(void) moveRight{
    self.xValue = self.xValue+1; 
}

@end

