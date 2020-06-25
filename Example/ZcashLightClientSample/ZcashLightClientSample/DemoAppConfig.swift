//
//  DemoAppConfig.swift
//  ZcashLightClientSample
//
//  Created by Francisco Gindre on 10/31/19.
//  Copyright © 2019 Electric Coin Company. All rights reserved.
//

import Foundation
import ZcashLightClientKit
import MnemonicSwift
struct DemoAppConfig {
    static var host = ZcashSDK.isMainnet ? "lightwalletd.z.cash" : "lightwalletd.testnet.z.cash"
    static var port: Int = 9067
    static var birthdayHeight: BlockHeight = ZcashSDK.isMainnet ? 663174 : 950000
    static var network = ZcashSDK.isMainnet ? ZcashNetwork.mainNet : ZcashNetwork.testNet
    static var seed = ZcashSDK.isMainnet ? Mnemonic.deterministicSeedBytes(from: "still champion voice habit trend flight survey between bitter process artefact blind carbon truly provide dizzy crush flush breeze blouse charge solid fish spread")! : Mnemonic.deterministicSeedBytes(from: "come exhibit fatal kid consider useless pigeon glove crawl stumble crunch left click labor curtain debris park hour raise wonder guilt upset eager order")!
    static var address: String {
        "\(host):\(port)"
    }
    
    static var processorConfig: CompactBlockProcessor.Configuration {
        var config = CompactBlockProcessor.Configuration(cacheDb: try! __cacheDbURL(), dataDb: try! __dataDbURL())
        config.walletBirthday = self.birthdayHeight
        return config
    }
    
    static var endpoint: LightWalletEndpoint {
        return LightWalletEndpoint(address: self.host, port: self.port, secure: true)
    }
}


enum ZcashNetwork {
    case mainNet
    case testNet
}

