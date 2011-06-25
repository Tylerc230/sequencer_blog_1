//
//  SequencerTests.m
//  SequencerTests
//
//  Created by Tyler Casselman on 6/25/11.
//  Copyright 2011 SFSoftwareist. All rights reserved.
//

#import "SequencerTests.h"
#import "Sequencer.h"

typedef enum {
	LS1 = 1,
	LS2,
	LS3,
	LS4,
	LS5
}LoadSteps;

@implementation SequencerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testSequenceAddition
{
	Sequencer * sequencer = [[Sequencer alloc] init];
	[sequencer addTarget:self action:@selector(allStepsComplete) dependencies:LS1, LS3, LS5, nil];
	STAssertEquals(sequencer.numUnresolvedDependencies, 1, @"Has correct number of unresolved dependancies left");
	[sequencer addTarget:self action:@selector(allStepsComplete2) dependencies:LS2, LS3, nil];
	STAssertEquals(sequencer.numUnresolvedDependencies, 2, @"Has correct unresolved Dependencies");
	
	
	[sequencer release];
	
}

@end
