//
//  ColumnDrop.swift
//  Responsive Layouts
//
//  Created by Dan Wood on 7/18/20.
//
// See: https://www.lukew.com/ff/entry.asp?1514

import SwiftUI

struct ColumnDrop: View {

	var spacing         : CGFloat
	var breakpoint1     : CGFloat
	var breakpoint2     : CGFloat
	var firstColumnWidth: CGFloat
	var screenWidth		: ScreenWidth

	@Namespace var nspace

	var body: some View {

		GeometryReader { screenGeo in

			ScrollView {

				// "WIDE" LAYOUT - 1 on the left, 2 and 3 stacked on the right
				if screenWidth == .large {

					HStack(alignment: .top, spacing:spacing) {

						View2()
							.frame(width: (screenGeo.size.width - screenGeo.size.width*firstColumnWidth) / 2 - spacing/2)
							.aspectRatio(contentMode: .fit)
							.matchedGeometryEffect(id: 2, in: nspace)

						// Main view in center; wider
						View1()
							.frame(width: screenGeo.size.width*firstColumnWidth - spacing)
							.matchedGeometryEffect(id: 1, in: nspace)


						View3()
							.frame(width: (screenGeo.size.width - screenGeo.size.width*firstColumnWidth) / 2 - spacing/2)
							.matchedGeometryEffect(id: 3, in: nspace)
					}
				}

				// "MEDIUM" LAYOUT - 1 on the top, 2 and 3 together below
				else if screenWidth == .medium {

					VStack(spacing:spacing) {

						HStack(alignment: .top, spacing:spacing) {
							View2()
								.frame(width: (screenGeo.size.width - screenGeo.size.width*firstColumnWidth) - spacing/2)
								.matchedGeometryEffect(id: 2, in: nspace)

							View1()
								.frame(width: screenGeo.size.width*firstColumnWidth - spacing/2)
								.matchedGeometryEffect(id: 1, in: nspace)

						}
						View3()
							.matchedGeometryEffect(id: 3, in: nspace)
					}
				}

				// "NARROW" LAYOUT - all three stacked vertically

				else {

					VStack(spacing:spacing) {
						View1()
							.matchedGeometryEffect(id: 1, in: nspace)

						View2()
							.matchedGeometryEffect(id: 2, in: nspace)

						View3()
							.matchedGeometryEffect(id: 3, in: nspace)
					}
				}
			}
		}
	}
}

