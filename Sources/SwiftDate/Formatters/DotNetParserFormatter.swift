//
//  DotNetParserFormatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public class DOTNETParser: StringToDateTransformable {
	
	internal static let pattern = "\\/Date\\((-?\\d+)((?:[\\+\\-]\\d+)?)\\)\\/"
	
	public func parse(_ string: String) -> (seconds: TimeInterval, tz: TimeZone)? {
		do {
			let parser = try NSRegularExpression(pattern: DOTNETParser.pattern, options: .caseInsensitive)
			guard let match = parser.firstMatch(in: string, options: .reportCompletion, range: NSRange(location: 0, length: string.count)) else {
				return nil
			}
			
			guard let milliseconds = TimeInterval((string as NSString).substring(with: match.range(at: 1))) else { return nil }
			
			// Parse timezone
			let raw_tz = ((string as NSString).substring(with: match.range(at: 2)) as NSString)
			guard raw_tz.length > 1 else {
				return nil
			}
			let tz_sign: String = raw_tz.substring(to: 1)
			if tz_sign != "+" && tz_sign != "-" {
				return nil
			}
			
			let tz_hours: String = raw_tz.substring(with: NSMakeRange(1, 2))
			let tz_minutes: String = raw_tz.substring(with: NSMakeRange(3, 2))
			
			let tz_offset = (Int(tz_hours)! * 60 * 60) + ( Int(tz_minutes)! * 60 )
			guard let tz_obj = TimeZone(secondsFromGMT: tz_offset) else {
				return nil
			}
			return ( (milliseconds / 1000), tz_obj )
		} catch {
			return nil
		}
	}
	
	public func toDate(_ string: String, region: Region) -> DateInRegion? {
		guard let result = self.parse(string) else { return nil }
		let adaptedRegion = Region(calendar: region.calendar, timezone: result.tz, locale: region.locale)
		return  DateInRegion(seconds: result.seconds, region: adaptedRegion)
	}
	
}

public class DOTNETFormatter: DateToStringTrasformable {
	
	public init() { }
	
	public func toString(_ date: DateRepresentable) -> String {
		let milliseconds = (date.date.timeIntervalSince1970 * 1000.0)
		let tzOffsets = (date.region.timezone.secondsFromGMT(for: date.date) / 3600)
		let formattedStr = String(format: "/Date(%.0f%+03d00)/", milliseconds,tzOffsets)
		return formattedStr
	}
	
}
