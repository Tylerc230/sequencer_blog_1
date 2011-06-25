//
//  Sequencer.h
//  Sequencer
//
//  Created by Tyler Casselman on 6/25/11.
//  Copyright 2011 SFSoftwareist. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Sequencer : NSObject {
    NSMutableSet * entries_;
}
@property (nonatomic, readonly) int numUnresolvedDependencies;

- (void)addTarget:(id)target action:(SEL)action dependencies:(int)dependancy1,... NS_REQUIRES_NIL_TERMINATION;

@end
