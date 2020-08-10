//
//  Sliders.swift
//  Responsive Layouts
//
//  Created by Dan Wood on 7/17/20.
//

import SwiftUI

struct Sliders: View {

	@Binding var width            : CGFloat
	@Binding var spacing          : CGFloat
	@Binding var breakpoint1      : CGFloat
	@Binding var breakpoint2      : CGFloat
	@Binding var firstColumnWidth : CGFloat

	@Binding var screenWidth : ScreenWidth

	// Determine which breakpoint width we are at depending on chosen viewport width.
	func calculateWidth() {

		withAnimation(.easeIn(duration:1.0)) {
			if width >= breakpoint2 {
				screenWidth = .large
			} else if width >= breakpoint1 && width < breakpoint2 {
				screenWidth = .medium
			} else {
				screenWidth = .small
			}
		}
	}


	var body: some View {

		GeometryReader { screenGeo in
			HStack {
				VStack {
					Text("Layout Size: \(screenWidth.rawValue)").font(.caption)

					Picker("", selection: $screenWidth.animation(.easeInOut(duration: 1))) {		// bind with animation!
						ForEach(ScreenWidth.allCases, id: \.self) {
							Text($0.rawValue.prefix(1))
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}

				Divider().frame(height:80)
				VStack {
					Text("Width: \(Int(width))").font(.caption)
					Slider(value: Binding(get: {
											self.width }, set: { (newVal) in
												self.width = newVal
												self.calculateWidth()
											}),
						   in: 200...CGFloat(screenGeo.size.width),
						   step:1,
						   minimumValueLabel: Text(""),
						   maximumValueLabel: Text("\(Int(screenGeo.size.width))").font(.caption)) {
						EmptyView() // What is the label used for?
					}
				}

				Divider().frame(height:80)
				VStack {
					Text("Breakpoints: \(Int(breakpoint1)), \(Int(breakpoint2))").font(.caption)

					// Two sliders, make sure breakpoint1 is 10 pixels less than breakpoint 2,
					// and that breakpoint2 max's out at screen width

					// TODO: Update bindings to also call calculateWidth()
					HStack {
						Slider(value: Binding(get: {
												self.breakpoint1 }, set: { (newVal) in
													self.breakpoint1 = newVal
													self.calculateWidth()
												}),
							   in: 200...breakpoint2-10, step:10)
						Slider(value: Binding(get: {
												self.breakpoint2 }, set: { (newVal) in
													self.breakpoint2 = newVal
													self.calculateWidth()
												}), in: breakpoint1...screenGeo.size.width, step:10)
					}
				}
				Divider().frame(height:80)
				VStack {
					Text("Main Column: \(Int(firstColumnWidth*100))%").font(.caption)
					Slider(value: $firstColumnWidth, in: 0.50...0.95, step:0.05)
				}
				Divider().frame(height:80)
				VStack {
					Text("Spacing: \(Int(spacing))").font(.caption)
					Slider(value: $spacing, in: 0...50, step:2)
				}
			}
			.padding()

			.onAppear() {
				calculateWidth()
		}
		}

	}
}


