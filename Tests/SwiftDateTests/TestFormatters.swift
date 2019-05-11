//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

import SwiftDate
import XCTest

class TestFormatters: XCTestCase {

	public func datesList() -> [String: [String: String]] {
		return [
			"2017-07-22T18:27:02+02:00": [

				"dotnet": "/Date(1500740822000+0200)/",
				"rss": "Sat, 22 Jul 2017 18:27:02 +0200",
				"rss_alt": "22 Jul 2017 18:27:02 +0200",
				"sql": "2017-07-22T18:27:02.000+02",
				"iso": "2017-07-22T18:27:02+02:00"
			],
			"2017-02-03T06:30:12+01:00": [

				"dotnet": "/Date(1486099812000+0100)/",
				"rss": "Fri, 3 Feb 2017 06:30:12 +0100",
				"rss_alt": "3 Feb 2017 06:30:12 +0100",
				"sql": "2017-02-03T06:30:12.000+01",
				"iso": "2017-02-03T06:30:12+01:00"
			],
			"2016-03-31T10:57:44+02:00": [

				"dotnet": "/Date(1459414664000+0200)/",
				"rss": "Thu, 31 Mar 2016 10:57:44 +0200",
				"rss_alt": "31 Mar 2016 10:57:44 +0200",
				"sql": "2016-03-31T10:57:44.000+02",
				"iso": "2016-03-31T10:57:44+02:00"
			],
			"2016-07-23T17:05:31+02:00": [

				"dotnet": "/Date(1469286331000+0200)/",
				"rss": "Sat, 23 Jul 2016 17:05:31 +0200",
				"rss_alt": "23 Jul 2016 17:05:31 +0200",
				"sql": "2016-07-23T17:05:31.000+02",
				"iso": "2016-07-23T17:05:31+02:00"
			],
			"2017-05-15T11:26:36+02:00": [

				"dotnet": "/Date(1494840396000+0200)/",
				"rss": "Mon, 15 May 2017 11:26:36 +0200",
				"rss_alt": "15 May 2017 11:26:36 +0200",
				"sql": "2017-05-15T11:26:36.000+02",
				"iso": "2017-05-15T11:26:36+02:00"
			],
			"2018-03-27T20:50:37+02:00": [

				"dotnet": "/Date(1522176637000+0200)/",
				"rss": "Tue, 27 Mar 2018 20:50:37 +0200",
				"rss_alt": "27 Mar 2018 20:50:37 +0200",
				"sql": "2018-03-27T20:50:37.000+02",
				"iso": "2018-03-27T20:50:37+02:00"
			],
			"2018-02-16T14:52:52+01:00": [

				"dotnet": "/Date(1518789172000+0100)/",
				"rss": "Fri, 16 Feb 2018 14:52:52 +0100",
				"rss_alt": "16 Feb 2018 14:52:52 +0100",
				"sql": "2018-02-16T14:52:52.000+01",
				"iso": "2018-02-16T14:52:52+01:00"
			],
			"2016-01-10T16:55:35+01:00": [

				"dotnet": "/Date(1452441335000+0100)/",
				"rss": "Sun, 10 Jan 2016 16:55:35 +0100",
				"rss_alt": "10 Jan 2016 16:55:35 +0100",
				"sql": "2016-01-10T16:55:35.000+01",
				"iso": "2016-01-10T16:55:35+01:00"
			],
			"2017-05-02T23:53:44+02:00": [

				"dotnet": "/Date(1493762024000+0200)/",
				"rss": "Tue, 2 May 2017 23:53:44 +0200",
				"rss_alt": "2 May 2017 23:53:44 +0200",
				"sql": "2017-05-02T23:53:44.000+02",
				"iso": "2017-05-02T23:53:44+02:00"
			],
			"2017-05-13T20:05:38+02:00": [

				"dotnet": "/Date(1494698738000+0200)/",
				"rss": "Sat, 13 May 2017 20:05:38 +0200",
				"rss_alt": "13 May 2017 20:05:38 +0200",
				"sql": "2017-05-13T20:05:38.000+02",
				"iso": "2017-05-13T20:05:38+02:00"
			],
			"2017-10-04T17:25:36+02:00": [

				"dotnet": "/Date(1507130736000+0200)/",
				"rss": "Wed, 4 Oct 2017 17:25:36 +0200",
				"rss_alt": "4 Oct 2017 17:25:36 +0200",
				"sql": "2017-10-04T17:25:36.000+02",
				"iso": "2017-10-04T17:25:36+02:00"
			],
			"2016-04-14T11:58:58+02:00": [

				"dotnet": "/Date(1460627938000+0200)/",
				"rss": "Thu, 14 Apr 2016 11:58:58 +0200",
				"rss_alt": "14 Apr 2016 11:58:58 +0200",
				"sql": "2016-04-14T11:58:58.000+02",
				"iso": "2016-04-14T11:58:58+02:00"
			],
			"2016-10-03T13:15:37+02:00": [

				"dotnet": "/Date(1475493337000+0200)/",
				"rss": "Mon, 3 Oct 2016 13:15:37 +0200",
				"rss_alt": "3 Oct 2016 13:15:37 +0200",
				"sql": "2016-10-03T13:15:37.000+02",
				"iso": "2016-10-03T13:15:37+02:00"
			],
			"2015-08-23T16:28:34+02:00": [

				"dotnet": "/Date(1440340114000+0200)/",
				"rss": "Sun, 23 Aug 2015 16:28:34 +0200",
				"rss_alt": "23 Aug 2015 16:28:34 +0200",
				"sql": "2015-08-23T16:28:34.000+02",
				"iso": "2015-08-23T16:28:34+02:00"
			],
			"2016-09-04T19:52:29+02:00": [

				"dotnet": "/Date(1473011549000+0200)/",
				"rss": "Sun, 4 Sep 2016 19:52:29 +0200",
				"rss_alt": "4 Sep 2016 19:52:29 +0200",
				"sql": "2016-09-04T19:52:29.000+02",
				"iso": "2016-09-04T19:52:29+02:00"
			],
			"2016-05-09T14:09:55+02:00": [

				"dotnet": "/Date(1462795795000+0200)/",
				"rss": "Mon, 9 May 2016 14:09:55 +0200",
				"rss_alt": "9 May 2016 14:09:55 +0200",
				"sql": "2016-05-09T14:09:55.000+02",
				"iso": "2016-05-09T14:09:55+02:00"
			],
			"2016-05-11T02:58:47+02:00": [

				"dotnet": "/Date(1462928327000+0200)/",
				"rss": "Wed, 11 May 2016 02:58:47 +0200",
				"rss_alt": "11 May 2016 02:58:47 +0200",
				"sql": "2016-05-11T02:58:47.000+02",
				"iso": "2016-05-11T02:58:47+02:00"
			],
			"2017-04-08T01:49:29+02:00": [

				"dotnet": "/Date(1491608969000+0200)/",
				"rss": "Sat, 8 Apr 2017 01:49:29 +0200",
				"rss_alt": "8 Apr 2017 01:49:29 +0200",
				"sql": "2017-04-08T01:49:29.000+02",
				"iso": "2017-04-08T01:49:29+02:00"
			],
			"2017-03-14T04:06:47+01:00": [

				"dotnet": "/Date(1489460807000+0100)/",
				"rss": "Tue, 14 Mar 2017 04:06:47 +0100",
				"rss_alt": "14 Mar 2017 04:06:47 +0100",
				"sql": "2017-03-14T04:06:47.000+01",
				"iso": "2017-03-14T04:06:47+01:00"
			],
			"2016-05-31T14:31:50+02:00": [

				"dotnet": "/Date(1464697910000+0200)/",
				"rss": "Tue, 31 May 2016 14:31:50 +0200",
				"rss_alt": "31 May 2016 14:31:50 +0200",
				"sql": "2016-05-31T14:31:50.000+02",
				"iso": "2016-05-31T14:31:50+02:00"
			],
			"2015-09-22T08:28:16+02:00": [

				"dotnet": "/Date(1442903296000+0200)/",
				"rss": "Tue, 22 Sep 2015 08:28:16 +0200",
				"rss_alt": "22 Sep 2015 08:28:16 +0200",
				"sql": "2015-09-22T08:28:16.000+02",
				"iso": "2015-09-22T08:28:16+02:00"
			],
			"2016-08-11T06:53:56+02:00": [

				"dotnet": "/Date(1470891236000+0200)/",
				"rss": "Thu, 11 Aug 2016 06:53:56 +0200",
				"rss_alt": "11 Aug 2016 06:53:56 +0200",
				"sql": "2016-08-11T06:53:56.000+02",
				"iso": "2016-08-11T06:53:56+02:00"
			],
			"2018-03-27T19:49:32+02:00": [

				"dotnet": "/Date(1522172972000+0200)/",
				"rss": "Tue, 27 Mar 2018 19:49:32 +0200",
				"rss_alt": "27 Mar 2018 19:49:32 +0200",
				"sql": "2018-03-27T19:49:32.000+02",
				"iso": "2018-03-27T19:49:32+02:00"
			],
			"2017-03-04T21:04:51+01:00": [

				"dotnet": "/Date(1488657891000+0100)/",
				"rss": "Sat, 4 Mar 2017 21:04:51 +0100",
				"rss_alt": "4 Mar 2017 21:04:51 +0100",
				"sql": "2017-03-04T21:04:51.000+01",
				"iso": "2017-03-04T21:04:51+01:00"
			],
			"2016-09-19T10:22:17+02:00": [

				"dotnet": "/Date(1474273337000+0200)/",
				"rss": "Mon, 19 Sep 2016 10:22:17 +0200",
				"rss_alt": "19 Sep 2016 10:22:17 +0200",
				"sql": "2016-09-19T10:22:17.000+02",
				"iso": "2016-09-19T10:22:17+02:00"
			],
			"2016-01-09T08:24:32+01:00": [

				"dotnet": "/Date(1452324272000+0100)/",
				"rss": "Sat, 9 Jan 2016 08:24:32 +0100",
				"rss_alt": "9 Jan 2016 08:24:32 +0100",
				"sql": "2016-01-09T08:24:32.000+01",
				"iso": "2016-01-09T08:24:32+01:00"
			],
			"2018-05-16T02:33:15+02:00": [

				"dotnet": "/Date(1526430795000+0200)/",
				"rss": "Wed, 16 May 2018 02:33:15 +0200",
				"rss_alt": "16 May 2018 02:33:15 +0200",
				"sql": "2018-05-16T02:33:15.000+02",
				"iso": "2018-05-16T02:33:15+02:00"
			],
			"2016-11-09T14:42:29+01:00": [

				"dotnet": "/Date(1478698949000+0100)/",
				"rss": "Wed, 9 Nov 2016 14:42:29 +0100",
				"rss_alt": "9 Nov 2016 14:42:29 +0100",
				"sql": "2016-11-09T14:42:29.000+01",
				"iso": "2016-11-09T14:42:29+01:00"
			],
			"2017-09-18T05:07:13+02:00": [

				"dotnet": "/Date(1505704033000+0200)/",
				"rss": "Mon, 18 Sep 2017 05:07:13 +0200",
				"rss_alt": "18 Sep 2017 05:07:13 +0200",
				"sql": "2017-09-18T05:07:13.000+02",
				"iso": "2017-09-18T05:07:13+02:00"
			],
			"2016-11-08T19:03:38+01:00": [

				"dotnet": "/Date(1478628218000+0100)/",
				"rss": "Tue, 8 Nov 2016 19:03:38 +0100",
				"rss_alt": "8 Nov 2016 19:03:38 +0100",
				"sql": "2016-11-08T19:03:38.000+01",
				"iso": "2016-11-08T19:03:38+01:00"
			],
			"2017-08-25T04:33:32+02:00": [

				"dotnet": "/Date(1503628412000+0200)/",
				"rss": "Fri, 25 Aug 2017 04:33:32 +0200",
				"rss_alt": "25 Aug 2017 04:33:32 +0200",
				"sql": "2017-08-25T04:33:32.000+02",
				"iso": "2017-08-25T04:33:32+02:00"
			],
			"2016-06-07T15:10:47+02:00": [

				"dotnet": "/Date(1465305047000+0200)/",
				"rss": "Tue, 7 Jun 2016 15:10:47 +0200",
				"rss_alt": "7 Jun 2016 15:10:47 +0200",
				"sql": "2016-06-07T15:10:47.000+02",
				"iso": "2016-06-07T15:10:47+02:00"
			],
			"2016-12-02T14:54:10+01:00": [

				"dotnet": "/Date(1480686850000+0100)/",
				"rss": "Fri, 2 Dec 2016 14:54:10 +0100",
				"rss_alt": "2 Dec 2016 14:54:10 +0100",
				"sql": "2016-12-02T14:54:10.000+01",
				"iso": "2016-12-02T14:54:10+01:00"
			],
			"2016-02-11T11:48:21+01:00": [

				"dotnet": "/Date(1455187701000+0100)/",
				"rss": "Thu, 11 Feb 2016 11:48:21 +0100",
				"rss_alt": "11 Feb 2016 11:48:21 +0100",
				"sql": "2016-02-11T11:48:21.000+01",
				"iso": "2016-02-11T11:48:21+01:00"
			],
			"2018-01-23T17:44:12+01:00": [

				"dotnet": "/Date(1516725852000+0100)/",
				"rss": "Tue, 23 Jan 2018 17:44:12 +0100",
				"rss_alt": "23 Jan 2018 17:44:12 +0100",
				"sql": "2018-01-23T17:44:12.000+01",
				"iso": "2018-01-23T17:44:12+01:00"
			],
			"2016-05-09T22:11:28+02:00": [

				"dotnet": "/Date(1462824688000+0200)/",
				"rss": "Mon, 9 May 2016 22:11:28 +0200",
				"rss_alt": "9 May 2016 22:11:28 +0200",
				"sql": "2016-05-09T22:11:28.000+02",
				"iso": "2016-05-09T22:11:28+02:00"
			],
			"2015-06-27T04:15:55+02:00": [

				"dotnet": "/Date(1435371355000+0200)/",
				"rss": "Sat, 27 Jun 2015 04:15:55 +0200",
				"rss_alt": "27 Jun 2015 04:15:55 +0200",
				"sql": "2015-06-27T04:15:55.000+02",
				"iso": "2015-06-27T04:15:55+02:00"
			],
			"2017-08-05T16:04:03+02:00": [

				"dotnet": "/Date(1501941843000+0200)/",
				"rss": "Sat, 5 Aug 2017 16:04:03 +0200",
				"rss_alt": "5 Aug 2017 16:04:03 +0200",
				"sql": "2017-08-05T16:04:03.000+02",
				"iso": "2017-08-05T16:04:03+02:00"
			],
			"2015-11-19T22:20:40+01:00": [

				"dotnet": "/Date(1447968040000+0100)/",
				"rss": "Thu, 19 Nov 2015 22:20:40 +0100",
				"rss_alt": "19 Nov 2015 22:20:40 +0100",
				"sql": "2015-11-19T22:20:40.000+01",
				"iso": "2015-11-19T22:20:40+01:00"
			],
			"2017-06-20T14:49:19+02:00": [

				"dotnet": "/Date(1497962959000+0200)/",
				"rss": "Tue, 20 Jun 2017 14:49:19 +0200",
				"rss_alt": "20 Jun 2017 14:49:19 +0200",
				"sql": "2017-06-20T14:49:19.000+02",
				"iso": "2017-06-20T14:49:19+02:00"
			]
		]
	}

	/*public func testGenerateSomeRandomDates() {
		var total = ""
		let upperBound = DateInRegion()
		let lowerBound = (upperBound - 3.years)
		let randomDates = DateInRegion.randomDates(count: 40, between: lowerBound, and: upperBound)
		randomDates.forEach {
			let adjustedDateNoMS = $0.toISO().toISODate()!
			total += "\"\($0.toISO())\" : [\n\t"
			total += "\n\t" + "\"dotnet\": \"\(adjustedDateNoMS.toDotNET())\","
			total += "\n\t" + "\"rss\": \"\(adjustedDateNoMS.toRSS(alt: false))\","
			total += "\n\t" + "\"rss_alt\": \"\(adjustedDateNoMS.toRSS(alt: true))\","
			total += "\n\t" + "\"sql\": \"\(adjustedDateNoMS.toSQL())\","
			total += "\n\t" + "\"iso\": \"\(adjustedDateNoMS.toISO())\""
			total += "\n],\n"
		}
		print("\(total)")
	}*/

	public func testDotNETFormatter() {
		SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.english)
		datesList().forEach {
			XCTTestFormatterParser(dateStr: $0.key, expected: $0.value["dotnet"]!, type: "dotnet", region: SwiftDate.defaultRegion)
		}
	}

	public func testRSSFormatter() {
		SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.english)
		datesList().forEach {
			XCTTestFormatterParser(dateStr: $0.key, expected: $0.value["rss"]!, type: "rss", region: SwiftDate.defaultRegion)
		}
	}

	public func testRSSAltFormatter() {
		SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.english)
		datesList().forEach {
			XCTTestFormatterParser(dateStr: $0.key, expected: $0.value["rss_alt"]!, type: "rss_alt", region: SwiftDate.defaultRegion)
		}
	}

	public func testSQLFormatter() {
		SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.english)
		datesList().forEach {
			XCTTestFormatterParser(dateStr: $0.key, expected: $0.value["sql"]!, type: "sql", region: SwiftDate.defaultRegion)
		}
	}

	public func testISOFormatter() {
		SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.english)
		datesList().forEach {
			XCTTestFormatterParser(dateStr: $0.key, expected: $0.value["iso"]!, type: "iso", region: SwiftDate.defaultRegion)
		}
	}

	func XCTTestFormatterParser(dateStr: String, expected: String, type: String, region: Region = SwiftDate.defaultRegion) {
		guard let srcDate = dateStr.toDate("yyyy-MM-dd'T'HH:mm:ssZZZZZ", region: SwiftDate.defaultRegion) else {
			XCTFail("Failed to correctly parse date: '\(dateStr)'")
			return
		}

		let dateAsStr: String = dateToString(date: srcDate, format: type)
		XCTAssert( (dateAsStr == expected),
				   "Failed to convert date '\(srcDate.description)' to \(type) format. Expected '\(expected)', got '\(dateAsStr)'")

		guard let decodedSrcDate = stringToDate(string: dateAsStr, format: type, region: region) else {
			XCTFail("Failed to convert date string to date of type \(type): \(dateAsStr)")
			return
		}
		XCTAssert( (srcDate == decodedSrcDate),
				   "Failed to validate formatter. Got '\(decodedSrcDate)' expecting '\(srcDate)'")
	}

	func dateToString(date srcDate: DateInRegion, format: String) -> String {
		switch format {
		case "dotnet":	return srcDate.toDotNET()
		case "rss":		return srcDate.toRSS(alt: false)
		case "rss_alt":	return srcDate.toRSS(alt: true)
		case "sql":		return srcDate.toSQL()
		case "iso":		return srcDate.toISO()
		default:
			XCTFail("Unsupported type: \(format)")
			return ""
		}
	}

	func stringToDate(string: String, format: String, region: Region) -> DateInRegion? {
		switch format {
		case "dotnet":	return string.toDotNETDate(region: region)
		case "rss":		return string.toRSSDate(alt: false, region: region)
		case "rss_alt":	return string.toRSSDate(alt: true, region: region)
		case "sql":		return string.toSQLDate(region: region)
		case "iso":		return string.toISODate(nil, region: region)
		default:
			XCTFail("Unsupported type: \(format)")
			return nil
		}
	}

	func testTZInISOParser() {
		let gmtTimezone = "2017-08-05T16:04:03".toISODate(region: Region.ISO)! // force timezone
		let timezoneInDate = "2017-08-05T16:04:03+02:00".toISODate()! // parse from iso
		XCTAssert(gmtTimezone.region.timeZone.secondsFromGMT() == 0, "ISO Date does not contains timezone (is gmt)")
		XCTAssert(timezoneInDate.region.timeZone.secondsFromGMT() == 7200, "ISO Date does not contains timezone (is gmt)")
	}

	func testRSSAltLocale() {
		let regionAny = Region(calendar: Calendars.buddhist, zone: Zones.indianMayotte, locale: Locales.italian)
		// region must not use passed locale to perform parsing but only locale as final output
		let date1 = "Tue, 20 Jun 2017 14:49:19 +0200".toRSSDate(alt: false, region: regionAny)
		let date2 = "20 Jun 2017 14:49:19 +0200".toRSSDate(alt: true, region: regionAny)
		XCTAssertNotNil(date1, "Wrong RSS Date region")
		XCTAssertNotNil(date2, "Wrong RSS Alt Date region")
	}

	func testTimeInterval_Clock() {
		let value = (2.hours + 5.minutes).timeInterval.toClock()
		XCTAssert(value == "02:05:00", "Failed to format clock")
		#if os(Linux)
		let zeroBehavior = DateComponentsFormatter.ZeroFormattingBehavior(rawValue: 14)
		let value2 = (4.minutes + 50.minutes).timeInterval.toClock(zero: zeroBehavior)
		XCTAssert(value2 == "54:00", "Failed to format clock")
		#else
		let value2 = (4.minutes + 50.minutes).timeInterval.toClock(zero: DateComponentsFormatter.ZeroFormattingBehavior.dropAll)
		XCTAssert(value2 == "54", "Failed to format clock")
		#endif
	}

	func testFormatterCustom() {
		let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let date = DateInRegion(year: 2015, month: 1, day: 15, hour: 20, minute: 00, second: 5, nanosecond: 0, region: rome)
		let fixedFormat = date.toFormat("MMM dd yyyy", locale: Locales.english)
		let regionFormat = date.toFormat("MMM dd yyyy")
		XCTAssert( fixedFormat == "Jan 15 2015", "Failed to format with fixed locale")
		XCTAssert( regionFormat == "gen 15 2015", "Failed to format with standard locale")
	}

	func testTimeInterval_FormatterUnits() {
		// for TimeInterval
		let values = (36.hours + 2.days + 1.weeks).timeInterval.toUnits([.day, .hour])
		XCTAssert(values[.hour] == 12 && values[.day] == 10, "Failed to extract day components")

		let singleValue = (1.days).timeInterval.toUnit(.minute)
		XCTAssert(singleValue == 1440, "Failed to extract single date component")
	}

	func testTimeInterval_Formatter() {
		let value1 = (2.hours + 5.minutes + 32.seconds).timeInterval.toString(options: {
			$0.unitsStyle = .full
			$0.collapsesLargestUnit = false
			$0.allowsFractionalUnits = true
			$0.locale = Locales.english
		})
		let value2 = (5.hours + 2.days).timeInterval.toString(options: {
			$0.unitsStyle = .abbreviated
			$0.locale = Locales.english
		})
		XCTAssert(value1 == "2 hours, 5 minutes, 32 seconds", "Failed to format interval to string")
		XCTAssert(value2 == "2d 5h", "Failed to format interval to string")
	}

	func testColloquialFormatter() {
		let ago5Mins = DateInRegion() - 5.minutes
		let r1 = ago5Mins.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.italian)
		let r2 = ago5Mins.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.italian)
		XCTAssert(r1 == "5 minuti fa", "Failed to use colloquial formatter")
		XCTAssert(r2 == "5 min fa", "Failed to use colloquial formatter")

		let justNow = DateInRegion() - 10.seconds
		let r3 = justNow.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.italian)
		XCTAssert(r3 == "ora", "Failed to use colloquial formatter")

		let justNow2 = DateInRegion() - 2.hours
		let r4 = justNow2.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.italian)
		XCTAssert(r4 == "2h fa", "Failed to use colloquial formatter")

		let justNow3 = DateInRegion() - 1.minutes
		let r5 = justNow3.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.english)
		XCTAssert(r5 == "1 min. ago", "Failed to use colloquial formatter")

		let justNow4 = DateInRegion() - 51.seconds
		let r6 = justNow4.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.english)
		XCTAssert(r6 == "1 min. ago", "Failed to use colloquial formatter")
	}

	func testISOParser() {

		func testISO(_ src: String, _ exp: String) {
			let output = src.toISODate()?.toISO()
			XCTAssert(output == exp, "Failed to parse ISO '\(src)'")
		}

		testISO("20060506", "2006-05-06T00:00:00Z") // YYYYMMDD
		testISO("2001-12-14", "2001-12-14T00:00:00Z") // YYYY-MM-DD
		testISO("2001-06", "2001-06-01T00:00:00Z") // YYYY-MM
		testISO("2015", "2015-01-01T00:00:00Z") // YYYY
		//testISO("15", "1518-01-01T00:00:00Z") // YY

		// Implied century: YY is 00-99
		testISO("150603", "2015-06-03T00:00:00Z") // YYMMDD
		testISO("161201", "2016-12-01T00:00:00Z") // YY-MM-DD

		// Implied year
		testISO("--1215", "\(Date().year)-12-15T00:00:00Z") // --MMDD
		testISO("--12-15", "\(Date().year)-12-15T00:00:00Z") // --MM-DD
		testISO("--12", "\(Date().year)-12-01T00:00:00Z") // --MM

		// Implied year and month
		testISO("---15", "\(Date().year)-\(String(format: "%02d", Date().month))-15T00:00:00Z") // ---DD

		// Ordinal dates: DDD is the number of the day in the year (1-366)
		testISO("2015010", "2015-01-10T00:00:00Z") // YYYYDDD (DDD is the number of the day of the year)
		testISO("2015032", "2015-02-01T00:00:00Z") // YYYY-DDD
		testISO("15-032", "2015-02-01T00:00:00Z") // YY-DDD
		testISO("15032", "2015-02-01T00:00:00Z") // YYDDD
		testISO("-032", "\(Date().year)-02-01T00:00:00Z") // -DDD

		// Week-based dates: ww is the number of the week, and d is the number (1-7) of the day in the week
		testISO("2018W012", "2018-01-02T00:00:00Z") // yyyyWwwd
		testISO("2018-W01-2", "2018-01-02T00:00:00Z") // yyyy-Www-d
		testISO("2018-W01", "2017-12-31T00:00:00Z") // yyyyWww
		testISO("2018-W01", "2017-12-31T00:00:00Z") // yyyy-Www
		testISO("18-W01", "2017-12-31T00:00:00Z") // yyWwwd
		testISO("18-W01-2", "2018-01-02T00:00:00Z") // yy-Www-d
		testISO("18W01", "2017-12-31T00:00:00Z") // yyWww
		testISO("18-W01", "2017-12-31T00:00:00Z") // yy-Www

		// Date
		testISO("1970-01-01", "1970-01-01T00:00:00Z")
		testISO("2001", "2001-01-01T00:00:00Z")
		testISO("2001-02-03", "2001-02-03T00:00:00Z")
		testISO("2001-02-03T04:05", "2001-02-03T04:05:00Z")
		testISO("2001-02-03T04:05:06.007-06:30", "2001-02-03T04:05:06-06:30")
	}
}
