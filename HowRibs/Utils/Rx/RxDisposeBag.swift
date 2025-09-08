//
//  RxDisposeBag.swift
//  HowRibs
//
//  Created by Jae hyung Kim on 8/28/25.
//

import Foundation
import RxSwift
import ObjectiveC

fileprivate var disposeBagkey: UInt8 = 0

extension Reactive where Base: AnyObject {
    
    func syncDisposeBag<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }
    
    var disposeBag: DisposeBag {
        get {
            return syncDisposeBag { () -> DisposeBag in
                if let disposeBag = objc_getAssociatedObject(base, &disposeBagkey) as? DisposeBag {
                    return disposeBag
                }
                let disposeBag = DisposeBag()
                objc_setAssociatedObject(base, &disposeBagkey, disposeBag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeBag
            }
        }
        
        set {
            syncDisposeBag {
                objc_setAssociatedObject(base, &disposeBagkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
