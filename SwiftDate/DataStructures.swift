//
// SwiftDate.swift
// SwiftDate
//
//  Author:
//	Daniele Margutti
//	mail:		hello@danielemargutti.com
//	twitter:	@danielemargutti
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import Foundation

//MARK: - Structure: Region -

// Region structure encapsulate all timezone information relative to a particular timezone

/// This is the default application timezone used in SwiftDate when no region parameter is called
var DefaultRegion :Region?

public struct Region {
	public var calendar	:NSCalendar!		// Calendar to use
	public var timeZone : NSTimeZone! {
		get {
			return calendar.timeZone
		}
		set {
			calendar.timeZone = timeZone
		}
	}
	public var locale		:NSLocale!			// Locale to perform conversion
	
	/**
	Return the current local region (NSCalendar.currentLocale, NSTimeZone.localTimeZone(), NSLocale.currentLocale)
	
	- returns: a new region with current locale settings
	*/
	public static func LocalRegion() -> Region {
		let region = Region.init(calType: CalendarType.Local(false), tzType: TimeZoneNames.Other.Locale, loc: NSLocale.currentLocale())
		return region
	}
	
	/**
	Return an UTC region (gregoria calendar, GMT+0 and current NSLocale)
	
	- returns: UTC Region
	*/
	public static func UTCRegion() -> Region {
		let region = Region.init(calType: CalendarType.Gregorian, tzType: TimeZoneNames.Other.GMT, loc: NSLocale.currentLocale())
		return region
	}
	
	/**
	Initialize a new Region structure with passed NSCalendar,NSTimeZone and NSLocale object instances
	
	- parameter cal: calendar type (NSCalendar's with gregorian calendar identifier is nil)
	- parameter tz:  timezone (if nil NSTimeZone.currentLocale() is used)
	- parameter loc: locale as NSLocale instance (if nil currentLocale is used)
	
	- returns: a new region with specified parameters
	*/
	public init(cal	:NSCalendar? = CalendarType.Gregorian.toCalendar(),
				tz		:NSTimeZone? = TimeZoneNames.Other.Locale.toTimeZone()!,
				loc		:NSLocale? = NSLocale.currentLocale()) {
			
			self.calendar = cal
			self.timeZone = tz
			self.locale = loc
	}
	
	/**
	Initialize a new Region structure with passed calendar, timezone and locale
	
	- parameter cal: calendar type (see CalendarType structure, if nil Gregorian calendar is used)
	- parameter tz:  timezone (see TimeZoneNames.[country].[place], if nil NSTimeZone.currentLocale() is used)
	- parameter loc: locale as NSLocale instance (if nil currentLocale is used)
	
	- returns: a new region with specified parameters
	*/
	public init(calType	:CalendarType = CalendarType.Gregorian,
				tzType		:TimeZoneCountry = TimeZoneNames.Other.Locale,
				loc			:NSLocale = NSLocale.currentLocale()) {
			
			self.calendar = calType.toCalendar()
			self.calendar.timeZone = tzType.toTimeZone()!
			self.locale = loc
	}
	
	//MARK: - Default Region -
	
	/**
	Change the default region of the app (initially is Gregorian/GMT/currentLocale)
	
	- parameter region: new region to set as default (not restored between runs)
	*/
	public static func setDefaultRegion(region :Region!) {
		DefaultRegion = region
	}
	
	/**
	Return the current default region. If never set, Gregorian/GMT/currentLocale region is get
	
	- returns: default region
	*/
	public static func defaultRegion() -> Region {
		if DefaultRegion == nil {
			let calendar = CalendarType.Local(false).toCalendar()
			let timeZone = TimeZoneNames.Other.GMT.toTimeZone()
			calendar.timeZone = timeZone!
			let locale = NSLocale.currentLocale()
			DefaultRegion = Region(cal: calendar, tz: timeZone, loc: locale)
		}
		return DefaultRegion!
	}
}

// MARK: - Extension: NSTimeZone

// This extension is used to provide easy creation of NSTimeZone instances from a TimeZoneCountry entry.
// TimeZoneCountry defines a common set of timezone countries you can use to switch between different world timezones.

public extension NSTimeZone {

	/**
	Create a new NSTimeZone instance from a given type
	
	- parameter type: TimeZoneCountry (use TimeZoneNames.<Country>.<Place>
	
	- returns: timezone instance
	*/
	public static func fromType(type :TimeZoneCountry) -> NSTimeZone {
		if type.description == TimeZoneNames.Other.Locale.description {
			return NSTimeZone.localTimeZone()
		} else if type.description == TimeZoneNames.Other.System.description {
			return NSTimeZone.systemTimeZone()
		} else if type.description == TimeZoneNames.Other.Default.description {
			return NSTimeZone.defaultTimeZone()
		} else {
			return NSTimeZone(name: type.description)!
		}
	}
}

// MARK: - Extension - ISO8601 Formatter

// This class extension provide a single method which attempt to handle all different ISO8601 formatters to return
// best format string which can handle provided date

extension String {
	/**
	Attempts to handle all different ISO8601 formatters
	and returns correct date format for string
	http://www.w3.org/TR/NOTE-datetime
	*/
	static func ISO8601Formatter(fromString string: String) -> String {
		
		enum IS08601Format: Int {
			// YYYY (eg 1997)
			case Year = 4
			
			// YYYY-MM (eg 1997-07)
			case YearAndMonth = 7
			
			// YYYY-MM-DD (eg 1997-07-16)
			case CompleteDate = 10
			
			// YYYY-MM-DDThh:mmTZD (eg 1997-07-16T19:20+01:00)
			case CompleteDatePlusHoursAndMinutes = 22
			
			// YYYY-MM-DDThh:mmTZD (eg 1997-07-16T19:20Z)
			case CompleteDatePlusHoursAndMinutesAndZ = 17
			
			// YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30+01:00)
			case CompleteDatePlusHoursMinutesAndSeconds = 25

			// YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30+0100)
			case CompleteDatePlusHoursMinutesAndSecondsWithoutColon = 24
			
			// YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30Z)
			case CompleteDatePlusHoursAndMinutesAndSecondsAndZ = 20
			
			// YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45+01:00)
			case CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecond = 28


			// YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45+0100)
			case CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecondWithoutColon = 27
			
			// YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45Z)
			case CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecondAndZ = 23
		}
		
		var dateFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		
		if let dateStringCount = IS08601Format(rawValue: string.characters.count) {
			switch dateStringCount {
			case .Year:
				dateFormatter = "yyyy"
			case .YearAndMonth:
				dateFormatter = "yyyy-MM"
			case .CompleteDate:
				dateFormatter = "yyyy-MM-dd"
			case .CompleteDatePlusHoursAndMinutes, .CompleteDatePlusHoursAndMinutesAndZ:
				dateFormatter = "yyyy-MM-dd'T'HH:mmZ"
			case .CompleteDatePlusHoursMinutesAndSeconds, .CompleteDatePlusHoursMinutesAndSecondsWithoutColon, .CompleteDatePlusHoursAndMinutesAndSecondsAndZ:
				dateFormatter = "yyyy-MM-dd'T'HH:mm:ssZ"
			case .CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecond, .CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecondWithoutColon, .CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecondAndZ:
				dateFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
			}
		}
		return dateFormatter
	}
}


// MARK: - Extension: NSDateFormatter

// This extension is used to provide a central NSDateFormatter instance. Because NSDateFormatter instances are exprensive to create
// we want to reuse the same NSDateFormatter instances in each thread. We have used saveState() and restoreState() to save
// formatter's properties (dateFormat,locale and timeZone) and restore them after the use of the formatter itself.

internal extension NSDateFormatter {
	
	class CachedDateFormatter {
		private(set) var formatter	:NSDateFormatter
		private var dateFormat		:String?
		private var locale			:NSLocale?
		private var timeZone		:NSTimeZone?
		
		init() {
			self.formatter = NSDateFormatter()
		}
		
		/**
		Save the current state of the formatter
		
		- returns: formatter itself to enable chaining
		*/
		func saveState() -> CachedDateFormatter {
			dateFormat = formatter.dateFormat
			locale = formatter.locale
			timeZone = formatter.timeZone
			return self
		}
		
		/**
		Restore previously saved state of the formatter
		
		- returns: formatter itself to enable chaining
		*/
		func restoreState() -> CachedDateFormatter {
			formatter.dateFormat = dateFormat
			formatter.locale = locale
			formatter.timeZone = timeZone
			return self
		}
	}
	
	/**
	This method return the same NSDateFormatter encapsulated instance for each thread
	
	- returns: a CachedDateFormatter object.
	*/
	static func cachedFormatter() -> CachedDateFormatter {
		let CACHED_DATEFORMATTER_KEY = "CACHED_DATEFORMATTER_KEY"
		if let threadDictionary = NSThread.currentThread().threadDictionary as NSMutableDictionary? {
			if let cachedObject = threadDictionary[CACHED_DATEFORMATTER_KEY] as! CachedDateFormatter? {
				return cachedObject
			} else {
				let newObject = CachedDateFormatter()
				threadDictionary.setObject(newObject, forKey: CACHED_DATEFORMATTER_KEY)
				return newObject
			}
		} else {
			assert(false, "Current NSThread dictionary is nil. This should never happens, we will return a new instance of the object on each call")
			return CachedDateFormatter()
		}
	}
	
}

//MARK: - Extension: NSCalendarUnit -

public protocol CalendarAsDictKey: Hashable {}

/// This extension is used to support creation of NSDate/DateInRegion instances from a dictionary of NSCalendarUnit. Without this
/// extension we are not able to use NSCalendarUnit as key for our dictionary.
extension NSCalendarUnit: CalendarAsDictKey {
	public var hashValue: Int {
		get {
			return Int(self.rawValue)
		}
	}
}

// MARK: - Generate a Date from a Dictionary of NSCalendarUnit:Value

extension Dictionary where Value: AnyObject, Key: CalendarAsDictKey {
	
	/**
	Convert a dictionary of <NSCalendarUnit,Value> in a DateInRegion. Both timeZone and calendar must be specified into the dictionary. You can also specify a locale; if nil UTCRegion()'s locale will be used instead.
	
	- parameter locale: optional locale (Region.UTCRegion().locale if nil)
	
	- returns: DateInRegion if date components are complete, nil if cannot be used to generate a valid date
	*/
	func toRegion(locale : NSLocale = Region.UTCRegion().locale) -> DateInRegion? {
		let components = NSDateComponents()
		for (key, value) in self {
			if let value = value as? Int {
				components.setValue(value, forComponent: key as! NSCalendarUnit)
			} else if let value = value as? NSCalendar {
				components.calendar = value
			} else if let value = value as? NSTimeZone {
				components.timeZone = value
			}
		}
		return DateInRegion(components: components)
	}
	
	/**
	Convert a dictionary of <NSCalendarUnit,Value> in a UTC NSDate instance. Both timeZone and calendar must be specified into the dictionary. You can also specify a locale; if nil UTCRegion()'s locale will be used instead.
	
	- returns: NSDate (in UTC timezone) if date components are complete, nil if cannot be used to generate a valid date
	*/
	func toUTCDate() -> NSDate? {
		return toRegion()?.UTCDate
	}
}


//MARK: - Extension: NSCalendar -

public extension NSCalendar {
	/**
	Create a new NSCalendar instance from CalendarType structure. You can also use <CalendarType>.toCalendar() to get
	a new instance of NSCalendar with picked type.
	
	- parameter type: type of the calendar
	
	- returns: instance of the new NSCalendar
	*/
	public static func fromType(type :CalendarType) -> NSCalendar! {
		return type.toCalendar()
	}
	
	/**
	Create a new NSCalendar with current with settings for the current user’s chosen system locale overlaid with any custom settings the user has specified in System Preferences. Use autoUpdate = false to avoid auto-changes on Settings changes during runtime.
	
	- parameter autoUpdate: true to get auto-updating calendar
	
	- returns: a new NSCalendar instance from system settings
	*/
	static func locale(autoUpdate :Bool) -> NSCalendar! {
		return NSCalendar.fromType(CalendarType.Local(autoUpdate))
	}
}

//MARK: - Structure: CalendarType -

/**
*  @brief  This structure represent a shortcut from NSCalendar init function.
*/
public enum CalendarType {
	case Local(_: Bool)
	case Gregorian, Buddhist, Chinese, Coptic, EthiopicAmeteMihret, EthiopicAmeteAlem, Hebrew, ISO8601, Indian, Islamic, IslamicCivil, Japanese, Persian, RepubliOfChina, IslamicTabluar, IslamicUmmAlQura
	
	public func toCalendar() -> NSCalendar {
		var identifier : String
		switch self {
		case .Gregorian:			identifier = NSCalendarIdentifierGregorian
		case .Buddhist:				identifier = NSCalendarIdentifierBuddhist
		case .Chinese:				identifier = NSCalendarIdentifierChinese
		case .Coptic:				identifier = NSCalendarIdentifierCoptic
		case .EthiopicAmeteMihret:	identifier = NSCalendarIdentifierEthiopicAmeteMihret
		case .EthiopicAmeteAlem:	identifier = NSCalendarIdentifierEthiopicAmeteAlem
		case .Hebrew:				identifier = NSCalendarIdentifierHebrew
		case .ISO8601:				identifier = NSCalendarIdentifierISO8601
		case .Indian:				identifier = NSCalendarIdentifierIndian
		case .Islamic:				identifier = NSCalendarIdentifierIslamic
		case .IslamicCivil:			identifier = NSCalendarIdentifierIslamicCivil
		case .Japanese:				identifier = NSCalendarIdentifierJapanese
		case .Persian:				identifier = NSCalendarIdentifierPersian
		case .RepubliOfChina:		identifier = NSCalendarIdentifierRepublicOfChina
		case .IslamicTabluar:		identifier = NSCalendarIdentifierIslamicTabular
		case .IslamicUmmAlQura:		identifier = NSCalendarIdentifierIslamicUmmAlQura
		case .Local(let autoUpdate):
			if autoUpdate == true {
				return NSCalendar.autoupdatingCurrentCalendar()
			} else {
				return NSCalendar.currentCalendar()
			}
		}
		return NSCalendar(identifier: identifier)!
	}
}

//MARK: - Structure: DateFormat -

/**
*  @brief	DateFormat structure is used to parse and format an NSDate.
*			Custom formats are the same provided by iOS.
*			See: https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW1
*/
public enum DateFormat {
	case Custom(String)		// Custom formatting method
	case ISO8601			// ISO8601 Format: "2015-01-22T15:20:00Z"
	case ISO8601Date		// ISO8601 Only Date: "2015-01-22"
	case RSS				// RSS style formatter
	case AltRSS				// Alt RSS Formatter
	case Extended			// Extended date Formatter
	
	var formatString :String {
		switch self {
		case .Custom(let format):	return format
		case .ISO8601:				return "yyyy-MM-dd'T'HH:mm:ssZ"
		case .ISO8601Date:			return "yyyy-MM-dd"
		case .RSS:					return "EEE, d MMM yyyy HH:mm:ss ZZZ"
		case .AltRSS:				return "d MMM yyyy HH:mm:ss ZZZ"
		case .Extended:				return "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
		}
	}
}



//MARK: - TimeZoneNames -

public protocol TimeZoneCountry {
	var description: String { get }
	func toTimeZone() -> NSTimeZone?
}

public struct TimeZoneNames {
	
	public enum Other : String, TimeZoneCountry {
		case GMT						= "GMT"			// UTC standard time zone
		case Locale						= "LOCALE"		// Current system locale timezone
		case Default					= "DEFAULT"		// The default time zone for the current application.
		//  If no default time zone has been set, this method invokes systemTimeZone
		//  and returns the system time zone.
		case System						= "SYSTEM"		// The time zone currently used by the system. If the current time
		//	zone cannot be determined, returns the GMT time zone.
		public var description: String { get { return self.rawValue } }
		
		/**
		Convert a TimeZoneCountry structure to a real NSTimeZone instance
		
		- returns: an instance of NSTimeZone if possible, nil otherwise
		*/
		public func toTimeZone() -> NSTimeZone? {
			switch self.rawValue {
			case "LOCALE":
				return NSTimeZone.localTimeZone()
			case "DEFAULT":
				return NSTimeZone.defaultTimeZone()
			case "SYSTEM":
				return NSTimeZone.systemTimeZone()
			case "GMT":
				return NSTimeZone(abbreviation: "GMT")
			default:
				return NSTimeZone(name: self.rawValue)
			}
		}
	}
	
	public enum Africa : String, TimeZoneCountry {
		case Abidjan				= "Africa/Abidjan"
		case Accra					= "Africa/Accra"
		case Addis_Ababa			= "Africa/Addis_Ababa"
		case Algiers				= "Africa/Algiers"
		case Asmara					= "Africa/Asmara"
		case Bamako					= "Africa/Bamako"
		case Bangui					= "Africa/Bangui"
		case Banjul					= "Africa/Banjul"
		case Bissau					= "Africa/Bissau"
		case Blantyre				= "Africa/Blantyre"
		case Brazzaville			= "Africa/Brazzaville"
		case Bujumbura				= "Africa/Bujumbura"
		case Cairo					= "Africa/Cairo"
		case Casablanca				= "Africa/Casablanca"
		case Ceuta					= "Africa/Ceuta"
		case Conakry				= "Africa/Conakry"
		case Dakar					= "Africa/Dakar"
		case Dar_es_Salaam			= "Africa/Dar_es_Salaam"
		case Djibouti				= "Africa/Djibouti"
		case Douala					= "Africa/Douala"
		case El_Aaiun				= "Africa/El_Aaiun"
		case Freetown				= "Africa/Freetown"
		case Gaborone				= "Africa/Gaborone"
		case Harare					= "Africa/Harare"
		case Johannesburg			= "Africa/Johannesburg"
		case Juba					= "Africa/Juba"
		case Kampala				= "Africa/Kampala"
		case Khartoum				= "Africa/Khartoum"
		case Kigali					= "Africa/Kigali"
		case Kinshasa				= "Africa/Kinshasa"
		case Lagos					= "Africa/Lagos"
		case Libreville				= "Africa/Libreville"
		case Lome					= "Africa/Lome"
		case Luanda					= "Africa/Luanda"
		case Lubumbashi				= "Africa/Lubumbashi"
		case Lusaka					= "Africa/Lusaka"
		case Malabo					= "Africa/Malabo"
		case Maputo					= "Africa/Maputo"
		case Maseru					= "Africa/Maseru"
		case Mbabane				= "Africa/Mbabane"
		case Mogadishu				= "Africa/Mogadishu"
		case Monrovia				= "Africa/Monrovia"
		case Nairobi				= "Africa/Nairobi"
		case Ndjamena				= "Africa/Ndjamena"
		case Niamey					= "Africa/Niamey"
		case Nouakchott				= "Africa/Nouakchott"
		case Ouagadougou			= "Africa/Ouagadougou"
		case Porto_Novo				= "Africa/Porto-Novo"
		case Sao_Tome				= "Africa/Sao_Tome"
		case Tripoli				= "Africa/Tripoli"
		case Tunis					= "Africa/Tunis"
		case Windhoek				= "Africa/Windhoek"
		
		public var description: String { get { return self.rawValue } }
		public func toTimeZone() -> NSTimeZone? { return NSTimeZone(name: self.rawValue) }
	}
	
	public enum America : String, TimeZoneCountry  {
		case Adak					= "America/Adak"
		case Anchorage				= "America/Anchorage"
		case Anguilla				= "America/Anguilla"
		case Antigua				= "America/Antigua"
		case Araguaina				= "America/Araguaina"
		case Argentina_Buenos_Aires	= "America/Argentina/Buenos_Aires"
		case Argentina_Catamarca	= "America/Argentina/Catamarca"
		case Argentina_Cordoba		= "America/Argentina/Cordoba"
		case Argentina_Jujuy		= "America/Argentina/Jujuy"
		case Argentina_La_Rioja		= "America/Argentina/La_Rioja"
		case Argentina_Mendoza		= "America/Argentina/Mendoza"
		case Argentina_Rio_Gallegos	= "America/Argentina/Rio_Gallegos"
		case Argentina_Salta		= "America/Argentina/Salta"
		case Argentina_San_Juan		= "America/Argentina/San_Juan"
		case Argentina_San_Luis		= "America/Argentina/San_Luis"
		case Argentina_Tucuman		= "America/Argentina/Tucuman"
		case Argentina_Ushuaia		= "America/Argentina/Ushuaia"
		case Aruba					= "America/Aruba"
		case Asuncion				= "America/Asuncion"
		case Atikokan				= "America/Atikokan"
		case Bahia					= "America/Bahia"
		case Bahia_Banderas			= "America/Bahia_Banderas"
		case Barbados				= "America/Barbados"
		case Belem					= "America/Belem"
		case Belize					= "America/Belize"
		case Blanc_Sablon			= "America/Blanc-Sablon"
		case Boa_Vista				= "America/Boa_Vista"
		case Bogota					= "America/Bogota"
		case Boise					= "America/Boise"
		case Cambridge_Bay			= "America/Cambridge_Bay"
		case Campo_Grande			= "America/Campo_Grande"
		case Cancun					= "America/Cancun"
		case Caracas				= "America/Caracas"
		case Cayenne				= "America/Cayenne"
		case Cayman					= "America/Cayman"
		case Chicago				= "America/Chicago"
		case Chihuahua				= "America/Chihuahua"
		case Costa_Rica				= "America/Costa_Rica"
		case Creston				= "America/Creston"
		case Cuiaba					= "America/Cuiaba"
		case Curacao				= "America/Curacao"
		case Danmarkshavn			= "America/Danmarkshavn"
		case Dawson					= "America/Dawson"
		case Dawson_Creek			= "America/Dawson_Creek"
		case Denver					= "America/Denver"
		case Detroit				= "America/Detroit"
		case Dominica				= "America/Dominica"
		case Edmonton				= "America/Edmonton"
		case Eirunepe				= "America/Eirunepe"
		case El_Salvador			= "America/El_Salvador"
		case Fort_Nelson			= "America/Fort_Nelson"
		case Fortaleza				= "America/Fortaleza"
		case Glace_Bay				= "America/Glace_Bay"
		case Godthab				= "America/Godthab"
		case Goose_Bay				= "America/Goose_Bay"
		case Grand_Turk				= "America/Grand_Turk"
		case Grenada				= "America/Grenada"
		case Guadeloupe				= "America/Guadeloupe"
		case Guatemala				= "America/Guatemala"
		case Guayaquil				= "America/Guayaquil"
		case Guyana					= "America/Guyana"
		case Halifax				= "America/Halifax"
		case Havana					= "America/Havana"
		case Hermosillo				= "America/Hermosillo"
		case Indiana_Indianapolis	= "America/Indiana/Indianapolis"
		case Indiana_Knox			= "America/Indiana/Knox"
		case Indiana_Marengo		= "America/Indiana/Marengo"
		case Indiana_Petersburg		= "America/Indiana/Petersburg"
		case Indiana_Tell_City		= "America/Indiana/Tell_City"
		case Indiana_Vevay			= "America/Indiana/Vevay"
		case Indiana_Vincennes		= "America/Indiana/Vincennes"
		case Indiana_Winamac		= "America/Indiana/Winamac"
		case Inuvik					= "America/Inuvik"
		case Iqaluit				= "America/Iqaluit"
		case Jamaica				= "America/Jamaica"
		case Juneau					= "America/Juneau"
		case Kentucky_Louisville	= "America/Kentucky/Louisville"
		case Kentucky_Monticello	= "America/Kentucky/Monticello"
		case Kralendijk				= "America/Kralendijk"
		case La_Paz					= "America/La_Paz"
		case Lima					= "America/Lima"
		case Los_Angeles			= "America/Los_Angeles"
		case Lower_Princes			= "America/Lower_Princes"
		case Maceio					= "America/Maceio"
		case Managua				= "America/Managua"
		case Manaus					= "America/Manaus"
		case Marigot				= "America/Marigot"
		case Martinique				= "America/Martinique"
		case Matamoros				= "America/Matamoros"
		case Mazatlan				= "America/Mazatlan"
		case Menominee				= "America/Menominee"
		case Merida					= "America/Merida"
		case Metlakatla				= "America/Metlakatla"
		case Mexico_City			= "America/Mexico_City"
		case Miquelon				= "America/Miquelon"
		case Moncton				= "America/Moncton"
		case Monterrey				= "America/Monterrey"
		case Montevideo				= "America/Montevideo"
		case Montreal				= "America/Montreal"
		case Montserrat				= "America/Montserrat"
		case Nassau					= "America/Nassau"
		case New_York				= "America/New_York"
		case Nipigon				= "America/Nipigon"
		case Nome					= "America/Nome"
		case Noronha				= "America/Noronha"
		case North_Dakota_Beulah	= "America/North_Dakota/Beulah"
		case North_Dakota_Center	= "America/North_Dakota/Center"
		case North_Dakota_New_Salem	= "America/North_Dakota/New_Salem"
		case Ojinaga				= "America/Ojinaga"
		case Panama					= "America/Panama"
		case Pangnirtung			= "America/Pangnirtung"
		case Paramaribo				= "America/Paramaribo"
		case Phoenix				= "America/Phoenix"
		case Port_au_Prince			= "America/Port-au-Prince"
		case Port_of_Spain			= "America/Port_of_Spain"
		case Porto_Velho			= "America/Porto_Velho"
		case Puerto_Rico			= "America/Puerto_Rico"
		case Rainy_River			= "America/Rainy_River"
		case Rankin_Inlet			= "America/Rankin_Inlet"
		case Recife					= "America/Recife"
		case Regina					= "America/Regina"
		case Resolute				= "America/Resolute"
		case Rio_Branco				= "America/Rio_Branco"
		case Santa_Isabel			= "America/Santa_Isabel"
		case Santarem				= "America/Santarem"
		case Santiago				= "America/Santiago"
		case Santo_Domingo			= "America/Santo_Domingo"
		case Sao_Paulo				= "America/Sao_Paulo"
		case Scoresbysund			= "America/Scoresbysund"
		case Shiprock				= "America/Shiprock"
		case Sitka					= "America/Sitka"
		case St_Barthelemy			= "America/St_Barthelemy"
		case St_Johns				= "America/St_Johns"
		case St_Kitts				= "America/St_Kitts"
		case St_Lucia				= "America/St_Lucia"
		case St_Thomas				= "America/St_Thomas"
		case St_Vincent				= "America/St_Vincent"
		case Swift_Current			= "America/Swift_Current"
		case Tegucigalpa			= "America/Tegucigalpa"
		case Thule					= "America/Thule"
		case Thunder_Bay			= "America/Thunder_Bay"
		case Tijuana				= "America/Tijuana"
		case Toronto				= "America/Toronto"
		case Tortola				= "America/Tortola"
		case Vancouver				= "America/Vancouver"
		case Whitehorse				= "America/Whitehorse"
		case Winnipeg				= "America/Winnipeg"
		case Yakutat				= "America/Yakutat"
		case Yellowknife			= "America/Yellowknife"
		
		public var description: String { get { return self.rawValue } }
		public func toTimeZone() -> NSTimeZone? { return NSTimeZone(name: self.rawValue) }
	}
	
	public enum Antarctica : String, TimeZoneCountry  {
		case Casey					= "Antarctica/Casey"
		case Davis					= "Antarctica/Davis"
		case DumontDUrville			= "Antarctica/DumontDUrville"
		case Macquarie				= "Antarctica/Macquarie"
		case Mawson					= "Antarctica/Mawson"
		case McMurdo				= "Antarctica/McMurdo"
		case Palmer					= "Antarctica/Palmer"
		case Rothera				= "Antarctica/Rothera"
		case South_Pole				= "Antarctica/South_Pole"
		case Syowa					= "Antarctica/Syowa"
		case Troll					= "Antarctica/Troll"
		case Vostok					= "Antarctica/Vostok"
		case Longyearbyen			= "Arctic/Longyearbyen"
		
		public var description: String { get { return self.rawValue } }
		public func toTimeZone() -> NSTimeZone? { return NSTimeZone(name: self.rawValue) }
	}
	
	public enum Asia : String, TimeZoneCountry  {
		case Aden					= "Asia/Aden"
		case Almaty					= "Asia/Almaty"
		case Amman					= "Asia/Amman"
		case Anadyr					= "Asia/Anadyr"
		case Aqtau					= "Asia/Aqtau"
		case Aqtobe					= "Asia/Aqtobe"
		case Ashgabat				= "Asia/Ashgabat"
		case Baghdad				= "Asia/Baghdad"
		case Bahrain				= "Asia/Bahrain"
		case Baku					= "Asia/Baku"
		case Bangkok				= "Asia/Bangkok"
		case Beirut					= "Asia/Beirut"
		case Bishkek				= "Asia/Bishkek"
		case Brunei					= "Asia/Brunei"
		case Chita					= "Asia/Chita"
		case Choibalsan				= "Asia/Choibalsan"
		case Chongqing				= "Asia/Chongqing"
		case Colombo				= "Asia/Colombo"
		case Damascus				= "Asia/Damascus"
		case Dhaka					= "Asia/Dhaka"
		case Dili					= "Asia/Dili"
		case Dubai					= "Asia/Dubai"
		case Dushanbe				= "Asia/Dushanbe"
		case Gaza					= "Asia/Gaza"
		case Harbin					= "Asia/Harbin"
		case Hebron					= "Asia/Hebron"
		case Ho_Chi_Minh			= "Asia/Ho_Chi_Minh"
		case Hong_Kong				= "Asia/Hong_Kong"
		case Hovd					= "Asia/Hovd"
		case Irkutsk				= "Asia/Irkutsk"
		case Jakarta				= "Asia/Jakarta"
		case Jayapura				= "Asia/Jayapura"
		case Jerusalem				= "Asia/Jerusalem"
		case Kabul					= "Asia/Kabul"
		case Kamchatka				= "Asia/Kamchatka"
		case Karachi				= "Asia/Karachi"
		case Kashgar				= "Asia/Kashgar"
		case Kathmandu				= "Asia/Kathmandu"
		case Katmandu				= "Asia/Katmandu"
		case Khandyga				= "Asia/Khandyga"
		case Kolkata				= "Asia/Kolkata"
		case Krasnoyarsk			= "Asia/Krasnoyarsk"
		case Kuala_Lumpur			= "Asia/Kuala_Lumpur"
		case Kuching				= "Asia/Kuching"
		case Kuwait					= "Asia/Kuwait"
		case Macau					= "Asia/Macau"
		case Magadan				= "Asia/Magadan"
		case Makassar				= "Asia/Makassar"
		case Manila					= "Asia/Manila"
		case Muscat					= "Asia/Muscat"
		case Nicosia				= "Asia/Nicosia"
		case Novokuznetsk			= "Asia/Novokuznetsk"
		case Novosibirsk			= "Asia/Novosibirsk"
		case Omsk					= "Asia/Omsk"
		case Oral					= "Asia/Oral"
		case Phnom_Penh				= "Asia/Phnom_Penh"
		case Pontianak				= "Asia/Pontianak"
		case Pyongyang				= "Asia/Pyongyang"
		case Qatar					= "Asia/Qatar"
		case Qyzylorda				= "Asia/Qyzylorda"
		case Rangoon				= "Asia/Rangoon"
		case Riyadh					= "Asia/Riyadh"
		case Sakhalin				= "Asia/Sakhalin"
		case Samarkand				= "Asia/Samarkand"
		case Seoul					= "Asia/Seoul"
		case Shanghai				= "Asia/Shanghai"
		case Singapore				= "Asia/Singapore"
		case Srednekolymsk			= "Asia/Srednekolymsk"
		case Taipei					= "Asia/Taipei"
		case Tashkent				= "Asia/Tashkent"
		case Tbilisi				= "Asia/Tbilisi"
		case Tehran					= "Asia/Tehran"
		case Thimphu				= "Asia/Thimphu"
		case Tokyo					= "Asia/Tokyo"
		case Ulaanbaatar			= "Asia/Ulaanbaatar"
		case Urumqi					= "Asia/Urumqi"
		case Ust_Nera				= "Asia/Ust-Nera"
		case Vientiane				= "Asia/Vientiane"
		case Vladivostok			= "Asia/Vladivostok"
		case Yakutsk				= "Asia/Yakutsk"
		case Yekaterinburg			= "Asia/Yekaterinburg"
		case Yerevan				= "Asia/Yerevan"
		
		public var description: String { get { return self.rawValue } }
		public func toTimeZone() -> NSTimeZone? { return NSTimeZone(name: self.rawValue) }
	}
	
	public enum Atlantic : String, TimeZoneCountry  {
		case Azores					= "Atlantic/Azores"
		case Bermuda				= "Atlantic/Bermuda"
		case Canary					= "Atlantic/Canary"
		case Cape_Verde				= "Atlantic/Cape_Verde"
		case Faroe					= "Atlantic/Faroe"
		case Madeira				= "Atlantic/Madeira"
		case Reykjavik				= "Atlantic/Reykjavik"
		case South_Georgia			= "Atlantic/South_Georgia"
		case St_Helena				= "Atlantic/St_Helena"
		case Stanley				= "Atlantic/Stanley"
		
		public var description: String { get { return self.rawValue } }
		public func toTimeZone() -> NSTimeZone? { return NSTimeZone(name: self.rawValue) }
	}
	
	public enum Australia : String, TimeZoneCountry  {
		case Adelaide				= "Australia/Adelaide"
		case Brisbane				= "Australia/Brisbane"
		case Broken_Hill			= "Australia/Broken_Hill"
		case Currie					= "Australia/Currie"
		case Darwin					= "Australia/Darwin"
		case Eucla					= "Australia/Eucla"
		case Hobart					= "Australia/Hobart"
		case Lindeman				= "Australia/Lindeman"
		case Lord_Howe				= "Australia/Lord_Howe"
		case Melbourne				= "Australia/Melbourne"
		case Perth					= "Australia/Perth"
		case Sydney					= "Australia/Sydney"
		
		public var description: String { get { return self.rawValue } }
		public func toTimeZone() -> NSTimeZone? { return NSTimeZone(name: self.rawValue) }
	}
	
	public enum Europe : String, TimeZoneCountry  {
		case Amsterdam				= "Europe/Amsterdam"
		case Andorra				= "Europe/Andorra"
		case Athens					= "Europe/Athens"
		case Belgrade				= "Europe/Belgrade"
		case Berlin					= "Europe/Berlin"
		case Bratislava				= "Europe/Bratislava"
		case Brussels				= "Europe/Brussels"
		case Bucharest				= "Europe/Bucharest"
		case Budapest				= "Europe/Budapest"
		case Busingen				= "Europe/Busingen"
		case Chisinau				= "Europe/Chisinau"
		case Copenhagen				= "Europe/Copenhagen"
		case Dublin					= "Europe/Dublin"
		case Gibraltar				= "Europe/Gibraltar"
		case Guernsey				= "Europe/Guernsey"
		case Helsinki				= "Europe/Helsinki"
		case Isle_of_Man			= "Europe/Isle_of_Man"
		case Istanbul				= "Europe/Istanbul"
		case Jersey					= "Europe/Jersey"
		case Kaliningrad			= "Europe/Kaliningrad"
		case Kiev					= "Europe/Kiev"
		case Lisbon					= "Europe/Lisbon"
		case Ljubljana				= "Europe/Ljubljana"
		case London					= "Europe/London"
		case Luxembourg				= "Europe/Luxembourg"
		case Madrid					= "Europe/Madrid"
		case Malta					= "Europe/Malta"
		case Mariehamn				= "Europe/Mariehamn"
		case Minsk					= "Europe/Minsk"
		case Monaco					= "Europe/Monaco"
		case Moscow					= "Europe/Moscow"
		case Oslo					= "Europe/Oslo"
		case Paris					= "Europe/Paris"
		case Podgorica				= "Europe/Podgorica"
		case Prague					= "Europe/Prague"
		case Riga					= "Europe/Riga"
		case Rome					= "Europe/Rome"
		case Samara					= "Europe/Samara"
		case San_Marino				= "Europe/San_Marino"
		case Sarajevo				= "Europe/Sarajevo"
		case Simferopol				= "Europe/Simferopol"
		case Skopje					= "Europe/Skopje"
		case Sofia					= "Europe/Sofia"
		case Stockholm				= "Europe/Stockholm"
		case Tallinn				= "Europe/Tallinn"
		case Tirane					= "Europe/Tirane"
		case Uzhgorod				= "Europe/Uzhgorod"
		case Vaduz					= "Europe/Vaduz"
		case Vatican				= "Europe/Vatican"
		case Vienna					= "Europe/Vienna"
		case Vilnius				= "Europe/Vilnius"
		case Volgograd				= "Europe/Volgograd"
		case Warsaw					= "Europe/Warsaw"
		case Zagreb					= "Europe/Zagreb"
		case Zaporozhye				= "Europe/Zaporozhye"
		case Zurich					= "Europe/Zurich"
		
		public var description: String { get { return self.rawValue } }
		public func toTimeZone() -> NSTimeZone? { return NSTimeZone(name: self.rawValue) }
	}
	
	public enum Indian : String, TimeZoneCountry  {
		case Antananarivo			= "Indian/Antananarivo"
		case Chagos					= "Indian/Chagos"
		case Christmas				= "Indian/Christmas"
		case Cocos					= "Indian/Cocos"
		case Comoro					= "Indian/Comoro"
		case Kerguelen				= "Indian/Kerguelen"
		case Mahe					= "Indian/Mahe"
		case Maldives				= "Indian/Maldives"
		case Mauritius				= "Indian/Mauritius"
		case Mayotte				= "Indian/Mayotte"
		case Reunion				= "Indian/Reunion"
		
		public var description: String { get { return self.rawValue } }
		public func toTimeZone() -> NSTimeZone? { return NSTimeZone(name: self.rawValue) }
	}
	
	public enum Pacific : String, TimeZoneCountry  {
		case Apia					= "Pacific/Apia"
		case Auckland				= "Pacific/Auckland"
		case Bougainville			= "Pacific/Bougainville"
		case Chatham				= "Pacific/Chatham"
		case Chuuk					= "Pacific/Chuuk"
		case Easter					= "Pacific/Easter"
		case Efate					= "Pacific/Efate"
		case Enderbury				= "Pacific/Enderbury"
		case Fakaofo				= "Pacific/Fakaofo"
		case Fiji					= "Pacific/Fiji"
		case Funafuti				= "Pacific/Funafuti"
		case Galapagos				= "Pacific/Galapagos"
		case Gambier				= "Pacific/Gambier"
		case Guadalcanal			= "Pacific/Guadalcanal"
		case Guam					= "Pacific/Guam"
		case Honolulu				= "Pacific/Honolulu"
		case Johnston				= "Pacific/Johnston"
		case Kiritimati				= "Pacific/Kiritimati"
		case Kosrae					= "Pacific/Kosrae"
		case Kwajalein				= "Pacific/Kwajalein"
		case Majuro					= "Pacific/Majuro"
		case Marquesas				= "Pacific/Marquesas"
		case Midway					= "Pacific/Midway"
		case Nauru					= "Pacific/Nauru"
		case Niue					= "Pacific/Niue"
		case Norfolk				= "Pacific/Norfolk"
		case Noumea					= "Pacific/Noumea"
		case Pago_Pago				= "Pacific/Pago_Pago"
		case Palau					= "Pacific/Palau"
		case Pitcairn				= "Pacific/Pitcairn"
		case Pohnpei				= "Pacific/Pohnpei"
		case Ponape					= "Pacific/Ponape"
		case Port_Moresby			= "Pacific/Port_Moresby"
		case Rarotonga				= "Pacific/Rarotonga"
		case Saipan					= "Pacific/Saipan"
		case Tahiti					= "Pacific/Tahiti"
		case Tarawa					= "Pacific/Tarawa"
		case Tongatapu				= "Pacific/Tongatapu"
		case Truk					= "Pacific/Truk"
		case Wake					= "Pacific/Wake"
		case Wallis					= "Pacific/Wallis"
		
		public var description: String { get { return self.rawValue } }
		public func toTimeZone() -> NSTimeZone? { return NSTimeZone(name: self.rawValue) }
	}
}
