//
//  MyScene.m
//  MazeExplorer
//
//  Created by Emily Stansbury on 2/15/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MyScene.h"


@interface MyScene ()

@property BOOL didPresentGameViews;
@property (nonatomic) SKView *mazeView;
@property (nonatomic) SKView *resourceView;

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        _didPresentGameViews = NO;
    }
    
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    //Right now, this just drops us into a MazeScene
    
    if (!_didPresentGameViews) {
        
        _mazeView = [[SKView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        MazeScene *mazeScene = [[MazeScene alloc] initWithSize:CGSizeMake(self.frame.size.width, self.frame.size.width)];
        [mazeScene setDelegate:self];
        
        [self.view addSubview:_mazeView];
        [_mazeView presentScene:mazeScene];
        
        _resourceView = [[SKView alloc] initWithFrame:CGRectMake(0, self.frame.size.width,
                                                                 self.frame.size.width,
                                                                self.frame.size.height-self.frame.size.width)];
        ResourceScene *resourceScene = [[ResourceScene alloc]
                                  initWithSize:CGSizeMake(self.frame.size.width,
                                                          self.frame.size.height-self.frame.size.width)];
        [resourceScene setDelegate:self];
        [self.view addSubview:_resourceView];
        [_resourceView presentScene:resourceScene];
        
        
        _didPresentGameViews = YES;
    }
    
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}



@end
