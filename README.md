<p align="center">
   <img width="750" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/SwiftKit.png?token=ACZQQFRDMCNQJJK5HOTE7HC4ZXTOK" alt="SwiftKit Header Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift 5.0">
   </a>
   <a href="https://twitter.com/SvenTiigi/">
      <img src="https://img.shields.io/badge/Twitter-@SvenTiigi-blue.svg?style=flat" alt="Twitter">
   </a>
</p>

<br/>

<p align="center">
SwiftKit enables you to easily generate cross platform Swift-Frameworks via your command line.<br/>
It is the best way to start your next Open-Source Swift Framework.<br/>
SwiftKit is inspired by <a href="https://github.com/JohnSundell/SwiftPlate">SwiftPlate</a>
</p>

<br/>

<p align="center">
  <kbd><img width="800" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/SwiftKitDemo.gif?token=ACZQQFXOJIIBNFKO2H3VEUS4Z3MSO" alt="SwiftKit Demo GIF"></kbd>
</p>

<br/>

## Features

- [x] Support for `iOS`, `tvOS`, `watchOS` and `macOS`
- [x] `CocoaPods`, `Carthage` and `Swift Package Manager` compatibility
- [x] Predefined `README.md` template
- [x] Fastlane already integrated for `tests` and `release`
- [x] `Jazzy` to generate documentation
- [x] `SwiftLint` Build-Phase integrated

## Installation

### Homebrew

[Homebrew](https://brew.sh/) is a free and open-source software package management system that simplifies the installation of software on Apple's macOS operating system.

```bash
$ brew install swiftkit
```

### Mint

[Mint](https://github.com/yonaskolb/Mint) is a package manager that installs and runs Swift command line tool packages.

```bash
$ mint install SvenTiigi/SwiftKit
```

## Usage

To create a new Kit inside a new directory simply run:

```bash
$ swiftkit new MyAwesomeKit
```

If you already created a directory for example `MyAwesomeKit` and you want to create the Kit inside this directory simply run:

```bash
$ swiftkit new
```

## Kit-Structure

### Fastlane

Every generated Kit will come along with a predefined `Fastfile`.

#### tests-Lane

The `tests` lane will run your Unit-Tests and verify that your Kit is `Carthage` and `CocoaPods` compatible.

```bash
$ fastlane ios tests
```

### release-lane

The `release` lane will allow you to release a new version of your Kit.

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

### ReadMe

A `README.md` template will be automatically created inside your Kit. It contains default sections like `Example`, `Installation` and `Usage`. Please feel free to update the ReadMe to your needs.

<p align="center">
   <img src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/TemplateReadMe.png?token=ACZQQFWOBACXKQBG7JB7QFK4Z3OMI" alt="Template ReadMe">
</p>
