//
//  ResourceConfirm.h
//  MazeExplorer
//
//  Created by CS121 on 3/27/14.
//
//

#import <SpriteKit/SpriteKit.h>
#import "typedef.h"
#import "DSMultilineLabelNode.h"

@protocol ResourceConfirmDelegate

-(void)resourceConfirmDidFinish;
-(void)useResourceConfirmed:(ResourceType) type; 


@end

@interface ResourceConfirm : SKScene

@property id <ResourceConfirmDelegate> delegate;
-(id) initWithSize:(CGSize)size andResource:(ResourceType)resourceType;

@end
