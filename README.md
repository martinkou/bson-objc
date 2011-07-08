# bson-objc

## BSON Codec for Objective-C

# Install

Just add `bson-objc.framework` to your xcode project, and link against it.
You can get the latest framework release from `bson-objc.tar.gz`.

If you want to build the framework from the project, make sure you build the
`bson-objc` target for *both* the `Device` and `Simulator` architectures (i.e.
manually build both configurations from the drop down menu). The release tarball
is only generated under the Release configuration.

# Usage

This codec defines a protocol and a set of categories on common Foundation
classes. Converting to and from BSON is as easy as:

    NSData *bsonData = [dictionaryDoc BSONRepresentation];
    NSDictinary *bsonDoc = [bsonData BSONValue];

# License

MIT License

