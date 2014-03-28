//
//  ResourceConfirm.h
//  MazeExplorer
//
//  Created by CS121 on 3/27/14.
//
//

#import <SpriteKit/SpriteKit.h>

@protocol ResourceConfirmDelegate

-(void)resourceConfirmDidFinish; 


@end

@interface ResourceConfirm : SKScene

@property (nonatomic) SKLabelNode *label;

@property id <ResourceConfirmDelegate> delegate;

@end
