-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Create users table
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    join_date DATE NOT NULL
);

-- Create artists table
CREATE TABLE artists (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    genre TEXT
);

-- Create albums table
CREATE TABLE albums (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    release_date DATE,
    artist_id INTEGER NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artists(id)
);

-- Create songs table
CREATE TABLE songs (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    duration INTEGER, -- in seconds
    album_id INTEGER NOT NULL,
    artist_id INTEGER NOT NULL,
    genre TEXT,
    FOREIGN KEY (album_id) REFERENCES albums(id),
    FOREIGN KEY (artist_id) REFERENCES artists(id)
);

-- Create playlists table
CREATE TABLE playlists (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    created_at DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create playlist_songs table (many-to-many between playlists and songs)
CREATE TABLE playlist_songs (
    playlist_id INTEGER,
    song_id INTEGER,
    PRIMARY KEY (playlist_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(id),
    FOREIGN KEY (song_id) REFERENCES songs(id)
);

-- Create listening history table
CREATE TABLE listening_history (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    song_id INTEGER NOT NULL,
    listened_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (song_id) REFERENCES songs(id)
);

-- Create indexes for performance
CREATE INDEX idx_user_id ON playlists(user_id);
CREATE INDEX idx_song_id ON playlist_songs(song_id);
CREATE INDEX idx_listening_user ON listening_history(user_id);
CREATE INDEX idx_listening_song ON listening_history(song_id);
CREATE INDEX idx_song_title ON songs(title);
