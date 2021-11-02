
import UIKit
import RxSwift
import RxCocoa
import MJRefresh

public extension Reactive where Base: Viewable {
    
    /// 当触发下拉刷新时发出信号
    var headerRefreshing: ControlEvent<()> {
        let source: Observable<()> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.contentScrollView.mj_header?.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    /// 当触发上拉加载时发出信号
    var footerRefreshing: ControlEvent<()> {
        let source: Observable<()> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.contentScrollView.mj_footer?.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
}
