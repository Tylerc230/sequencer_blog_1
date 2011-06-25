//
//  SequencerEntry.h
//  Sequencer
//
//  Created by Tyler Casselman on 6/25/11.
//  Copyright 2011 SFSoftwareist. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SequencerEntry : NSObject {
    id target_;
	SEL action_;
	NSSet * dependencies_;
}
- (id)initWithTarget:(id)target action:(SEL)action dependencies:(NSSet*)dependencies;
@end
