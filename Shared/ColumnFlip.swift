//
//  ColumnFlip.swift
//  Responsive Layouts
//
//  Created by Dan Wood on 7/17/20.
//
// See: https://designshack.net/articles/ux-design/5-really-useful-responsive-web-design-patterns/
//
//
//
//


import SwiftUI

struct ColumnFlip: View {

    var spacing         : CGFloat
    var breakpoint1     : CGFloat
    var breakpoint2     : CGFloat
    var firstColumnWidth: CGFloat
	var screenWidth		: ScreenWidth

	let titles = ["Kindred", "I know why the caged bird sings", "Outside Child"]
	let authors = ["Octavia Butler", "Maya Angelou", "Alice Wilson-Fried"]

	let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut rutrum pretium erat, in mattis leo consectetur vitae. Phasellus venenatis est in tempus dignissim. Vestibulum elit elit, malesuada sed nunc vitae, ultrices tristique mi. Design is an evolutionary process, and filler text is just one tool in your progress-pushing arsenal. Use it where it makes sense to use it, and pull it once the natural process indicates that it’s time to roll out a descendant built with real content.";

	@Namespace var imageNS
	@Namespace var iconNS
	@Namespace var titleNS
	@Namespace var authorNS
	@Namespace var authorTextNS
	@Namespace var titleTextNS




    var body: some View {

		// Same number as above.  If we were to be general, we should build up columns to equal # of items
		let columns : [GridItem] = Array(repeating: .init(.flexible(), spacing:spacing), count: 3)	// spacing is horizontal here

		return ScrollView {
			VStack(spacing:spacing) {

				Text("Book List").font(.largeTitle)

				if screenWidth == .large {

					// 3 full rows

					VStack(spacing:spacing) {

						ForEach(0..<titles.count, id:\.self) { i in
							HStack(alignment:.top, spacing: spacing) {

								Image("sample\(i+12)")
									.resizable()
									.scaledToFit()
									// Try to be 150 wide by at most 150
									.frame(minWidth: 50, idealWidth: 150, maxWidth: 150, minHeight: 50, idealHeight: 100, maxHeight: 150, alignment: .top)

									.matchedGeometryEffect(id: i, in: imageNS)
									.transition(.scale)

								VStack(alignment:.leading, spacing: spacing) {

									Text("\(titles[i])").font(.headline)
										.matchedGeometryEffect(id: i, in: titleNS)
										Text(lorem).font(.body)
										.matchedGeometryEffect(id: i, in: titleTextNS)
									// So we need to specify state on all cases.
								}
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

								VStack(alignment:.leading, spacing: spacing) {

									Text("\(authors[i])").font(.headline)
										.matchedGeometryEffect(id: i, in: authorNS)
										Text(lorem).font(.body)
										.matchedGeometryEffect(id: i, in: authorTextNS)
									// So we need to specify state on all cases.


								}

							} // End Hstack

						} // end ForEach
					}	// End VStack

				}
				else if screenWidth == .medium {

					// 3 big pictures, then below 3 rows

					VStack(spacing:spacing) {

						// 3 big pictures across, equal width

						// For some reason I can't get them to have a spacing of zero
						LazyVGrid(columns:columns, spacing: spacing) {	// vertical spacing

							ForEach(0..<titles.count, id:\.self) { i in

								Image("sample\(i+12)")
									.resizable()
									.scaledToFit()
									.frame(maxHeight:200)	// don't let a portrait image get too tall

									.matchedGeometryEffect(id: i, in: imageNS)
									.transition(.scale)
							}
						}
						//.frame(minWidth: 0, maxWidth: .infinity)


						ForEach(0..<titles.count, id:\.self) { i in

							// Everything else is identical to the wide.

							HStack(alignment:.top, spacing: spacing) {

								VStack(alignment:.leading, spacing: spacing) {

									Text("\(titles[i])").font(.headline)
										.matchedGeometryEffect(id: i, in: titleNS)
										Text(lorem).font(.body)
										.matchedGeometryEffect(id: i, in: titleTextNS)
									// So we need to specify state on all cases.
								}
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

								VStack(alignment:.leading, spacing: spacing) {

									Text("\(authors[i])").font(.headline)
										.matchedGeometryEffect(id: i, in: authorNS)
										Text(lorem).font(.body)
										.matchedGeometryEffect(id: i, in: authorTextNS)
									// So we need to specify state on all cases.


								}

							} // End Hstack

						} // end ForEach
					}	// End VStack



				} else {	// small layout

					// Lots of options here but let's mostly stack things vertically, but avatar next to text.

					VStack(spacing:spacing) {

						ForEach(0..<titles.count, id:\.self) { i in

							Image("sample\(i+12)")
								.resizable()
								.scaledToFit()
								.frame(maxHeight:150)	// don't make it too tall.

								.matchedGeometryEffect(id: i, in: imageNS)
								.transition(.scale)


								Text("\(titles[i])").font(.headline)
									.matchedGeometryEffect(id: i, in: titleNS)
								Text(lorem).font(.body)
									.matchedGeometryEffect(id: i, in: titleTextNS)

							HStack(alignment:.top, spacing: spacing) {
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

								VStack(alignment:.leading, spacing: spacing) {

									Text("\(authors[i])").font(.headline)
										.matchedGeometryEffect(id: i, in: authorNS)
										Text(lorem).font(.body)
										.matchedGeometryEffect(id: i, in: authorTextNS)
									// So we need to specify state on all cases.


								}

							} // End Hstack

						} // end ForEach
					}	// End VStack
				}	// end of all cases
			}	// end of outer Vstack including title

			// Make sure it uses up full width
			.frame(minWidth: 0, maxWidth: .infinity, alignment: .top)


		} // end of scroll view
    } // end of body
}
