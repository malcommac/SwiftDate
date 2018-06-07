//
//  DateFormatters.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public protocol DateToStringTrasformable {
	func toString(_ date: DateRepresentable) -> String
}

public protocol StringToDateTransformable {
	func toDate(_ string: String, region: Region) -> DateInRegion?
}

/// Format to represent a date to string
///
/// - isoCustom: custom iso format with explicit options set.
/// - iso: standard iso format. The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
/// - extended: Extended format. "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
/// - rss: The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
/// - altRSS: The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
/// - dotNet: The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
/// - httpHeader: The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
/// - custom: custom string format
/// - standard: A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
/// - date: Date only format (short = "2/27/17", medium = "Feb 27, 2017", long = "February 27, 2017", full = "Monday, February 27, 2017"
/// - time: Time only format (short = "2:22 PM", medium = "2:22:06 PM", long = "2:22:06 PM EST", full = "2:22:06 PM Eastern Standard Time"
/// - dateTime: Date/Time format (short = "2/27/17, 2:22 PM", medium = "Feb 27, 2017, 2:22:06 PM", long = "February 27, 2017 at 2:22:06 PM EST", full = "Monday, February 27, 2017 at 2:22:06 PM Eastern Standard Time"
public enum DateToStringStyles: DateToStringTrasformable {
	case isoCustom(_: ISOFormatter.Options)
	case iso
	case extended
	case rss
	case altRSS
	case dotNet
	case httpHeader
	case date(_: DateFormatter.Style)
	case time(_: DateFormatter.Style)
	case dateTime(_: DateFormatter.Style)
	case custom(_: String)
	case colloquial
	case colloquialCuston(_: ColloquialFormatter.Options)
	case standard
	
	public func toString(_ date: DateRepresentable) -> String {
		switch self {
		case .iso:						return ISOFormatter(options: [.withInternetDateTime]).toString(date)
		case .isoCustom(let options):	return ISOFormatter(options: options).toString(date)
		case .extended:					return date.formatterForRegion(format: DateFormats.extended).string(from: date.date)
		case .rss:						return date.formatterForRegion(format: DateFormats.rss).string(from: date.date)
		case .altRSS:					return date.formatterForRegion(format: DateFormats.altRSS).string(from: date.date)
		case .dotNet:					return DOTNETFormatter().toString(date)
		case .httpHeader:				return date.formatterForRegion(format: DateFormats.httpHeader).string(from: date.date)
		case .custom(let format):		return date.formatterForRegion(format: format).string(from: date.date)
		case .standard:					return date.formatterForRegion(format: DateFormats.standard).string(from: date.date)
		case .date(let style):
			return date.formatterForRegion(format: nil, configuration: {
				$0.dateStyle = style
				$0.timeStyle = .none
			}).string(from: date.date)
		case .time(let style):
			return date.formatterForRegion(format: nil, configuration: {
				$0.dateStyle = .none
				$0.timeStyle = style
			}).string(from: date.date)
		case .dateTime(let style):
			return date.formatterForRegion(format: nil, configuration: {
				$0.dateStyle = style
				$0.timeStyle = style
			}).string(from: date.date)
		case .colloquial:
			return ColloquialFormatter().toString(date)
		case .colloquialCuston(let options):
			return ColloquialFormatter(options: options).toString(date)
		}
	}
	
}

/// String to date transform
///
/// - iso: standard automatic iso parser (evaluate the date components automatically)
/// - isoCustom: custom iso parser with explicit parsing options
/// - extended: Extended format. "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
/// - rss: The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
/// - altRSS: The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
/// - dotNet: The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
/// - httpHeader: The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
/// - strict: custom string format with lenient options active
/// - custom: custom string format
/// - standard: A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
public enum StringToDateStyles: StringToDateTransformable {
	case iso
	case isoCustom(_: ISOParser.Options)
	case extended
	case rss
	case altRSS
	case dotNet
	case httpHeader
	case strict(_: String)
	case custom(_: String)
	case standard

	public func toDate(_ string: String, region: Region) -> DateInRegion? {
		switch self {
		case .iso:							return ISOParser(string: string)?.toDate(string, region: region)
		case .isoCustom(let options):		return ISOParser(string: string, options: options)?.toDate(string, region: region)
		case .custom(let format):			return DateInRegion(string, format: format, region: region)
		case .extended:						return DateInRegion(string, format: DateFormats.extended, region: region)
		case .rss:							return DateInRegion(string, format: DateFormats.rss, region: region)
		case .altRSS:						return DateInRegion(string, format: DateFormats.altRSS, region: region)
		case .dotNet:						return DOTNETParser().toDate(string, region: region)
		case .httpHeader:					return DateInRegion(string, format: DateFormats.httpHeader, region: region)
		case .standard:						return DateInRegion(string, format: DateFormats.standard, region: region)
		case .strict(let format):
			let formatter = DateFormatter.sharedFormatter(forRegion: region, format: format)
			formatter.isLenient = true
			guard let absDate = formatter.date(from: string) else { return nil }
			return DateInRegion(absDate, region: region)
		}
	}
}
