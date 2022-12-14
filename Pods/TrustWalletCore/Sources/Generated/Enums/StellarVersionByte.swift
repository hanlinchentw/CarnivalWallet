// Copyright © 2017-2022 Trust Wallet.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
//
// This is a GENERATED FILE, changes made here WILL BE LOST.
//

/// Stellar address version byte.
public enum StellarVersionByte: UInt16, CaseIterable {
    case accountID = 0x30
    case seed = 0xc0
    case preAuthTX = 0xc8
    case sha256Hash = 0x118
}
