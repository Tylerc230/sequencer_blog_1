//
//  SequencerTests.m
//  SequencerTests
//
//  Created by Tyler Casselman on 6/25/11.
//  Copyright 2011 SFSoftwareist. All rights reserved.
//

#import "SequencerTests.h"


typedef enum {
	//Important: Don't use 0 as a step, 0 is a sentinel to the var_args 
	DSEnd = 0,
	DS1 = 1,
	DS2,
	DS3,
	DS4,
	DS5
}DependentSteps;

static int executedMethods = 0;

@implementation SequencerTests

- (void)setUp
{
    [super setUp];
	sequencer_ = [[Sequencer alloc] init];
    executedMethods = 0;
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [sequencer_ release], sequencer_ = nil;
    [super tearDown];
}

- (void)testSequenceAddition
{

	[sequencer_ addTarget:self action:@selector(method1) dependencies:DS1, DS3, DS5, DSEnd];
	STAssertEquals(sequencer_.numUnresolvedEntries, 1, @"Has incorrect number of unresolved dependancies left");
	[sequencer_ addTarget:self action:@selector(method2) dependencies:DS2, DS3, nil];
	STAssertEquals(sequencer_.numUnresolvedEntries, 2, @"Has incorrect unresolved Dependencies");
	
}

- (void)testSequenceRemoval
{
	[sequencer_ addTarget:self action:@selector(method1) dependencies:DS1, DSEnd];
	[sequencer_ addTarget:self action:@selector(method2) dependencies:DS2, DSEnd];
	[sequencer_ resolveDependency:DS3];
	STAssertEquals(sequencer_.numUnresolvedEntries, 2, @"Failed to keep entries after unrelated resolution");
	[sequencer_ resolveDependency:DS2];
	STAssertEquals(sequencer_.numUnresolvedEntries, 1, @"Failed to remove entry");
	[sequencer_ resolveDependency:DS1];
	STAssertEquals(sequencer_.numUnresolvedEntries, 0, @"Failed to remove all entries");
}

- (void)testDependencyResolution
{
	[sequencer_ addTarget:self action:@selector(method1) dependencies:DS1, DSEnd];
	[sequencer_ resolveDependency:DS1];
	STAssertTrue(executedMethods & 1, @"Method not executed after dependency resolution");
}

- (void)testImmediateExecution
{
	[sequencer_ addTarget:self action:@selector(method1) dependencies:DSEnd];
	STAssertEquals(sequencer_.numUnresolvedEntries, 0, @"Method not removed after execution");
	STAssertTrue(executedMethods & 1, @"Method not executed immediately");
}

- (void)testRecursiveDependencyResolution
{
	
}

#pragma dependent methods
- (void)method1
{
	executedMethods |= 1;
}

- (void)method2
{
	executedMethods |= (1 << 1);
}

- (void)method3
{
	executedMethods |= (1 << 2);
}

@end
