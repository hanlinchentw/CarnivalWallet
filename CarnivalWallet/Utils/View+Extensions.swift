//
//  View+Extensions.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/10/22.
//

import SwiftUI

extension View {
	/**
	 Conditionally modify the view. For example, apply modifiers, wrap the view, etc.
	 ```
	 Text("Foo")
	 .padding()
	 .if(someCondition) {
	 $0.foregroundColor(.pink)
	 }
	 ```
	 ```
	 VStack() {
	 Text("Line 1")
	 Text("Line 2")
	 }
	 .if(someCondition) { content in
	 ScrollView(.vertical) { content }
	 }
	 ```
	 */
	@ViewBuilder
	func `if`(
		_ condition: @autoclosure () -> Bool,
		modify: (Self) -> some View
	) -> some View {
		if condition() {
			modify(self)
		} else {
			self
		}
	}
	
	/**
	 This overload makes it possible to preserve the type. For example, doing an `if` in a chain of `Text`-only modifiers.
	 ```
	 Text("🦄")
	 .if(isOn) {
	 $0.fontWeight(.bold)
	 }
	 .kerning(10)
	 ```
	 */
	func `if`(
		_ condition: @autoclosure () -> Bool,
		modify: (Self) -> Self
	) -> Self {
		condition() ? modify(self) : self
	}
}

extension View {
	/**
	 Conditionally modify the view. For example, apply modifiers, wrap the view, etc.
	 */
	@ViewBuilder
	func `if`(
		_ condition: @autoclosure () -> Bool,
		if modifyIf: (Self) -> some View,
		else modifyElse: (Self) -> some View
	) -> some View {
		if condition() {
			modifyIf(self)
		} else {
			modifyElse(self)
		}
	}
	
	/**
	 Conditionally modify the view. For example, apply modifiers, wrap the view, etc.
	 This overload makes it possible to preserve the type. For example, doing an `if` in a chain of `Text`-only modifiers.
	 */
	func `if`(
		_ condition: @autoclosure () -> Bool,
		if modifyIf: (Self) -> Self,
		else modifyElse: (Self) -> Self
	) -> Self {
		condition() ? modifyIf(self) : modifyElse(self)
	}
}

extension View {
	func `width`(_ width: CGFloat) -> some View {
		return self.frame(width: width)
	}
	
	func `height`(_ height: CGFloat) -> some View {
		return self.frame(height: height)
	}
	
	func `size`(_ size: CGFloat) -> some View {
		return self.frame(width: size, height: size)
	}
}

extension View {
	func `roundedBorder`(radius: CGFloat, borderColor: Color, borderWidth: CGFloat) -> some View {
		return self.overlay(
			RoundedRectangle(cornerRadius: radius)
				.stroke(borderColor, lineWidth: borderWidth)
		)
	}
}

extension View {
	func `capsule`(color: Color, radius: CGFloat) -> some View {
		return self
			.padding()
			.background(color)
			.height(radius*2)
			.cornerRadius(radius)
	}
	
	func `capsuleBorder`(style: RoundedCornerStyle = .continuous, borderColor: Color, borderWidth: CGFloat) -> some View {
		return self.overlay(Capsule(style: style).stroke(borderColor, lineWidth: borderWidth))
	}
	
	func `capsuleWithDashBorder`(style: RoundedCornerStyle = .continuous, borderColor: Color, borderWidth: CGFloat) -> some View {
		return self.overlay(
			Capsule(style: style)
				.strokeBorder(borderColor, style: .init(lineWidth: borderWidth, dash: [5]))
		)
	}
}

extension View {
	func `safeAreaInset`(_ edge: VerticalEdge, inset: CGFloat) -> some View {
		return self.safeAreaInset(edge: edge) { Spacer().height(inset) }
	}
}

extension View {
	func `navbarLeftItem`<Content: View>(item: () -> Content) -> some View {
		return self.navigationBarBackButtonHidden()
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading, content: item)
			}
	}
}

extension View {
	func `tapToResign`() -> some View {
		return self.onTapGesture {
			UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
		}
	}
}

extension View {
	func `tapToClip`(string: String?) -> some View {
		return self.onTapGesture {
			UIPasteboard.general.string = string
		}
	}
}

extension View {
	@ViewBuilder
	func `header`<Content: View>(title: String,
															 leftItem: () -> Content,
															 onPressedLeftItem: @escaping VoidClosure,
															 rightItem: (() -> Content)? = nil,
															 onPressedRightItem: VoidClosure? = nil
	) -> some View {
		self
			.padding(.top, SafeAreaUtils.top - 16)
			.width(DeviceDimension.WIDTH)
			.overlay(
				VStack {
					ZStack {
						HStack {
							Button {
								onPressedLeftItem()
							} label: {
								leftItem()
							}
							.size(16)
							.foregroundColor(.black)
							.padding(.leading, 16)
							Spacer()
							if let rightItem {
								Button {
									onPressedRightItem?()
								} label: {
									rightItem()
								}
								.size(16)
								.foregroundColor(.black)
								.padding(.trailing, 16)
							}
						}
						Text(title)
							.AvenirNextMedium(size: 20)
					}
					
					Divider()
					Spacer()
				}
			)
		
	}
}
