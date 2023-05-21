//
//  RealmMigrator.swift
//  TimeBox
//
//  Created by Joseph Taylor on 24/02/2023.
//

import RealmSwift

enum RealmMigrator {
  static private func migrationBlock(
    migration: Migration,
    oldSchemaVersion: UInt64
  ) {

  }

  static var configuration: Realm.Configuration {
    Realm.Configuration(schemaVersion: 2, migrationBlock: migrationBlock)
  }
}
