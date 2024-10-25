import sqlite3InitModule from "@sqlite.org/sqlite-wasm";

export const setupSQLiteDatabase = async () => {
  const sqlite3 = await sqlite3InitModule();

  console.log("Running SQLite3 version", sqlite3.version.libVersion);
  // NOTE: This database is transient and will be lost if you uninstall the service worker (aka hard reset)
  const db = new sqlite3.oo1.DB("/railsdb.sqlite3", "ct");
  return db;
};
