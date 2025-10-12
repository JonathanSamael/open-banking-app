import db from "../../database/db.js";

export const deleteFromDb = async (collectionName, id) => {
  await db.read();

  const normalizedId = typeof id === "object" ? id.id : id;
  const collection = db.data[collectionName];

  const index = collection.findIndex(item => item.id === normalizedId);
  if (index === -1) return false;

  collection.splice(index, 1);
  await db.write();

  return true;
};