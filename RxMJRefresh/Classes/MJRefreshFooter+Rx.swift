//    Copyright (c) 2021 hi@liangdahong.com < hi@liangdahong.com >
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.

import UIKit
import RxSwift
import RxCocoa
import class MJRefresh.MJRefreshFooter

public extension Reactive where Base: Viewable {
    
    enum FooterStatus {
        case begin
        case end
        case noMoreData
        case resetNoMoreData
    }
    
    var footerState: Binder<FooterStatus> {
        Binder(base) { _, state in self.state(state) }
    }
    
    func footerState(state: FooterStatus) -> Binder<()> {
        Binder(base) { _, _ in self.state(state) }
    }
}

private extension Reactive where Base: Viewable {
    
    func state(_ state: FooterStatus) {
        guard let footer = base.contentScrollView.mj_footer else { return }
        switch state {
        case .begin:
            footer.beginRefreshing()
        case .end:
            footer.endRefreshing()
        case .noMoreData:
            footer.endRefreshingWithNoMoreData()
        case .resetNoMoreData:
            footer.resetNoMoreData()
        }
    }
}
