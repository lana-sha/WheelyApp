//
//  OptionsViewModel.swift
//  WheelyApp
//
//  Created by Lana Shatonova on 14/04/23.
//

import Foundation

class OptionViewModel: ObservableObject {

    // MARK: - Constants

    private let optionsKey: String = "options"

    // Allow maximum of 40 characters
    let characterMax: Int = 40

    // Allow minimum of 2 and maximum of 20 options
    let optionMin: Int = 2
    let optionMax: Int = 20

    // MARK: - Properties

    @Published var options: [String] = []

    var canEnterMoreOptions: Bool {
        options.count < optionMax
    }

    var canGoToSpin: Bool {
        (optionMin...optionMax).contains(options.count)
    }

    // MARK: - Init

    init() {
        options = getSavedOptions()
    }

    // MARK: - Private methods

    private func getSavedOptions() -> [String] {
        // Get persisted options
        return UserDefaults.standard.value(forKey: optionsKey) as? [String] ?? []
    }

    private func saveOptions() {
        // Persist options
        UserDefaults.standard.setValue(options, forKey: optionsKey)
    }

    // MARK: - Public methods

    func validateEnteredOption(_ option: String) -> String {
        // Check character limit
        return String(option.prefix(characterMax))
    }

    func addOption(_ option: String) -> Bool {
        // Check options limit
        guard options.count < optionMax else { return false }

        // Trim whitespaces and add only non-empty options
        let trimmedOption = option.trimmingCharacters(in: .whitespaces)

        guard !trimmedOption.isEmpty else { return false }
        options.append(trimmedOption)
        saveOptions()
        return true
    }

    func removeOption(at index: Int) {
        options.remove(at: index)
        saveOptions()
    }
}
