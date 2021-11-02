
import UIKit
import RxSwift
import RxCocoa
import MJRefresh

// 对 MJRefreshComponent 增加 rx 扩展
public extension Reactive where Base: MJRefreshComponent {
    
    /// 当触发刷新时发出信号
    var refreshing: ControlEvent<()> {
        let source: Observable<()> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
}
