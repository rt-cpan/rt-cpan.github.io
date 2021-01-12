PRAGMA foreign_keys = ON;
CREATE TABLE album (
	album_id INTEGER NOT NULL PRIMARY KEY,
	name TEXT
);

CREATE TABLE track (
	track_id INTEGER NOT NULL PRIMARY KEY,
	name TEXT,
	album INTEGER NOT NULL REFERENCES album(album_id) 
);

INSERT INTO album VALUES (1, 'Album 1');
INSERT INTO track VALUES (1, 'Track 1', 1);

-- The next insert should fail if uncommented
-- Error: near line 18: foreign key constraint failed
-- INSERT INTO track VALUES (2, 'Track 2', 2);

