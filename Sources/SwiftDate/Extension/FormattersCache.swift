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
    
    public static let shared = FormattersCache()
    
    // MARK: - Properties
    
    private static var cachedDateFormatters = [String: DateFormatter]()

    private static let cachedDateFormattersQueue = DispatchQueue(
        label: "date-formatter-queue",
        attributes: .concurrent
    )

    private static var cachedISODateFormatters = [String: ISO8601DateFormatter]()

    private static let cachedISODateFormattersQueue = DispatchQueue(
        label: "iso-date-formatter-queue",
        attributes: .concurrent
    )
    
    // MARK: - Methods
    
    /// Register a new `DateFormatter` instance.
    /// - Parameters:
    ///   - hashKey: hash key.
    ///   - formatter: formatter instance.
    private func register(hashKey: String, formatter: DateFormatter) {
        FormattersCache.cachedDateFormattersQueue.async(flags: .barrier) {
            FormattersCache.cachedDateFormatters.updateValue(formatter, forKey: hashKey)
        }
    }
    
    private func register(hashKey: String, formatter: ISO8601DateFormatter) {
        FormattersCache.cachedISODateFormattersQueue.async(flags: .barrier) {
            FormattersCache.cachedISODateFormatters.updateValue(formatter, forKey: hashKey)
        }
    }
    
    /// Retrive a registered cached formatter instance.
    ///
    /// - Parameter hashKey: hash key.
    /// - Returns: `DateFormatter`
    private func retrieve(hashKey: String) -> DateFormatter? {
        let dateFormatter = FormattersCache.cachedDateFormattersQueue.sync { () -> DateFormatter? in
            guard let result = FormattersCache.cachedDateFormatters[hashKey] else { return nil }
            return result.copy() as? DateFormatter
        }
        return dateFormatter
    }
    
    private func retrieve(hashKeyForISO hashKey: String) -> ISO8601DateFormatter? {
        let dateFormatter = FormattersCache.cachedISODateFormattersQueue.sync { () -> ISO8601DateFormatter? in
            guard let result = FormattersCache.cachedISODateFormatters[hashKey] else { return nil }
            return result.copy() as? ISO8601DateFormatter
        }
        return dateFormatter
    }
    
    public func formatter(_ format: String = DateFormats.standard.dateFormat, region: Region, isLenient: Bool = true) -> DateFormatter? {
        let hashKey = "\(format.hashValue)\(region.hashValue)"
        
        if FormattersCache.shared.retrieve(hashKey: hashKey) == nil {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = region.timeZone.timeZone
            formatter.locale = region.locale?.locale
            formatter.isLenient = isLenient
            FormattersCache.shared.register(hashKey: hashKey, formatter: formatter)
        }
        return FormattersCache.shared.retrieve(hashKey: hashKey)
    }
    
    public func isoFormatter(_ format: DateFormats, region: Region) -> ISO8601DateFormatter? {
        let hashKey = "\(format.dateFormat.hashValue)\(region.hashValue)"

        if FormattersCache.shared.retrieve(hashKeyForISO: hashKey) == nil {
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
            FormattersCache.shared.register(hashKey: hashKey, formatter: formatter)
        }
        return FormattersCache.shared.retrieve(hashKeyForISO: hashKey)
    }

    
}
