# Practice001
An image viewer over 3rd party data sources

# Purpose
This iOS app, written in Swift, is to put into practice some thoughts over the solution to a simple image viewer, comprising a search result list and an image detail view for each list item. The image view will be visiting a backend image server, either a public 3rd part one or a private one. The solution shall be extendable to more other image servers, with a minimal code change.

# Image Server
* Flickr
* Imgur
* (Still some other famouse provider...)

# Architecture
* MVVM is chosen in this project.
* KVO is employed to accomplish data binding between ViewController and ViewModel.

![](https://github.com/zjkuang/Practice001/blob/master/Architecture.png)

# UX Thoughts
* Image caching - A "Cachable" protocol is developed so that any class or struct comforming to Cachable will automatically obtain cachability. In this project, (1) the thumbnail image, (2) detailed image, and (3) image info are all fetched from backend separately, therefore these three parts are all cached for a better UX.
* Paged loading - Scroll the list to bottom will automatically trigger the loading of next page.

# Output
* [This project](https://github.com/zjkuang/Practice001.git)  
* [JKCSImageServiceSwift](https://github.com/zjkuang/JKCSImageServiceSwift.git) - An SDK in SPM providing image service related facilities  
* [JKCSSwift](https://github.com/zjkuang/JKCSSwift.git) - An SDK in SPM providing some foundational types, facilities, and extensions  
* [SwiftVVM](https://github.com/zjkuang/XcodeTemplates.git) - A custom Xcode file template providing a pack of ViewController/XIB/ViewModel, with KVO data binding inside, as a starting point for MVVM
