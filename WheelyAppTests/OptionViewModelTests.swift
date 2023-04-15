//
//  OptionViewModelTests.swift
//  WheelyAppTests
//
//  Created by Lana Shatonova on 14/04/23.
//

import XCTest
@testable import WheelyApp

final class OptionViewModelTests: XCTestCase {

    private let viewModel: OptionViewModel = OptionViewModel()

    override func setUp() {
        // Clear all saved options
        for _ in 0..<viewModel.options.count {
            viewModel.removeOption(at: 0)
        }
    }

    func testEnteringOptionOverCharacterLimit() {
        let option = String(repeating: "1", count: viewModel.characterMax + 1)
        XCTAssertNotEqual(viewModel.validateEnteredOption(option), option)
    }

    func testEnteringOptionBelowCharacterLimit() {
        let option = "1"
        XCTAssertEqual(viewModel.validateEnteredOption(option), option)
    }

    func testAddingEmptyOption() {
        XCTAssertFalse(viewModel.addOption(""))
        XCTAssertTrue(viewModel.options.isEmpty)
    }

    func testAddingWhitespacesOption() {
        XCTAssertFalse(viewModel.addOption("   "))
        XCTAssertTrue(viewModel.options.isEmpty)
    }

    func testAddingValidOption() {
        XCTAssertTrue(viewModel.addOption("1"))
        XCTAssertEqual(viewModel.options.count, 1)
    }

    func testNotAddingEnoughOptions() {
        XCTAssertFalse(viewModel.canGoToSpin)

        for index in 0..<viewModel.optionMin - 1 {
            XCTAssertTrue(viewModel.addOption(String(index)))
        }

        XCTAssertFalse(viewModel.canGoToSpin)
        XCTAssertTrue(viewModel.canEnterMoreOptions)
    }

    func testAddingMinOptions() {
        for index in 0..<viewModel.optionMin {
            XCTAssertTrue(viewModel.addOption(String(index)))
        }

        XCTAssertTrue(viewModel.canGoToSpin)
        XCTAssertTrue(viewModel.canEnterMoreOptions)
    }

    func testAddingMaxOptions() {
        for index in 0..<viewModel.optionMax {
            XCTAssertTrue(viewModel.addOption(String(index)))
        }

        XCTAssertFalse(viewModel.canEnterMoreOptions)
        XCTAssertTrue(viewModel.canGoToSpin)
    }

    func testAddingTooManyOptions() {
        testAddingMaxOptions()

        XCTAssertFalse(viewModel.addOption("1"))

        XCTAssertFalse(viewModel.canEnterMoreOptions)
        XCTAssertTrue(viewModel.canGoToSpin)
    }
}
