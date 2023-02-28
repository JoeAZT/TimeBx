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
    if oldSchemaVersion < 1 {
      migration.enumerateObjects(ofType: Task.className()) { _, newObject in
        newObject?["colorOption"] = ColorOptions.green
      }
    }
  }

  static var configuration: Realm.Configuration {
    Realm.Configuration(schemaVersion: 1, migrationBlock: migrationBlock)
  }
}
