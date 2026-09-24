// Key-Value store example (Redis-style)
SET Name "Joe Bloggs"
SET Age 42
SET Occupation "Stunt Double"
SET Height "175cm"
SET Weight "77kg"

// Column-based store example (Cassandra CQL)
CREATE TABLE ColumnFamily (
    RowKey text PRIMARY KEY,
    col1 text,
    col2 text,
    col3 text
);

// Document-oriented example (MongoDB)
db.documents.insertMany([
  { "prop1": "data", "prop2": "data", "prop3": "data", "prop4": "data" },
  { "prop1": "data", "prop2": "data", "prop3": "data", "prop4": "data" },
  { "prop1": "data", "prop2": "data", "prop3": "data", "prop4": "data" }
]);

// Graph-based example (Cypher / Neo4j)
CREATE (p:Person {name:"Alice"})-[:LIVES_IN]->(c:City {name:"Chennai"})
CREATE (p)-[:LIKES {rating:5}]->(r:Restaurant {name:"Spice House"})
CREATE (r)-[:LOCATED_IN]->(c)