# WeatherLondon

## How to build / run / test

1. You need to have Carthage installed. There are multiple options for installing Carthage:

* **Installer:** Download and run the `Carthage.pkg` file for the latest [release](https://github.com/Carthage/Carthage/releases), then follow the on-screen instructions. If you are installing the pkg via CLI, you might need to run `sudo chown -R $(whoami) /usr/local` first.

* **Homebrew:** You can use [Homebrew](http://brew.sh) and install the `carthage` tool on your system simply by running `brew update` and `brew install carthage`. (note: if you previously installed the binary version of Carthage, you should delete `/Library/Frameworks/CarthageKit.framework`).

* **From source:** If you’d like to run the latest development version (which may be highly unstable or incompatible), simply clone the `master` branch of the repository, then run `make install`. Requires Xcode 


2. **Build dependencies**. Open a terminal window in the project folder and execute this command:

```
carthage update --platform iOS
```


3. **Run the app**. Open WeatherLondon.xcodeprojworkspace and Command Key + R


4. **Running tests**. Open WeatherLondon.xcworkspace and Command Key + U


## With more time

- Build a sleeker UI. I mostly concentrate my efforts in Architecture.
- Remove Loopable and parse data with **Decodable** protocol
- I would cache data and store ir locally
- DIfferent targets, so we can test real Remote data and a Mock (Stubs) local environment.


## Architecture

- Using Swift 4.2 / XCode 10

- I like to use as few external libraries as possible. They introduce code who is a bit outside our control.

- For network request I will be using Alamofire. Nowadays all network layer can be done withouth Alamofire and using URLSession class, but Alamofire is a long established network layer library and for this exercise I prefer using it.

- No SwiftyJSON or object parser, as data is in simple format, I don´t feel the need to use it. Also in Swift 4 this can be done easily with the Decodable protocol.

- Kingfisher for Image caching.

- In an ideal scenario I would use SSL Pinning, HTTPS is not just enough security, all requests must be SSL pinned, this could be done with the Alamofire feature it has for this.

- Using MVVM architecture with Coordinators (MVVM-C). I know VIPER Architecture too, but fits only in few scenarios, requires many coding and fits in scenarios that requirements does not change often. As for Coordinators I am following sample presentacion that Soroush Khanlou did in NSSpain about Presenting Coordinators.

- All data in memory, no local storage. Enabling local storage could be nice for caching information. If requirements asked for local storage I would use Realm encrypted, no CoreData here.

- Model structs conforms to my Loopable protocol. This easily allows two things: debug values with CustomStringConvertible and build a dictionary of properties/values (handy for building JSON)

- Tests. I am also a fan of testing, things should be tested. Implemented Model and ViewModel tests.

- UI Color and Fonts. Using Zeplin style.

- UI. UI By code, using Apple AutoLayour. No Storyboards or NIBs

- Code styling. Using SwiftLint. I am a firm believer of unified coding styles

- Dependency manager Carthage. I am familiar with Cocoapods and Carthage, but I prefer Carthage as it does not "pollute" the project files.  

- Warnings as Errors. I treat warnings as errors, an app should not have even any warning.

- Static analizer. I run always statiuc analyzer for detecting any potential issue


## Network Layer

- Networking. I will be using my wrapper on top of Alamofire. I already have it done for Swift 4 at https://github.com/pabloroca/PR2StudioSwift. Installed automatically via a Carthage dependency

- Networking. If needed a second request, I would use Concurrent (with DispatchGroup) as it should perform better or serial using NSOperation dependencies

- Network requests recursively repeated if temporary error (increasing delay till 30 second)

- Network requests applied Apple recommendations (make alwqays the request, don´t timeout, ...)

- Network Log network requests/responses to console with different logs levels

- Networking. automatic cache by Alamofire is disabled for security reasons.


## Data Model

All data model is held in memory, I think it´s pointless to store it locally. If I needed to store it locally I would use an encrypted Realm data store, with that we can avoid reverse engineering of the results. 


## Sorting the project file

Using the pbxproj-sort.pl script included in the Scripts directly to sort the project file with keep the project in order as well as help demystify merge conflicts in the project file. 

To run the sorting script, use:

`./Scripts/pbxproj-sort.pl WeatherLondon.xcodeproj/project.pbxproj`
