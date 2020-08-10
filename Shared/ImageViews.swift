//
//  ImageViews.swift
//  Responsive Layouts
//
//  Created by Dan Wood on 7/24/20.
//

import SwiftUI

struct View1: View {
	var body: some View {
		Image("sample1")
			.resizable().scaledToFit()
			.aspectRatio(contentMode: .fit)
	}
}

struct View2: View {
	var body: some View {
		Image("sample2")
			.resizable()
			.aspectRatio(contentMode: .fit)
	}
}

struct View3: View {
	var body: some View {
		Image("sample3")
			.resizable()
			.aspectRatio(contentMode: .fit)
	}
}
