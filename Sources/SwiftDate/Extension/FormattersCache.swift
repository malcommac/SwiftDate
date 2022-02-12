//
//  SwiftDate
//  Toolkit to parse, validate, manipulate, compare and display dates, time & timezones in Swift.
//
//  Created by Daniele Margutti
//  Email: hello@danielemargutti.com
//  Web: http://www.danielemargutti.com
//
//  Copyright ©2022 Daniele Margutti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation

internal class FormattersCache {
    
    // MARK: - Internal Properties

    /// Singleton instance of the cache which hold the formatters.
    internal static let shared = FormattersCache()
    
    // MARK: - Private Properties (DateFormatter)

    /// Hold all the standard `DateFormatter` instances used.
    private static var dateFormatters = [String: DateFormatter]()
    
    /// Manage concurrent access to the standard `DateFormatter`'s cache.
    private static let dateFormattersQueue = DispatchQueue(
        label: "com.swiftdate.date-formatter",
        attributes: .concurrent
    )

    // MARK: - Private Properties (ISO8601DateFormatter)
    
    /// Hold all the standard `ISO8601DateFormatter` instances used.
    private static var isoFormatters = [String: ISO8601DateFormatter]()

    /// Manage concurrent access to the standard `ISO8601DateFormatter`'s cache.
    private static let isoFormattersQueue = DispatchQueue(
        label: "com.swiftdate.iso-date-formatter",
        attributes: .concurrent
    )
    
    // MARK: - Methods
    
    /// Register a new `DateFormatter` instance into the cache.
    ///
    /// - Parameters:
    ///   - formatter: formatter instance.
    ///   - hashKey: identifier for cache.
    private func register(_ formatter: DateFormatter, key hashKey: String) {
        FormattersCache.dateFormattersQueue.async(flags: .barrier) {
            FormattersCache.dateFormatters.updateValue(formatter, forKey: hashKey)
        }
    }
    
    /// Register a new `ISO8601DateFormatter` instance into the cache.
    ///
    /// - Parameters:
    ///   - formatter: formatter instance.
    ///   - hashKey: identifier for cache.
    private func register(_ formatter: ISO8601DateFormatter, key hashKey: String) {
        FormattersCache.isoFormattersQueue.async(flags: .barrier) {
            FormattersCache.isoFormatters.updateValue(formatter, forKey: hashKey)
        }
    }
    
    /// Retrive a registered cached formatter instance as `DateFormatter`.
    ///
    /// - Parameter hashKey: key identifier.
    /// - Returns: `DateFormatter`
    private func get(key hashKey: String) -> DateFormatter? {
        let dateFormatter = FormattersCache.dateFormattersQueue.sync { () -> DateFormatter? in
            guard let result = FormattersCache.dateFormatters[hashKey] else { return nil }
            return result.copy() as? DateFormatter
        }
        return dateFormatter
    }
    
    /// Retrive a registered cached instance for an `ISO8601DateFormatter` formatter.
    ///
    /// - Parameter hashKey: key identifier.
    /// - Returns: `ISO8601DateFormatter`
    private func getISO(key hashKey: String) -> ISO8601DateFormatter? {
        let dateFormatter = FormattersCache.isoFormattersQueue.sync { () -> ISO8601DateFormatter? in
            guard let result = FormattersCache.isoFormatters[hashKey] else { return nil }
            return result.copy() as? ISO8601DateFormatter
        }
        return dateFormatter
    }
    
    // MARK: - Internal Functions
    
    internal func formatter(_ format: String = DateFormats.standard.dateFormat,
                            region: Region, isLenient: Bool = true) -> DateFormatter? {
        
        let key = "\(format.hashValue)\(region.hashValue)"
        
        if FormattersCache.shared.get(key: key) == nil {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = region.timeZone.timeZone
            formatter.locale = region.locale?.locale
            formatter.isLenient = isLenient
            FormattersCache.shared.register(formatter, key: key)
        }
        return FormattersCache.shared.get(key: key)
    }
    
    internal func isoFormatter(_ format: DateFormats, region: Region) -> ISO8601DateFormatter? {
        let key = "\(format.dateFormat.hashValue)\(region.hashValue)"

        if FormattersCache.shared.getISO(key: key) == nil {
            let formatter = ISO8601DateFormatter()
            formatter.timeZone = region.timeZone.timeZone

            var options: ISO8601DateFormatter.Options = []
            switch format {
            case .isoYear:
                options = [.withYear, .withFractionalSeconds]
            case .isoYearMonth:
                options = [.withYear, .withMonth, .withDashSeparatorInDate]
            case .isoDate:
                options = [.withFullDate]
            case .isoDateTime:
                options = [.withInternetDateTime]
            case .isoDateTimeFull:
                options = [.withInternetDateTime, .withFractionalSeconds]
            default:
                fatalError("Unimplemented format \(format)")
            }
            
            formatter.formatOptions = options
            FormattersCache.shared.register(formatter, key: key)
        }
        
        return FormattersCache.shared.retrieve(hashKeyForISO: key)
    }

    
}
