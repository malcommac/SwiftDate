//
//  DateComponents+Math.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 11/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public prefix func - (dateComponents: DateComponents) -> DateComponents {
	var invertedCmps = DateComponents()
	
	DateComponents.allComponents.forEach { component in
		let value = dateComponents.value(for: component)
		if value != nil && value != Int(NSDateComponentUndefined) {
			invertedCmps.setValue(-value!, for: component)
		}
	}
	return invertedCmps
}

public func + (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
	return lhs.add(components: rhs)
}

public func - (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
	return lhs.add(components: rhs, multipler: -1)
}

public extension DateComponents {
	
	public var dateInRegion: DateInRegion? {
		do {
			return try DateInRegion(components: self)
		} catch {
			return nil
		}
	}
	
	internal func add(components: DateComponents, multipler: Int = 1) -> DateComponents {
		let lhs = self
		let rhs = components
		
		var newCmps = DateComponents()
		let flagSet = DateComponents.allComponents
		flagSet.forEach { component in
			let left = lhs.value(for: component)
			let right = rhs.value(for: component)
			
			if left != nil && right != nil && left != Int(NSDateComponentUndefined) && right != Int(NSDateComponentUndefined) {
				let value = left! + (right! * multipler)
				newCmps.setValue(value, for: component)
			}
		}
		return newCmps
	}
	
	internal func toComponentsDict() -> [Calendar.Component : Int] {
		var list: [Calendar.Component : Int] = [:]
		DateComponents.allComponents.forEach { component in
			let value = self.value(for: component)
			if value != nil && value != Int(NSDateComponentUndefined) {
				list[component] = value!
			}
		}
		return list
	}
	
	
}
