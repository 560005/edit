CREATE TABLE IF NOT EXISTS categories (
  id INTEGER PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL, -- e.g. "plumber", "doctor"
  name TEXT NOT NULL -- human‐friendly name, e.g. "Plumber"
);

CREATE TABLE IF NOT EXISTS tags (
  name TEXT PRIMARY KEY -- e.g. "24x7", "Emergency", "Home Visit"
);

CREATE TABLE IF NOT EXISTS listings (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  category_id INTEGER REFERENCES categories(id),
  description TEXT,
  phone TEXT,
  address TEXT,
  latitude REAL,
  longitude REAL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  verified BOOLEAN DEFAULT 0
);

CREATE TABLE IF NOT EXISTS listing_tags (
  listing_id INTEGER,
  tag_name TEXT,
  PRIMARY KEY(listing_id, tag_name)
);
