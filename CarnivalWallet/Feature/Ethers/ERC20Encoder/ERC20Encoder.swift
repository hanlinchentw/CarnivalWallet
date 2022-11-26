//
//  ERC20Encoder.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/6.
//

import BigInt
import Foundation
import WalletCore
/// Encodes ERC20 function calls.
public final class ERC20Encoder {
	/// Encodes a function call to `name`
	///
	/// Solidity function: `string public constant name = "Token Name";`
	public static func encodeName() -> Data {
		let function = EthereumAbiFunction(name: "name")
		return EthereumAbi.encode(fn: function)
	}
	
	/// Encodes a function call to `symbol`
	///
	/// Solidity function: `string public constant symbol = "SYM";`
	public static func encodeSymbol() -> Data {
		let function = EthereumAbiFunction(name: "symbol")
		return EthereumAbi.encode(fn: function)
	}
	
	/// Encodes a function call to `decimals`
	///
	/// Solidity function: `uint8 public constant decimals = 18;`
	public static func encodeDecimals() -> Data {
		let function = EthereumAbiFunction(name: "decimals")
		return EthereumAbi.encode(fn: function)
	}
	
	/// Encodes a function call to `balanceOf`
	///
	/// Solidity function: `function balanceOf(address tokenOwner) public constant returns (uint balance);`
	public static func encodeBalanceOf(address: String) -> Data {
		let function = EthereumAbiFunction(name: "balanceOf")
		function.addParamAddress(val: Data(hexString: address)!, isOutput: false)
		return EthereumAbi.encode(fn: function)
	}
	
	/// Encodes a function call to `transfer`
	///
	/// Solidity function: `function transfer(address to, uint tokens) public returns (bool success);`
	public static func encodeTransfer(to: String, value: String) -> Data {
		let function = EthereumAbiFunction(name: "transfer")
		function.addParamAddress(val: Data(hexString: to)!, isOutput: false)
		function.addParamUInt256(val: Data(hexString: value)!, isOutput: false)
		return EthereumAbi.encode(fn: function)
	}
	
	/// Encodes a function call to `allowance`
	///
	/// Solidity function: `function allowance(address tokenOwner, address spender) public constant returns (uint remaining);`
	//	public static func encodeAllowance(owner: EthereumAddress, spender: EthereumAddress) -> Data {
	//		let function = Function(name: "allowance", parameters: [.address, .address])
	//		let encoder = ABIEncoder()
	//		try! encoder.encode(function: function, arguments: [owner, spender])
	//		return encoder.data
	//	}
	
	/// Encodes a function call to `approve`
	///
	/// Solidity function: `function approve(address spender, uint tokens) public returns (bool success);`
	//	public static func encodeApprove(spender: EthereumAddress, tokens: BigUInt) -> Data {
	//		let function = Function(name: "approve", parameters: [.address, .uint(bits: 256)])
	//		let encoder = ABIEncoder()
	//		try! encoder.encode(function: function, arguments: [spender, tokens])
	//		return encoder.data
	//	}
}
