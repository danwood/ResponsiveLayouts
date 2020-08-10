//
//  ContentView.swift
//  Shared
//
//  Created by Dan Wood on 7/15/20.
//
// See: https://designshack.net/articles/css/5-really-useful-responsive-web-design-patterns/
// Similar to Layout Shifter
// See: https://www.lukew.com/ff/entry.asp?1514


import SwiftUI


struct MondrianView: View {

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
						View1()
							.matchedGeometryEffect(id: 1, in: nspace)
							.frame(width: screenGeo.size.width*firstColumnWidth - spacing*2)

						VStack(spacing:spacing) {
							View2()
								.matchedGeometryEffect(id: 2, in: nspace)

							View3()
								.matchedGeometryEffect(id: 3, in: nspace)
						}
					}
				}

				// "MEDIUM" LAYOUT - 1 on the top, 2 and 3 together below
				else if screenWidth == .medium {

					VStack(spacing:spacing) {
						View1()
							.matchedGeometryEffect(id: 1, in: nspace)

						HStack(alignment: .top, spacing:spacing) {
							View2()
								.matchedGeometryEffect(id: 2, in: nspace)
								.frame(width: screenGeo.size.width*0.5 - spacing/2)

							View3()
								.matchedGeometryEffect(id: 3, in: nspace)
								.frame(width: screenGeo.size.width*0.5 - spacing/2)
						}
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

