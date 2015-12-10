//
//  NSTimeZone+SwiftDate.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 08/12/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import Foundation

// MARK: - Extension: NSTimeZone

// This extension is used to provide easy creation of NSTimeZone instances from a TimeZoneRegion entry.
// TimeZoneRegion defines a common set of timezone countries you can use to switch between different world timezones.

public extension NSTimeZone {
    
    /**
     Create a new NSTimeZone instance from a given type
     
     - parameter type: TimeZoneRegion (use TimeZoneNames.<Country>.<Place>
     
     - returns: timezone instance
     */
    public static func fromType(type :TimeZoneRegion) -> NSTimeZone {
        if type.description == TimeZoneNames.Other.Local.description {
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

//MARK: - TimeZoneNames -

public protocol TimeZoneRegion {
    var description: String { get }
    func toTimeZone() -> NSTimeZone?
}

public struct TimeZoneNames {
    
    public enum Other : String, TimeZoneRegion {
        case UTC						= "UTC"			// UTC standard time zone
        case Local						= "LOCAL"		// Current system locale timezone
        case Default					= "DEFAULT"		// The default time zone for the current application.
        //  If no default time zone has been set, this method invokes systemTimeZone
        //  and returns the system time zone.
        case System						= "SYSTEM"		// The time zone currently used by the system. If the current time
        //	zone cannot be determined, returns the GMT time zone.
        public var description: String { get { return self.rawValue } }
        
        /**
         Convert a TimeZoneRegion structure to a real NSTimeZone instance
         
         - returns: an instance of NSTimeZone if possible, nil otherwise
         */
        public func toTimeZone() -> NSTimeZone? {
            switch self {
            case .Local:
                return NSTimeZone.localTimeZone()
            case .Default:
                return NSTimeZone.defaultTimeZone()
            case .System:
                return NSTimeZone.systemTimeZone()
            case .UTC:
                return NSTimeZone(abbreviation: "UTC")
            }
        }
    }
    
    public enum Africa : String, TimeZoneRegion {
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
    
    public enum America : String, TimeZoneRegion  {
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
    
    public enum Antarctica : String, TimeZoneRegion  {
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
    
    public enum Asia : String, TimeZoneRegion  {
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
    
    public enum Atlantic : String, TimeZoneRegion  {
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
    
    public enum Australia : String, TimeZoneRegion  {
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
    
    public enum Europe : String, TimeZoneRegion  {
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
    
    public enum Indian : String, TimeZoneRegion  {
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
    
    public enum Pacific : String, TimeZoneRegion  {
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