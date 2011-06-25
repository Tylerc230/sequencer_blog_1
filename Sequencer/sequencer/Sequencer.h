//
//  Sequencer.h
//  Sequencer
//
//  Created by Tyler Casselman on 6/25/11.
//  Copyright 2011 SFSoftwareist. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Sequencer : NSObject {
    NSMutableArray	* entries_;
	NSMutableSet	* resolvedDependencies_;
	
}
@property (nonatomic, readonly) int numUnresolvedEntries;

//requires 0 termination
- (void)addTarget:(id)target action:(SEL)action dependencies:(int)dependancy1,...;
- (void)resolveDependency:(int)dependency;

@end
