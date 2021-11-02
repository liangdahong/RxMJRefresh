# RxMJRefresh

[![CI Status](https://img.shields.io/travis/hi@liangdahong.com/RxMJRefresh.svg?style=flat)](https://travis-ci.org/hi@liangdahong.com/RxMJRefresh)
[![Version](https://img.shields.io/cocoapods/v/RxMJRefresh.svg?style=flat)](https://cocoapods.org/pods/RxMJRefresh)
[![License](https://img.shields.io/cocoapods/l/RxMJRefresh.svg?style=flat)](https://cocoapods.org/pods/RxMJRefresh)
[![Platform](https://img.shields.io/cocoapods/p/RxMJRefresh.svg?style=flat)](https://cocoapods.org/pods/RxMJRefresh)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RxMJRefresh is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxMJRefresh'
```

```swift
rx.viewWillAppear.take(1)
    .bind(to: tableView.rx.headerState(state: .begin))
    .disposed(by: rx.disposeBag)

headerRefresh.rx.tap
    .bind(to: tableView.rx.headerState(state: .begin))
    .disposed(by: rx.disposeBag)

headerStopRefresh.rx.tap
    .bind(to: tableView.rx.headerState(state: .end))
    .disposed(by: rx.disposeBag)

footerRefresh.rx.tap
    .bind(to: tableView.rx.footerState(state: .begin))
    .disposed(by: rx.disposeBag)

footerStopRefresh.rx.tap
    .bind(to: tableView.rx.footerState(state: .end))
    .disposed(by: rx.disposeBag)

footerNoDataRefresh.rx.tap
    .bind(to: tableView.rx.footerState(state: .noMoreData))
    .disposed(by: rx.disposeBag)

footerRestMoreDataRefresh.rx.tap
    .bind(to: tableView.rx.footerState(state: .resetNoMoreData))
    .disposed(by: rx.disposeBag)
```

## Author

hi@liangdahong.com

## License

RxMJRefresh is available under the MIT license. See the LICENSE file for more info.
