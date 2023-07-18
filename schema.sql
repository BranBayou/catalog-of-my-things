-- schema.sql
CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  description VARCHAR,
  last_played_at TIMESTAMP
);
