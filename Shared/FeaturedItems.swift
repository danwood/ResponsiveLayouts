//
//  FeaturedItems.swift
//  Responsive Layouts
//
//  Created by Dan Wood on 7/18/20.
//
// See: https://designshack.net/articles/ux-design/5-really-useful-responsive-web-design-patterns/
// Basically just have 4 columns in wide, down to 2, down to 1.
// We could use LazyVGrid with ranges, but that would allow the layout to have an intermediate state with 3 columns
// This one just switches layout by adjusting the column template for LazyVGrid, rather than having unique layouts per ScreenWidth style.

import SwiftUI

struct FeaturedItems: View {

	var spacing         : CGFloat
	var breakpoint1     : CGFloat
	var breakpoint2     : CGFloat
	var firstColumnWidth: CGFloat
	var screenWidth		: ScreenWidth

	let titles = ["Kindred", "I know why the caged bird sings", "Outside Child", "Saving Ruby King"]
	let authors = ["Octavia Butler", "Maya Angelou", "Alice Wilson-Fried", "Catherine Adel West"]

	let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut rutrum pretium erat, in mattis leo consectetur vitae. Phasellus venenatis est in tempus dignissim. Vestibulum elit elit, malesuada sed nunc vitae, ultrices tristique mi. Design is an evolutionary process, and filler text is just one tool in your progress-pushing arsenal. Use it where it makes sense to use it, and pull it once the natural process indicates that it’s time to roll out a descendant built with real content.";

	@Namespace var imageNS
	@Namespace var iconNS
	@Namespace var titleNS
	@Namespace var authorNS
	@Namespace var authorTextNS
	@Namespace var titleTextNS

	var body: some View {

		let numAcrossLookup : [ScreenWidth : Int] = [ScreenWidth.large : 4, ScreenWidth.medium : 2, ScreenWidth.small : 1]
		let numAcross = numAcrossLookup[screenWidth]!
		let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing:spacing), count: numAcross)	// spacing is horizontal here

		return ScrollView {
			VStack(spacing:spacing) {

				Text("Book List").font(.largeTitle)



				LazyVGrid(columns: columns, spacing:spacing) {		// Spacing is vertical here

					ForEach(0..<titles.count, id:\.self) { i in
						VStack(spacing: spacing) {

							Image("sample\(i+11)")
								.resizable()
								.scaledToFit()
								.matchedGeometryEffect(id: i, in: imageNS)
								.transition(.scale)


							Text("\(titles[i])").font(.headline)
								.matchedGeometryEffect(id: i, in: titleNS)
							Text(lorem).font(.body)
								.matchedGeometryEffect(id: i, in: titleTextNS)
							// So we need to specify state on all cases.

							//
							//							// AVATAR
							//
							Image("sample\(i+1)")
								.resizable()
								.aspectRatio(contentMode: .fill)
								.clipShape(Circle())
								.frame(width:64, height:64)

								.overlay(Circle().stroke(Color.white, lineWidth: 2))
								.padding(2)
								.overlay(Circle().strokeBorder(Color.black.opacity(0.1)))
								.shadow(radius: 4)
								.padding(4)

								.matchedGeometryEffect(id: i, in: iconNS)
								.transition(.scale)

							Text("\(authors[i])").font(.headline)
								.matchedGeometryEffect(id: i, in: authorNS)
							Text(lorem).font(.body)
								.matchedGeometryEffect(id: i, in: authorTextNS)
							// So we need to specify state on all cases.

						} // End VStack

					} // end ForEach
				}	// End LazyVGrid


			} // end VStack

			// Make sure it uses up full width
			.frame(minWidth: 0, maxWidth: .infinity, alignment: .top)


		} // end of scroll view
	} // end of body
}

