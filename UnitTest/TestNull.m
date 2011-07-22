//
//  TestNull.m
//  bson-objc
//
//  Created by Martin Kou on 6/17/11.
//  Copyright 2011 TixxMe Inc. All rights reserved.
//

#import "TestNull.h"
#import "BSONCodec.h"
#import "NSData+Base64.h"

@implementation TestNull

- (void) testEmpty
{
    NSDictionary *original = [NSDictionary dictionary];
    NSData *encoded = [original BSONEncode];
    NSData *standard = [NSData dataFromBase64String: @"BQAAAAA=\n"];
    NSDictionary *decoded = [encoded BSONValue];
    GHAssertTrue([original isEqualToDictionary: decoded], @"Encode and decode empty dictionary");
    GHAssertTrue([standard isEqualToData: encoded], @"Encoded data should match standard");
}

- (void) testNull
{
    NSDictionary *original = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNull null], @"valueA",
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNull null], @"foo",
                               [NSNull null], @"bar",
                               nil], @"valueB",
                              nil];
    NSData *encoded = [original BSONEncode];
    NSDictionary *decoded = [encoded BSONValue];
    
    GHAssertTrue([original isEqualToDictionary: decoded], @"Encode and decode null items");
}

@end
