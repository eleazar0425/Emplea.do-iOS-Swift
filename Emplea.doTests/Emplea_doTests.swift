//
//  Emplea_doTests.swift
//  Emplea.doTests
//
//  Created by Eleazar Estrella GB on 5/16/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import Emplea_do

class Emplea_doTests: QuickSpec {
    override func spec() {
        describe("When target is created with filter's raw value") {
            let filter = FilterBy.softwareDevelopment
            let target = JobTarget.instantiate(page: 1, rawValue: filter.rawValue)
            
            it("should match filter raw value"){
                expect(target!.identifier).to(equal(filter.rawValue))
            }
        }
    }
}
