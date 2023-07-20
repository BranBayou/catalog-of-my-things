-- schema.sql --
CREATE DATABASE catalogs-of-my-things

--books schema
CREATE TABLE books (
    id INT GENERATED ALWAYS AS IDENTITY,
    publisher VARCHAR(50),
    cover_state VARCHAR(50),
    publish_date DATE,
    archived BOOLEAN,
    label_id INT,
    genre_id INT,
    author_id INT,
    FOREIGN KEY (label_id) REFERENCES labels(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (author_id) REFERENCES Author(id),
    PRIMARY KEY (id)
);

--label schema
CREATE TABLE labels (
    id INT GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    color VARCHAR(50),
    PRIMARY KEY (id)
);


-- Game Table
CREATE TABLE Game (
    id SERIAL PRIMARY KEY,
    publish_date DATE,
    multiplayer BOOLEAN,
    last_played_at DATE,
    genre_id INTEGER,
    author_id INTEGER,
    label_id INTEGER,
    archived BOOLEAN,

    FOREIGN KEY (genre_id) REFERENCES Genre(id),
    FOREIGN KEY (author_id) REFERENCES Author(id),
    FOREIGN KEY (label_id) REFERENCES Label(id),
)

-- Author Table
CREATE TABLE Author (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
)

-- Table: music_albums
CREATE TABLE music_albums (
  id SERIAL PRIMARY KEY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  on_spotify BOOLEAN NOT NULL,

  author_id INTEGER REFERENCES authors (id),
  genre_id INTEGER REFERENCES genres (id),
  label_id INTEGER REFERENCES labels (id)
);

-- Table: genres
CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

