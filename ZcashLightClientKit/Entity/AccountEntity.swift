//
//  AccountEntity.swift
//  ZcashLightClientKit
//
//  Created by Francisco Gindre on 11/14/19.
//

import Foundation
import SQLite

/**
 An account in the wallet
 */
public protocol AccountEntity {
    /// Index of the account
    var account: Int { get set }
    /// extended full viewing key for this account
    var extfvk: String { get set }
    
    /// zAddr for this account
    var address: String { get set }
}

/**
 Represents the accounts present in this wallet
 */
public protocol AccountRepository {
    
    /// gets all the accounts present in the databases
    func getAccounts() throws -> [AccountEntity]
}


class AccountSQLDAO: AccountRepository {
    
    var dbProvider: ConnectionProvider
    let accounts = Table("Accounts")
    
    init(provider: ConnectionProvider) {
        dbProvider = provider
    }
    
    struct TableStructure {
        static let account = Expression<Int>(Account.CodingKeys.account.rawValue)
        static let extfvk = Expression<String>(Account.CodingKeys.extfvk.rawValue)
        static let address = Expression<String>(Account.CodingKeys.address.rawValue)
    }
    
    struct Account: AccountEntity, Decodable {
        enum CodingKeys: String, CodingKey {
            case account
            case extfvk
            case address
        }
        var account: Int
        var extfvk: String
        var address: String
    }
    
    func getAccounts() throws -> [AccountEntity] {
        try dbProvider.connection().prepare(accounts).map { (row) -> Account in
            try row.decode()
        }
    }
}

public class AccountRepositoryBuilder {
    public static func repository(initializer: Initializer) -> AccountRepository {
        AccountSQLDAO(provider: SimpleConnectionProvider(path: initializer.dataDbURL.absoluteString))
    }
}
