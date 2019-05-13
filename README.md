<p align="center">
   <img width="750" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/SwiftKit.png" alt="SwiftKit Header Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift 5.0">
   </a>
   <a href="https://travis-ci.com/SvenTiigi/SwiftKit">
      <img src="https://travis-ci.com/SvenTiigi/SwiftKit.svg?branch=master" alt="Build Status">
   </a>
   <a href="https://github.com/SvenTiigi/SwiftKit/releases">
      <img src="https://img.shields.io/github/release/SvenTiigi/SwiftKit.svg" alt="Version">
   </a>
   <a href="https://sventiigi.github.io/SwiftKit">
      <img src="https://github.com/SvenTiigi/SwiftKit/blob/gh-pages/badge.svg" alt="Documentation">
   </a>
   <a href="https://github.com/yonaskolb/Mint">
      <img src="https://img.shields.io/badge/Mint-compatible-brightgreen.svg" alt="Mint">
   </a>
   <a href="https://brew.sh">
      <img src="https://img.shields.io/badge/Homebrew-compatible-brightgreen.svg" alt="brew">
   </a>
   <a href="https://twitter.com/SvenTiigi/">
      <img src="https://img.shields.io/badge/Twitter-@SvenTiigi-blue.svg?style=flat" alt="Twitter">
   </a>
</p>

<br/>

<p align="center">
SwiftKit enables you to easily generate a cross platform Swift Framework from your command line.<br/>
It is the best way to start your next Open-Source Swift Framework 📦.<br/>
SwiftKit is inspired by <a href="https://github.com/JohnSundell/SwiftPlate">SwiftPlate</a>
</p>

<br/>

<p align="center">
  <img width="800" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/SwiftKitTerminalDemo.gif" alt="SwiftKit Terminal Demo">
</p>

## Features

- [x] Generated Kit supports `iOS`, `tvOS`, `watchOS` and `macOS`
- [x] `CocoaPods`, `Carthage` and `Swift Package Manager` compatibility
- [x] `README.md` template
- [x] Fastlane already integrated for `tests` and `release`
- [x] `Jazzy` to generate documentation
- [x] `SwiftLint` Build-Phase integrated
- [x] `CI-Service` configuration templates included (Travis, GitLab)
- [x] Automatically checks if the Kit name is already taken on `CocoaPods`

## Installation

### Mint 🌱

[Mint](https://github.com/yonaskolb/Mint) is a package manager that installs and runs Swift command line tool packages.

```bash
$ mint install SvenTiigi/SwiftKit
```

### Homebrew 🍺

[Homebrew](https://brew.sh/) is a free and open-source software package management system that simplifies the installation of software on Apple's macOS operating system.

```bash
$ brew tap SvenTiigi/SwiftKit
$ brew install swiftkit
```

## Update

To update SwiftKit to the latest version simply run:

```bash
$ swiftkit update
```
> The `update` command will only work if SwiftKit is installed via either Mint 🌱 or Homebrew 🍺

## Usage 👨‍💻

To create a new Kit simply run:

```bash
$ swiftkit new MyAwesomeKit
```
> This will create a new folder in your current directory named by the name of your Kit

To create a Kit inside the current directory simply run:

```bash
$ swiftkit new
```
> This will infer the Kit name based on your directory name

If you wish to open the Xcode project after your Kit has been generated simply run:

```bash
$ swiftkit new MyAwesomeKit --open
```
> Head over to the [`Arguments`](https://github.com/SvenTiigi/SwiftKit#arguments) section to learn more about the available arguments

In default SwiftKit will create a Kit that supports `iOS`, `tvOS`, `watchOS`, `macOS`. If you want to support only certain Targets simply run:

```bash
$ swiftkit new MyAwesomeKit --target iOS --target tvOS
```
> This will create a Kit which only supports `iOS` and `tvOS`

## Kit-Structure 📦

The upcoming sections will explain the structure of your generated Kit in detail.

<img style="float: right" align="right" width="100" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/xcode-logo.png" alt="Xcode Logo">

### Xcode Project Structure

In the generated Xcode project you will find four important directories.

| Directory | Description |
| --- | --- |
| [`Sources`](https://github.com/SvenTiigi/SwiftKit/tree/master/Template/Sources) | Where you place your Swift source files |
| [`Tests`](https://github.com/SvenTiigi/SwiftKit/tree/master/Template/Tests) | Place your Unit-Tests files |
| [`Example`](https://github.com/SvenTiigi/SwiftKit/tree/master/Template/Example) | The iOS application example for your Kit |
| [`Configs`](https://github.com/SvenTiigi/SwiftKit/tree/master/Template/Configs) | All config files like Plist, Package.swift, Podspec, etc. |

<img style="float: right" align="right" width="100" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/swift-file-logo.png" alt="Swift File Logo">

### Kit.swift

In the aforementioned `Sources` directory you will find one Swift file which is named by your Kit.

```swift
// Include Foundation
@_exported import Foundation
```

> This [file](https://github.com/SvenTiigi/SwiftKit/blob/master/Template/Sources/KITPROJECT.swift) is used to inherit the import of `Foundation` when importing your Kit.

<a href="https://fastlane.tools/"><img style="float: right" align="right" width="100" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/fastlane-logo.png" alt="Fastlane Logo"></a>

### Fastlane

Every generated Kit will come along with a predefined [`Fastfile`](https://github.com/SvenTiigi/SwiftKit/blob/master/Template/fastlane/Fastfile).

##### tests-Lane

The `tests` lane will run your Unit-Tests and verify that your Kit is `Carthage` and `CocoaPods` compatible.

```bash
$ fastlane ios tests
```

#### release-lane

The `release` lane will allow you to automatically release a new version of your Kit for `Carthage`/`GitHub` and `CocoaPods`.

```bash
$ fastlane ios release version:1.1.0
```

The lane verifies various aspects of your Kit.

| Step | Description |
| --- | --- |
| 1 | Ensure your are on a clean master branch |
| 2 | Run `tests` lane |
| 3 | Increment version |
| 4 | Add and push Git tag |
| 5 | Pushes the Podspec via `pod trunk push` |

> ☝️ Please ensure you have registered your machine with [`pod trunk register`](https://guides.cocoapods.org/making/getting-setup-with-trunk.html) in order to successfully push the Podspec to CocoaPods

<img style="float: right" align="right" width="100" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/markdown-logo.png" alt="Markdown Logo">

### ReadMe

A [`README.md`](https://github.com/SvenTiigi/SwiftKit/blob/master/Template/README.md) template will be automatically created inside your Kit. It contains default sections like `Example`, `Installation` and `Usage`. Please feel free to update the ReadMe to your needs.

<p align="center">
   <kbd><img src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/TemplateReadMe.png" alt="Template ReadMe"></kbd>
</p>

## Arguments

SwiftKit supports arguments when launched. Following arguments are supported:

| Long parameter | Short parameter | Description
| ----------- | ----------- | -------------- |
| `--target` | `-t` | The Target that should be included in your Kit 📱 |
| `--destination` | `-d` | Where the generated Kit should be saved 💾 |
| `--kit-name` | `-k` | The name of your Kit 📦 |
| `--name` | `-n` | Your name 👨‍💻 |
| `--email` | `-e` | Your email address 📫 |
| `--url` | `-u` | The repository url 🌎 |
| `--ci-service` | `-c` | The CI-Service 🛠 (`1=Travis CI`, `2=GitLab CI`) |
| `--organization` | `-o` | The name of your organization 🏢 |
| `--organization-identifier` | `-i` | The organization identifier 🖋 |
| `--force` | `-f` | Generate the Kit without confirmation ✅ |
| `--open` | `-o` | Open the Xcode project after your Kit has been generated 📂 |

Example with all arguments been set.

```bash
swiftkit new \
	--target iOS \
	--target tvOS \
	--target watchOS \
	--target macOS \
	--destination ~/Desktop/MyAwesomeKit \
	--kit-name MyAwesomeKit \
	--name SvenTiigi \
	--email sven.tiigi@gmail.com \
	--url https://github.com/SvenTiigi/MyAwesomeKit \
	--ci-service 1 \
	--organization SvenTiigi \
	--organization-identifier de.tiigi \
	--force \
	--open
```

## Contributing
Contributions are very welcome 🙌 🤓

## Credits
SwiftKit is inspired by [`SwiftPlate`](https://github.com/JohnSundell/SwiftPlate) from [JohnSundell](https://twitter.com/johnsundell)

## License

```
SwiftKit
Copyright (c) 2019 Sven Tiigi <sven.tiigi@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
