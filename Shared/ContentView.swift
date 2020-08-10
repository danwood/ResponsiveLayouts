//
//  ContentView.swift
//  Shared
//
//  Created by Dan Wood on 7/15/20.
//

import SwiftUI

enum ScreenWidth : String, CaseIterable {
    case small
    case medium
    case large
}

extension Color {
	static let almostWhite = Color(red: 235 / 255, green: 235 / 255, blue: 245 / 255)
	static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

struct FixedWidthPage: ViewModifier {

	var width: CGFloat
	var spacing: CGFloat

	func body(content: Content) -> some View {
		content
			.background(Color.almostWhite)

			// Some padding around whole thing
			.padding(spacing)
			.background(Color.offWhite	//

							.shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
							.shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5))


			.frame(width: width)
			// nest the shadows inside the background to prevent the contents of this view from each getting a shadow!



			// request maximum size for background
			.frame(maxWidth:.infinity, maxHeight:.infinity)
			.background(Color.blue)


	}
}

struct ContentView: View {

	@State private var width            : CGFloat = 800.0
	@State private var spacing          : CGFloat = 10.0
	@State private var breakpoint1      : CGFloat = 500.0
	@State private var breakpoint2      : CGFloat = 700.0
	@State private var firstColumnWidth : CGFloat = 0.75

	@State private var screenWidth : ScreenWidth = .large

	@State private var tabViewSelection = 1

	var body: some View {


		VStack {
			Sliders(width: $width, spacing: $spacing, breakpoint1: $breakpoint1, breakpoint2: $breakpoint2, firstColumnWidth: $firstColumnWidth, screenWidth: $screenWidth)
				.frame(maxHeight:100)

			TabView(selection: $tabViewSelection) {
				MondrianView(spacing: spacing, breakpoint1: breakpoint1, breakpoint2: breakpoint2, firstColumnWidth: firstColumnWidth, screenWidth: screenWidth)

					.modifier(FixedWidthPage(width:width, spacing:spacing))
					.tabItem { Text("Mondrian") }.tag(1)

				ColumnDrop(spacing: spacing, breakpoint1: breakpoint1, breakpoint2: breakpoint2, firstColumnWidth: firstColumnWidth, screenWidth: screenWidth)
					.modifier(FixedWidthPage(width:width, spacing:spacing))
					.tabItem { Text("Column Drop") }.tag(5)

				FeatureShuffle(spacing: spacing, breakpoint1: breakpoint1, breakpoint2: breakpoint2, firstColumnWidth: firstColumnWidth, screenWidth: screenWidth)

					.modifier(FixedWidthPage(width:width, spacing:spacing))
					.tabItem { Text("Feature Shuffle") }.tag(2)

				ColumnFlip(spacing: spacing, breakpoint1: breakpoint1, breakpoint2: breakpoint2, firstColumnWidth: firstColumnWidth, screenWidth: screenWidth)

					.modifier(FixedWidthPage(width:width, spacing:spacing))
					.tabItem { Text("Colunm Flip") }.tag(3)

				FeaturedItems(spacing: spacing, breakpoint1: breakpoint1, breakpoint2: breakpoint2, firstColumnWidth: firstColumnWidth, screenWidth: screenWidth)
					.modifier(FixedWidthPage(width:width, spacing:spacing))
					.tabItem { Text("Featured Items") }.tag(4)

				DataTableStack(spacing: spacing, breakpoint1: breakpoint1, breakpoint2: breakpoint2, firstColumnWidth: firstColumnWidth, screenWidth: screenWidth)
					.modifier(FixedWidthPage(width:width, spacing:spacing))
					.tabItem { Text("Data Table Stack") }.tag(6)

			}

		}


	}
}



