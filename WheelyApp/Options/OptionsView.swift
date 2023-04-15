//
//  OptionsView.swift
//  WheelyApp
//
//  Created by Lana Shatonova on 13/04/23.
//

import SwiftUI
import Combine

struct OptionsView: View {

    @StateObject private var viewModel = OptionViewModel()

    @State private var enteredOption: String = ""
    @State private var goToSpin: Bool = false

    @FocusState private var textFieldFocused: Bool

    var body: some View {
        ZStack {
            List {
                Group {
                    // Header
                    VStack(alignment: .leading, spacing: .mediumPadding) {
                        Text("The Wheel is a fun way to decide who's picking up the check!")
                            .font(.headline)

                        Text("When going out with friends, enter all of your names here and let the lucky winner pay the bill.")
                            .font(.subheadline)
                    }
                    .foregroundColor(.darkText)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, .mediumPadding)
                    .padding(.vertical, .largePadding)
                    .listRowInsets(.init(
                        top: .mediumPadding,
                        leading: .mediumPadding,
                        bottom: .mediumPadding,
                        trailing: .mediumPadding))
                    .bubble()

                    Group {
                        if viewModel.canEnterMoreOptions {
                            // Enter option text field
                            TextField("Enter a name...", text: $enteredOption)
                                .font(.body)
                                .foregroundColor(.darkText)
                                .tint(Color.primaryPurple)
                                .autocapitalization(.words)
                                .disableAutocorrection(true)
                                .submitLabel(.join)
                                .focused($textFieldFocused)
                                .onReceive(Just(enteredOption)) { _ in
                                    enteredOption = viewModel.validateEnteredOption(enteredOption)
                                }
                                .onSubmit {
                                    if addEnteredOption() {
                                        textFieldFocused = true
                                    }
                                }
                        } else {
                            // Limit reached error message
                            Text("You have reached the limit of entering names")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.errorRed)
                        }
                    }
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.mediumPadding)
                    .listRowInsets(.init(
                        top: .mediumPadding,
                        leading: .extraLargePadding,
                        bottom: .largePadding,
                        trailing: .extraLargePadding))
                    .bubble()

                    // Options
                    ForEach(viewModel.options.reversed(), id: \.self) { option in
                        Text(option)
                            .font(.body)
                            .foregroundColor(.darkText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.mediumPadding)
                            .listRowInsets(.init(
                                top: .smallPadding,
                                leading: .extraLargePadding,
                                bottom: .smallPadding,
                                trailing: .extraLargePadding))
                            .bubble()
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            viewModel.removeOption(at: viewModel.options.count - 1 - index)
                        }
                    }

                    // Content inset for accomodate for action button
                    Color.clear
                        .frame(height: 80)
                }
                .listRowBackground(Color.screenBackground)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)

            // Action button
            VStack {
                Spacer()

                Button("Go for a spin") {
                    _ = addEnteredOption()
                    textFieldFocused = false
                    goToSpin = true
                }
                .buttonStyle(ActionButtonStyle())
                .disabled(!viewModel.canGoToSpin)
                .padding(.horizontal, .mediumPadding)
                .padding(.vertical, .largePadding)
            }
        }
        .background { Color.screenBackground.ignoresSafeArea() }
        .navigationTitle("Wheel of Fortune")
        .toolbarBackground(Color.screenBackground, for: .navigationBar)
        .animation(.default, value: viewModel.options)
        .navigationDestination(isPresented: $goToSpin) {
            SpinView(options: viewModel.options)
        }
    }

    private func addEnteredOption() -> Bool {
        let hasAdded = viewModel.addOption(enteredOption)
        enteredOption = ""
        return hasAdded
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OptionsView()
        }
    }
}
