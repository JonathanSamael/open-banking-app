import { JSONFilePreset } from "lowdb/node";

const db = await JSONFilePreset("db.json",{users: []});

export default db;
