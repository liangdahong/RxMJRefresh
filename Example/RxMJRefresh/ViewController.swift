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
import RxMJRefresh
import MJRefresh
import NSObject_Rx
import RxCocoaExtensions

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerRefresh: UIButton!
    @IBOutlet weak var headerStopRefresh: UIButton!
    @IBOutlet weak var footerRefresh: UIButton!
    @IBOutlet weak var footerStopRefresh: UIButton!
    @IBOutlet weak var footerNoDataRefresh: UIButton!
    @IBOutlet weak var footerRestMoreDataRefresh: UIButton!
    @IBOutlet weak var networkingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { })
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { })
        
        rx.viewWillAppear.take(1)
            .bind(to: tableView.mj_header!.rx.state(state: .begin))
            .disposed(by: rx.disposeBag)
        
        headerRefresh.rx.tap
            .bind(to: tableView.mj_header!.rx.state(state: .begin))
            .disposed(by: rx.disposeBag)
        
        headerStopRefresh.rx.tap
            .bind(to: tableView.mj_header!.rx.state(state: .end))
            .disposed(by: rx.disposeBag)
        
        footerRefresh.rx.tap
            .bind(to: tableView.mj_footer!.rx.state(state: .begin))
            .disposed(by: rx.disposeBag)
        
        footerStopRefresh.rx.tap
            .bind(to: tableView.mj_footer!.rx.state(state: .end))
            .disposed(by: rx.disposeBag)
        
        footerNoDataRefresh.rx.tap
            .bind(to: tableView.mj_footer!.rx.state(state: .noMoreData))
            .disposed(by: rx.disposeBag)
        
        footerRestMoreDataRefresh.rx.tap
            .bind(to: tableView.mj_footer!.rx.state(state: .resetNoMoreData))
            .disposed(by: rx.disposeBag)
        
        URLSession.shared.rx
            .response(request: .init(url: URL(string: "https://www.baidu.com/")!))
            .map { String(data: $0.data, encoding: .utf8) }
            .bind(to: networkingLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        tableView.mj_header?.rx.refreshing
            .subscribe(onNext: { _ in
                print("触发了下拉刷新 👇🏻")
            })
            .disposed(by: rx.disposeBag)
        
        tableView.mj_footer?.rx.refreshing
            .subscribe(onNext: { _ in
                print("触发了上拉刷新 👆🏻 ")
            })
            .disposed(by: rx.disposeBag)
        
        tableView.mj_header?.rx.refreshing
            .bind(to: tableView.mj_header!.rx.state(state: .end),
                  tableView.mj_footer!.rx.state(state: .begin))
            .disposed(by: rx.disposeBag)
    }
}
