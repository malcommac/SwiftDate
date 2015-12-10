//
//  DateInRegionHashable.swift
//  Pods
//
//  Created by Jeroen Houtzager on 04/11/15.
//
//

extension DateInRegion: Hashable {
    public var hashValue: Int {
        return absoluteTime.hashValue ^ region.hashValue
    }
}