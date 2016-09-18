//
//  NSTimeZoneTests.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 22/02/16.
//  Copyright © 2016 Jeroen Houtzager. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftDate

class NSTimeZoneSpec: QuickSpec {

    override func spec() {

        describe("TimeZone") {

            context("fromName") {

                it("should return local time zone") {
                    expect(TimeZoneName.local.timeZone) == NSTimeZone.local
                }

                it("should return default TimeZone") {
                    expect(TimeZoneName.default.timeZone) == NSTimeZone.default
                }

                it("should return system TimeZone") {
                    expect(TimeZoneName.system.timeZone) == NSTimeZone.system
                }

                it("should return CET TimeZone") {
                    expect(TimeZoneName.europeParis.timeZone) == TimeZone(abbreviation: "CET")
                }
            }
        }
    }
}
