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
	func `safeAreaInset`(_ edge: VerticalEdge, inset: CGFloat) -> some View {
		return self.safeAreaInset(edge: edge) { Spacer().height(inset) }
	}
}
