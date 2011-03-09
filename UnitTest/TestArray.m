//
//  TestArray.m
//  bson-objc
//
//  Created by Martin Kou on 3/8/11.
//  Copyright 2011 TixxMe Inc. All rights reserved.
//

#import "TestArray.h"
#import "BSONCodec.h"
#import "NSData+Base64.h"

@implementation TestArray
- (void) setUp
{
	NSString *lyrics = @"Viva La Vida lyrics\n\n"
	
	"		I used to rule the world\n"
	"		Seas would rise when I gave the word\n"
	"		Now in the morning I sleep alone\n"
	"		Sweep the streets I used to own\n\n"
	
	"		I used to roll the dice\n"
	"		Feel the fear in my enemy's eyes\n"
	"		Listen as the crowd would sing\n"
	"		\"Now the old king is dead! Long live the king!\"\n\n"
	
	"		One minute I held the key\n"
	"		Next the walls were closed on me\n"
	"		And I discovered that my castles stand\n"
	"		Upon pillars of salt and pillars of sand\n\n"
	
	"		I hear Jerusalem bells a ringing\n"
	"		Roman Cavalry choirs are singing\n"
	"		Be my mirror, my sword and shield\n"
	"		My missionaries in a foreign field\n\n"
	
	"		For some reason I can't explain\n"
	"		Once you go there was never\n"
	"		Never an honest word\n"
	"		And that was when I ruled the world\n\n"
	
	"		It was the wicked and wild wind\n"
	"		Blew down the doors to let me in\n"
	"		Shattered windows and the sound of drums\n"
	"		People couldn't believe what I'd become\n\n"
	
	"		Revolutionaries wait\n"
	"		For my head on a silver plate\n"
	"		Just a puppet on a lonely string\n"
	"		Oh who would ever want to be king?\n\n"
	
	"		I hear Jerusalem bells a ringing\n"
	"		Roman Cavalry choirs are singing\n"
	"		Be my mirror, my sword and shield\n"
	"		My missionaries in a foreign field\n\n"
	
	"		For some reason I can't explain\n"
	"		I know Saint Peter won't call my name\n"
	"		Never an honest word\n"
	"		But that was when I ruled the world\n\n"
	
	"		I hear Jerusalem bells a ringing\n"
	"		Roman Cavalry choirs are singing\n"
	"		Be my mirror, my sword and shield\n"
	"		My missionaries in a foreign field\n\n"
	
	"		For some reason I can't explain\n"
	"		I know Saint Peter won't call my name\n"
	"		Never an honest word\n"
	"		But that was when I ruled the world";
	
	NSMutableArray *lyricsList = [[lyrics componentsSeparatedByString: @"\n"] mutableCopy];
	_doc = [[NSDictionary alloc] initWithObjectsAndKeys: lyricsList, @"lyrics", nil];
	[lyricsList release];
}

- (void) tearDown
{
	[_doc release];
	_doc = nil;
}

- (void) testLongArray
{
	NSData *serialized = [_doc BSONEncode];
	NSDictionary *doc2 = [serialized BSONValue];
	NSArray *lyrics = [doc2 objectForKey: @"lyrics"];
	
	GHAssertTrue([lyrics isKindOfClass: [NSArray class]], @"Restored array should exist.");
	GHAssertEquals([lyrics count], (NSUInteger) 56, @"Restored array length should be correct.");
	GHAssertTrue([doc2 isEqualToDictionary: _doc], @"Restored long array should be correct.");
}

- (void) testEncodedOrder
{
	NSString *precompiled = @"4gcAAARseXJpY3MA1QcAAAIwABQAAABWaXZhIExhIFZpZGEgbHlyaWNzAAIxAAEAAAAAAjIAGwAA\nAAkJSSB1c2VkIHRvIHJ1bGUg"
	"dGhlIHdvcmxkAAIzACcAAAAJCVNlYXMgd291bGQgcmlzZSB3aGVu\nIEkgZ2F2ZSB0aGUgd29yZAACNAAjAAAACQlOb3cgaW4gdGhlIG1vcm5pbmcgSSBzbGVl"
	"cCBhbG9u\nZQACNQAiAAAACQlTd2VlcCB0aGUgc3RyZWV0cyBJIHVzZWQgdG8gb3duAAI2AAEAAAAAAjcAGgAA\nAAkJSSB1c2VkIHRvIHJvbGwgdGhlIGRpY2"
	"UAAjgAIwAAAAkJRmVlbCB0aGUgZmVhciBpbiBteSBl\nbmVteSdzIGV5ZXMAAjkAIQAAAAkJTGlzdGVuIGFzIHRoZSBjcm93ZCB3b3VsZCBzaW5nAAIxMAAy\n"
	"AAAACQkiTm93IHRoZSBvbGQga2luZyBpcyBkZWFkISBMb25nIGxpdmUgdGhlIGtpbmchIgACMTEA\nAQAAAAACMTIAHAAAAAkJT25lIG1pbnV0ZSBJIGhlbGQg"
	"dGhlIGtleQACMTMAIwAAAAkJTmV4dCB0\naGUgd2FsbHMgd2VyZSBjbG9zZWQgb24gbWUAAjE0ACkAAAAJCUFuZCBJIGRpc2NvdmVyZWQgdGhh\ndCBteSBjYX"
	"N0bGVzIHN0YW5kAAIxNQArAAAACQlVcG9uIHBpbGxhcnMgb2Ygc2FsdCBhbmQgcGls\nbGFycyBvZiBzYW5kAAIxNgABAAAAAAIxNwAjAAAACQlJIGhlYXIgSm"
	"VydXNhbGVtIGJlbGxzIGEg\ncmluZ2luZwACMTgAIwAAAAkJUm9tYW4gQ2F2YWxyeSBjaG9pcnMgYXJlIHNpbmdpbmcAAjE5ACQA\nAAAJCUJlIG15IG1pcnJv"
	"ciwgbXkgc3dvcmQgYW5kIHNoaWVsZAACMjAAJQAAAAkJTXkgbWlzc2lv\nbmFyaWVzIGluIGEgZm9yZWlnbiBmaWVsZAACMjEAAQAAAAACMjIAIgAAAAkJRm9y"
	"IHNvbWUgcmVh\nc29uIEkgY2FuJ3QgZXhwbGFpbgACMjMAHgAAAAkJT25jZSB5b3UgZ28gdGhlcmUgd2FzIG5ldmVy\nAAIyNAAXAAAACQlOZXZlciBhbiBob2"
	"5lc3Qgd29yZAACMjUAJgAAAAkJQW5kIHRoYXQgd2FzIHdo\nZW4gSSBydWxlZCB0aGUgd29ybGQAAjI2AAEAAAAAAjI3ACIAAAAJCUl0IHdhcyB0aGUgd2lja2"
	"Vk\nIGFuZCB3aWxkIHdpbmQAAjI4ACMAAAAJCUJsZXcgZG93biB0aGUgZG9vcnMgdG8gbGV0IG1lIGlu\nAAIyOQArAAAACQlTaGF0dGVyZWQgd2luZG93cyBh"
	"bmQgdGhlIHNvdW5kIG9mIGRydW1zAAIzMAAq\nAAAACQlQZW9wbGUgY291bGRuJ3QgYmVsaWV2ZSB3aGF0IEknZCBiZWNvbWUAAjMxAAEAAAAAAjMy\nABcAAA"
	"AJCVJldm9sdXRpb25hcmllcyB3YWl0AAIzMwAgAAAACQlGb3IgbXkgaGVhZCBvbiBhIHNp\nbHZlciBwbGF0ZQACMzQAIwAAAAkJSnVzdCBhIHB1cHBldCBvbi"
	"BhIGxvbmVseSBzdHJpbmcAAjM1\nACUAAAAJCU9oIHdobyB3b3VsZCBldmVyIHdhbnQgdG8gYmUga2luZz8AAjM2AAEAAAAAAjM3ACMA\nAAAJCUkgaGVhciBK"
	"ZXJ1c2FsZW0gYmVsbHMgYSByaW5naW5nAAIzOAAjAAAACQlSb21hbiBDYXZh\nbHJ5IGNob2lycyBhcmUgc2luZ2luZwACMzkAJAAAAAkJQmUgbXkgbWlycm9y"
	"LCBteSBzd29yZCBh\nbmQgc2hpZWxkAAI0MAAlAAAACQlNeSBtaXNzaW9uYXJpZXMgaW4gYSBmb3JlaWduIGZpZWxkAAI0\nMQABAAAAAAI0MgAiAAAACQlGb3"
	"Igc29tZSByZWFzb24gSSBjYW4ndCBleHBsYWluAAI0MwAoAAAA\nCQlJIGtub3cgU2FpbnQgUGV0ZXIgd29uJ3QgY2FsbCBteSBuYW1lAAI0NAAXAAAACQlOZX"
	"ZlciBh\nbiBob25lc3Qgd29yZAACNDUAJgAAAAkJQnV0IHRoYXQgd2FzIHdoZW4gSSBydWxlZCB0aGUgd29y\nbGQAAjQ2AAEAAAAAAjQ3ACMAAAAJCUkgaGVh"
	"ciBKZXJ1c2FsZW0gYmVsbHMgYSByaW5naW5nAAI0\nOAAjAAAACQlSb21hbiBDYXZhbHJ5IGNob2lycyBhcmUgc2luZ2luZwACNDkAJAAAAAkJQmUgbXkg\nbW"
	"lycm9yLCBteSBzd29yZCBhbmQgc2hpZWxkAAI1MAAlAAAACQlNeSBtaXNzaW9uYXJpZXMgaW4g\nYSBmb3JlaWduIGZpZWxkAAI1MQABAAAAAAI1MgAiAAAACQ"
	"lGb3Igc29tZSByZWFzb24gSSBjYW4n\ndCBleHBsYWluAAI1MwAoAAAACQlJIGtub3cgU2FpbnQgUGV0ZXIgd29uJ3QgY2FsbCBteSBuYW1l\nAAI1NAAXAAAA"
	"CQlOZXZlciBhbiBob25lc3Qgd29yZAACNTUAJgAAAAkJQnV0IHRoYXQgd2FzIHdo\nZW4gSSBydWxlZCB0aGUgd29ybGQAAAA=\n";
	
	NSData *checkData = [NSData dataFromBase64String: precompiled];	
	NSData *serialized = [_doc BSONEncode];

	GHAssertEquals([checkData length], [serialized length], @"BSON length should be correct.");
	GHAssertEqualObjects(checkData, serialized, @"Encoded array should be correct.");
}
@end
