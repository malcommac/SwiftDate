
import Foundation

public class DOTNETDateTimeFormatter {
	private static let pattern = "\\/Date\\((-?\\d+)((?:[\\+\\-]\\d+)?)\\)\\/"

	private init() {}
	
	/// Parse a .donet formatted string returning appropriate `TimeZone` and `Dare` instance
	///
	/// - Parameters:
	///   - string: string to pasrse
	///   - calendar: calendar to use
	/// - Returns: valid tuple with date and timezone, `nil` if string is not valid
	public static func date(_ string: String, calendar: Calendar) -> (date: Date, tz: TimeZone)? {
		guard let parsed = DOTNETDateTimeFormatter.parseDateString(string) else {
			return nil
		}
		let date_obj = Date(timeIntervalSince1970: parsed.seconds)
		return (date: date_obj, tz: parsed.tz)
	}
	
	
	/// Output as string representation of input `DateInRegion` instance
	///
	/// - Parameter date: date input
	/// - Returns: a .dotnet formatted string
	public static func string(_ date: DateInRegion) -> String {
		let milliseconds = (date.absoluteDate.timeIntervalSince1970 * 1000.0)
		let tzOffsets = (date.region.timeZone.secondsFromGMT(for: date.absoluteDate) / 3600)
		let formattedStr = String(format: "/Date(%.0f%+03d00)/", milliseconds,tzOffsets)
		return formattedStr
	}
	
	
	/// Parse a valid .donet string accounting both timezone and datetime
	///
	/// - Parameter string: input
	/// - Returns: date and timezone, `nil` is parser fails
	private static func parseDateString(_ string: String) -> (seconds: TimeInterval, tz: TimeZone)? {
		do {
			let parser = try NSRegularExpression(pattern: DOTNETDateTimeFormatter.pattern, options: .caseInsensitive)
			guard let match = parser.firstMatch(in: string, options: .reportCompletion, range: NSRange(location: 0, length: string.characters.count)) else {
				return nil
			}
			
			guard let milliseconds = TimeInterval((string as NSString).substring(with: match.rangeAt(1))) else { return nil }
			
			// Parse timezone
			let raw_tz = ((string as NSString).substring(with: match.rangeAt(2)) as NSString)
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
			return (seconds: milliseconds / 1000, tz: tz_obj)
		} catch {
			return nil
		}
	}
	
}
