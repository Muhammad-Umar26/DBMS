//Q1
use inventoryDB;

db.furniture.insertMany([
  { name: "Table", color: "Brown", dimensions: [40, 80] },
  { name: "Chair", color: "Black", dimensions: [20, 40] },
  { name: "Sofa", color: "Grey", dimensions: [60, 120] }
]);

//Q2
db.furniture.insertOne({
  name: "Desk",
  color: "Brown",
  dimensions: [50, 100]
});

//Q3
db.furniture.find({
  "dimensions.0": { $gt: 30 }
});

//Q4
db.furniture.find({
  color: "Brown",
  name: { $in: ["Table", "Chair"] }
});

//Q5
db.furniture.updateOne(
  { name: "Table" },
  { $set: { color: "Ivory" } }
);

//Q6 
db.furniture.updateMany(
  { color: "Brown" },
  { $set: { color: "Dark Brown" } }
);

//Q7
db.furniture.deleteOne({ name: "Chair" });

//Q8
db.furniture.deleteMany({ dimensions: [12, 18] });

//Q9
db.furniture.aggregate([
  { $group: { _id: "$color", totalItems: { $sum: 1 } } }
]);

//Q10
db.furniture.createIndex({ name: "text" });

db.furniture.find({
  $text: { $search: "table" }
});
