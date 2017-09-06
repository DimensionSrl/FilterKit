# FilterKit Readme
[![License MIT](https://img.shields.io/cocoapods/l/FilterKit.svg)](https://raw.githubusercontent.com/dimensionsrl/FilterKit/master/LICENSE) 
[![Version](https://img.shields.io/cocoapods/v/FilterKit.svg)](https://cocoapods.org/?q=FilterKit) 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![travis-ci](https://travis-ci.org/DimensionSrl/FilterKit.svg?branch=master)](https://travis-ci.org/DimensionSrl/FilterKit) 
![Swift 3](https://img.shields.io/badge/language-Swift%203-EB7943.svg) ![Swift 4](https://img.shields.io/badge/language-Swift%204-EB7943.svg) 
[![codecov](https://codecov.io/gh/DimensionSrl/FilterKit/branch/master/graph/badge.svg)](https://codecov.io/gh/DimensionSrl/FilterKit) 
![Platforms](https://img.shields.io/badge/platforms-iOS%20|%20macOS%20|%20tvOS%20|%20watchOS%20|%20Linux-EB7943.svg)

FilterKit is a component written in Swift that let you validate or filter an object, based on a set of properties listed in a dictionary. It's inspired by the [filter](https://www.mapbox.com/mapbox-gl-js/style-spec/#types-filter) element in the [MapBox](https://www.google.it/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0ahUKEwjovNC51ZDWAhXID8AKHUf9BmMQFggmMAA&url=https%3A%2F%2Fwww.mapbox.com%2F&usg=AFQjCNEIt9MHcYcAUBD0eKiH2wCb7aAkQA) [Style Specifications](https://www.mapbox.com/mapbox-gl-js/style-spec/). Compatibility is ensured with iOS, macOS, tvOS, watchOS and Linux. There's also a small bridge that enables full (for now) Objective-C interoperability.

## Rationale
> This chapter has been copied and slightly adapted from the original MapBox [filter](https://www.mapbox.com/mapbox-gl-js/style-spec/#types-filter) documentation.  

A filter selects specific features from a dictionary of properties. A filter is specified as an array of one of the following forms:

### Existential Filters

`["has", key]` *feature[key]* **exists**
`["!has", key]` *feature[key]* **does not exist**

### Comparison Filters

`["==", key, value]` **equality**: *feature[key] = value*
`["!=", key, value]` **inequality**: *feature[key] ≠ value*
`[">", key, value]` **greater than**: *feature[key] > value*
`[">=", key, value]` **greater than or equal**: *feature[key] ≥ value*
`["<", key, value]` **less than**: *feature[key] < value*
`["<=", key, value]` **less than or equal**: *feature[key] ≤ value*

### Set Membership Filters

`["in", key, v0, ..., vn]` **set inclusion**: *feature[key] ∈ {v0, ..., vn}*
`["!in", key, v0, ..., vn]` **set exclusion**: *feature[key] ∉ {v0, ..., vn}*

### Combining Filters

`["all", f0, ..., fn]` **logical AND**: *f0 ∧ ... ∧ fn*
`["any", f0, ..., fn]` **logical OR**: *f0 ∨ ... ∨ fn*
`["none", f0, ..., fn]` **logical NOR**: *¬f0 ∧ ... ∧ ¬fn*

A `key` must be a string that identifies a feature property.

A `value` (and `v0`, ..., `vn` for set operators) must be a `String`, `Int`, `Double` or `Bool` to compare the property value against.

Set membership filters are a compact and efficient way to test whether a field matches any of multiple values.

The comparison and set membership filters implement strictly-typed comparisons; for example, all of the following evaluate to false: `0 < "1"`, `2 == "2"`, `"true" in [true, false]`.

The `"all"`, `"any"`, and `"none"` filter operators are used to create compound filters. The values `f0`, ..., `fn` must be filter expressions themselves.

The following filter requires that the `road` property is equal to either `"street_major"`, `"street_minor"` or `"street_limited"`.

```json
["in", "road", "street_major", "street_minor", "street_limited"]
```

The combining filter `"all"` takes the three other filters that follow it and requires all of them to be true for a feature to be included: a feature must have a `road` equal to `"street_limited"`, its `admin_level` must be greater than or equal to `3`, and `paved` must not be `false` nor `2` . You could change the combining filter to `"any"` to allow features matching any of those criteria to be included.

```json
[
"all",
["==", "road", "street_limited"],
[">=", "admin_level", 3],
["!in", "paved", false, 2]
]
```

## Usage
First of all import *FilterKit* module into your Swift class with `import FilterKit` or Objective-C one with `@import FilterKit;`.

Then instantiate the `Filter` object with the desired properties expressed as a Dictionary. On that instance call the `compile` function providing the Array containing the filter.
```swift
do {
let result = try Filter(properties: ["foo":"bar"]).compile(["all", ["==", "foo", "bar"]])
print("Result: \(result)")
} catch let error {
print(error.localizedDescription)
}
```

Or in Objective-C:
```objc
FILFilter *filter = [[FILFilter alloc] initWithProperties:@{@"foo": @"bar"}];
NSError *error;
FILFilterResult *result = [filter compileWithFilters:@[@"all", @[@"==", @"foo", @"bar"]] error:&error];
if(error != nil) {
NSLog(@"%@", error);
}
NSLog(@"Result: %d", result.valid);
```

> If you need guidance to parse a JSON file, take a look at the `parseFixture(_ named: String)` function contained in the *FilterKitTests.swift* file, included in the *Tests/FilterKitTests* subfolder.  

## Edge Cases
Due to differences in the compiler some conditions are returning different results based on Swift version or platform. Those are probably edge cases and shouldn't cause any misbehaviour, but you should be aware that they exist.

Those are the one identified so far:
* `1.09 == true` is *false* only if Swift ≥ 4.
* `1 == 1.0` is *false* on Linux and *true* on Apple's Platforms.
* `1 == true` is *false* on Linux and *true* on Apple's Platforms.

## Installation on Apple's Platforms

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.0.0+ is required to build FilterKit.  

To integrate FilterKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'FilterKit'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install [Carthage](https://github.com/Carthage/Carthage) with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate FilterKit into your Xcode project using [Carthage](https://github.com/Carthage/Carthage), specify it in your `Cartfile`:

```ogdl
github "macteo/FilterKit"
```

Run `carthage update --platform iOS` to build the framework and drag the built `FilterKit-PLATFORM.framework` into your Xcode project.

### Manually

Add the *FilterKit* Xcode project to your own. Then add the `FilterKit-PLATFORM` framework as desired to the embedded binaries of your app's target.

## Installation with Swift Package Manager
In your existing `Package.swift` file add the following line as member of the `dependencies` array.

```swift
.Package(url: "https://github.com/dimensiosrl/FilterKit.git", majorVersion: 1),
```

The complete version should appear like this:

```swift
import PackageDescription

let package = Package(
name: "Your App Name",
targets: [],
dependencies: [
.Package(url: "https://github.com/dimensiosrl/FilterKit.git", majorVersion: 1),
.Package(url: "https://github.com/example/another-dependancy.git", majorVersion: 2),
]
)
```

## Tests
The test suite is shared between platforms and targets and resides in the *Tests* folder. In the `Fixtures` sub-subfolder there are many *json* files representing different scenarios that will be parsed and tested against.

In order to run the tests on `macOS` you can use Xcode or use this command from the Terminal:
```sh
xcodebuild -project FilterKit.xcodeproj -scheme "FilterKit macOS" -enableCodeCoverage YES clean build test
```

If you want to test on Linux and have [Docker](http://docker.com) installed, just run:
```sh
docker-compose up
```

It will pull the latest [ibmcom/swift-ubuntu](https://github.com/IBM-Swift/swift-ubuntu-docker) image, mount the project folder as `/FilterKit` and execute `swift package clean; swift test`.

In both cases the output will appear directly on the Terminal.

## Acknowledgements
* [DIMENSION S.r.l.](https://dimension.it).
* Matteo Gavagnin – [@macteo](https://twitter.com/macteo).

## License
FilterKit is released under the MIT license. See [LICENSE](https://raw.githubusercontent.com/dimensionsrl/FilterKit/master/LICENSE) for details.
