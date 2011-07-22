//
//  TestNumber.m
//  bson-objc
//
//  Created by Martin Kou on 7/22/11.
//  Copyright 2011 TixxMe Inc. All rights reserved.
//

#import "TestNumber.h"
#import "BSONCodec.h"

@implementation TestNumber

- (void) testDouble
{
    NSDictionary *original = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"To be or not to be", @"that's not the question",
                              [NSNumber numberWithDouble: 3.14159], @"pi",
                              [NSNumber numberWithInt: 42], @"Answer to Life, the Universe, and Everything",
                              [NSNumber numberWithDouble: 2.71828], @"e",
                              [NSNumber numberWithLongLong: 14348431049215], @"US National Debt At This Moment",
                              [NSNumber numberWithLongLong: 73278567479182372], @"Random Big Integer",
                              nil];
    NSData *encoded = [original BSONEncode];
    NSDictionary *decoded = [encoded BSONValue];
    GHAssertTrue([decoded isEqualToDictionary: original], @"Encode and decode floating point number");
}

@end
