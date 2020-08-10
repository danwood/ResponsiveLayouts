//
//  DataTableStack.swift
//  Responsive Layouts
//
//  Created by Dan Wood on 7/18/20.
//
// https://responsivedesign.is/patterns/data-table-stack/

import SwiftUI

struct Movie: Codable, Identifiable {
	let id = UUID()
	var title: String
	var rank : Int
	var year : Int
	var rating : Int		// Percent
	var gross : String

	private enum CodingKeys: String, CodingKey {
		case title, rank, year, rating, gross
	}

}

struct DataTableStack: View {

	var spacing         : CGFloat
	var breakpoint1     : CGFloat
	var breakpoint2     : CGFloat
	var firstColumnWidth: CGFloat
	var screenWidth		: ScreenWidth

	let movies = Bundle.main.decode([Movie].self, from: "moviedata.json")

    var body: some View {

		let gridWide : [GridItem] = Array(repeating: .init(.flexible(), spacing:spacing), count: 5)	// spacing is horizontal here
		let gridKeyValue : [GridItem] = Array(repeating: .init(.flexible(), spacing:spacing), count: 2)	// spacing is horizontal here

		return ScrollView {

			if screenWidth == .large {

				LazyVGrid(columns:gridWide , alignment: .leading, spacing: spacing, pinnedViews: [.sectionHeaders]) {

					Section() {			// I wish this would be pinned on screen but it's not …
						Text("Title")
						Text("Rank")
						Text("Year")
						Text("Rating")
						Text("Gross")
					}.font(.headline)

					ForEach(movies) { movie in
						Text("\(movie.title)")
						Text("\(movie.rank)")
						Text("\(movie.year)")		// STUPID SWIFTUI BUG ADDS COMMA SEPARATOR
						Text("\(movie.rating)%")
						Text("\(movie.gross)")
					}
				}
			}
			else if screenWidth == .medium {

				LazyVGrid(columns:gridKeyValue , alignment: .leading, spacing: spacing) {

					ForEach(movies) { movie in

						Section() {
							Text("Title").font(.headline)
							Text("\(movie.title)")

							Text("Rank").font(.headline)
							Text("\(movie.rank)")

							Text("Year").font(.headline)
							Text("\(movie.year)")	// STUPID SWIFTUI BUG ADDS COMMA SEPARATOR

							Text("Rating").font(.headline)
							Text("\(movie.rating)%")

							Text("Gross").font(.headline)
							Text("\(movie.gross)")
						}
						Divider()
						Divider()	// It would be nice if divider went across whole row
					}
				}



			}
			else {

				LazyVStack(alignment: .leading, spacing: spacing) {

					ForEach(movies) { movie in

						// 10 items so put into group
						Group {
							Text("Title").font(.headline)
							Text("\(movie.title)")

							Text("Rank").font(.headline)
							Text("\(movie.rank)")

							Text("Year").font(.headline)
							Text("\(movie.year)")

							Text("Rating").font(.headline)
							Text("\(movie.rating)%")

							Text("Gross").font(.headline)
							Text("\(movie.gross)")
						}
						Divider()

					}
				}
			}
		}
    }
}
