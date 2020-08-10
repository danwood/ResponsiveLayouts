//
//  FeatureShuffle.swift
//  Responsive Layouts
//
//  Created by Dan Wood on 7/17/20.
//
// See: https://designshack.net/articles/ux-design/5-really-useful-responsive-web-design-patterns/
//
// Also very similar to Three Column Content Reflow https://responsivedesign.is/patterns/three-column-content-reflow/
//
//	Unfortunately this crashes frequently when switching, and the image size is not being animated!
//
//


import SwiftUI

struct FeatureShuffle: View {

    var spacing         : CGFloat
    var breakpoint1     : CGFloat
    var breakpoint2     : CGFloat
    var firstColumnWidth: CGFloat

	var screenWidth		: ScreenWidth

	let titles = ["Veterinarian", "State Senator", "District Attorney"]

	let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut rutrum pretium erat, in mattis leo consectetur vitae. Phasellus venenatis est in tempus dignissim. Vestibulum elit elit, malesuada sed nunc vitae, ultrices tristique mi.";

	@Namespace var imageNS
	@Namespace var headlineNS
	@Namespace var textNS


    var body: some View {

		ScrollView {
			VStack(spacing:spacing) {

				Text("This is the Headline").font(.largeTitle)

				if screenWidth == .large {

					HStack(spacing:spacing) {
						ForEach(0..<titles.count, id:\.self) { i in
							VStack(spacing:spacing) {
								Image("sample\(i+1)").resizable().scaledToFit()
									.matchedGeometryEffect(id: i, in: imageNS)
									.transition(.scale)
								Text("\(titles[i])").font(.headline)
									.matchedGeometryEffect(id: i, in: headlineNS)
								Text(lorem).font(.body)
									.matchedGeometryEffect(id: i, in: textNS)
							}
							.padding(spacing)
							.frame(minWidth: 0, maxWidth: .infinity, alignment: .top)

						}
					}

				}
				else if screenWidth == .medium {

					VStack(spacing:spacing) {
						ForEach(0..<titles.count, id:\.self) { i in
							HStack(spacing:spacing) {
								Image("sample\(i+1)").resizable().scaledToFit().frame(width: 100, height: 100, alignment: .center)
									.matchedGeometryEffect(id: i, in: imageNS)
									.transition(.scale)

								VStack(alignment:.leading) {
									Text("\(titles[i])").font(.headline)
										.matchedGeometryEffect(id: i, in: headlineNS)
										Text(lorem).font(.body)
										.matchedGeometryEffect(id: i, in: textNS)
									}
								.padding(spacing)
							}
							.environment(\.layoutDirection, i%2==0 ? .leftToRight  : .rightToLeft)

						}
					}


				} else {

					// No image. But put in a fake image where the medium image was, to give animation a good transition point

					VStack(spacing:spacing) {
						ForEach(0..<titles.count, id:\.self) { i in
							HStack(spacing:spacing) {
								// Placeholder for the gone image, so it has a size and position to shrink into
								Image("sample\(i+1)").resizable().scaledToFit().frame(width: 0, height: 0)
									.matchedGeometryEffect(id: i, in: imageNS)
									.transition(.scale)
								VStack(spacing:spacing) {

									Text("\(titles[i])").font(.headline)
										.matchedGeometryEffect(id: i, in: headlineNS)
										Text(lorem).font(.body)
										.matchedGeometryEffect(id: i, in: textNS)
	
								}
								.padding(spacing)
								.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
							}
							.environment(\.layoutDirection, i%2==0 ? .leftToRight  : .rightToLeft)

						}
					}
				}
			}


			
		}
    }
}
