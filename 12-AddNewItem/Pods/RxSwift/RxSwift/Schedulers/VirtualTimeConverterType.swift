//
//  VirtualTimeConverterType.swift
//  Rx
//
//  Created by Krunoslav Zaher on 12/23/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation

/**
Parametrization for virtual time used by `VirtualTimeScheduler`s.
*/
public protocol VirtualTimeConverterType {
    /**
     Virtual time unit used that represents ticks of virtual clock.
    */
    associatedtype VirtualTimeUnit

    /**
     Virtual time unit used to represent differences of virtual times.
    */
    associatedtype VirtualTimeIntervalUnit

    /**
     Converts virtual time to real time.
     
     - parameter virtualTime: Virtual time to convert to `NSDate`.
     - returns: `NSDate` corresponding to virtual time.
    */
    func convertFromVirtualTime(virtualTime: VirtualTimeUnit) -> RxTime

    /**
     Converts real time to virtual time.
     
     - parameter time: `NSDate` to convert to virtual time.
     - returns: Virtual time corresponding to `NSDate`.
    */
    func convertToVirtualTime(time: RxTime) -> VirtualTimeUnit

    /**
     Converts from virtual time interval to `NSTimeInterval`.
     
     - parameter virtualTimeInterval: Virtual time interval to convert to `NSTimeInterval`.
     - returns: `NSTimeInterval` corresponding to virtual time interval.
    */
    func convertFromVirtualTimeInterval(virtualTimeInterval: VirtualTimeIntervalUnit) -> RxTimeInterval

    /**
     Converts from virtual time interval to `NSTimeInterval`.
     
     - parameter timeInterval: `NSTimeInterval` to convert to virtual time interval.
     - returns: Virtual time interval corresponding to time interval.
    */
    func convertToVirtualTimeInterval(timeInterval: RxTimeInterval) -> VirtualTimeIntervalUnit

    /**
     Offsets virtual time by virtual time interval.
     
     - parameter time: Virtual time.
     - parameter offset: Virtual time interval.
     - returns: Time corresponding to time offsetted by virtual time interval.
    */
    func offsetVirtualTime(time time: VirtualTimeUnit, offset: VirtualTimeIntervalUnit) -> VirtualTimeUnit

    /**
     This is aditional abstraction because `NSDate` is unfortunately not comparable.
     Extending `NSDate` with `Comparable` would be too risky because of possible collisions with other libraries.
    */
    func compareVirtualTime(lhs: VirtualTimeUnit, _ rhs: VirtualTimeUnit) -> VirtualTimeComparison
}

/**
 Virtual time comparison result.

 This is aditional abstraction because `NSDate` is unfortunately not comparable.
 Extending `NSDate` with `Comparable` would be too risky because of possible collisions with other libraries.
*/
public enum VirtualTimeComparison {
    /**
     lhs < rhs.
    */
    case LessThan
    /**
     lhs == rhs.
    */
    case Equal
    /**
     lhs > rhs.
    */
    case GreaterThan
}

extension VirtualTimeComparison {
    /**
     lhs < rhs.
    */
    var lessThen: Bool {
        if case .LessThan = self {
            return true
        }

        return false
    }

    /**
    lhs > rhs
    */
    var greaterThan: Bool {
        if case .GreaterThan = self {
            return true
        }

        return false
    }

    /**
     lhs == rhs
    */
    var equal: Bool {
        if case .Equal = self {
            return true
        }

        return false
    }
}
