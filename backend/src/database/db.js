import { JSONFilePreset } from "lowdb/node";

const db = await JSONFilePreset("db.json", {
  users: [],
  accounts: [],
  transactions: [],
});

export default db;
