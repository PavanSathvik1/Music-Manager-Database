-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Insert a new user
INSERT INTO users (username, join_date)
VALUES ('pavan_music', '2025-12-01');

-- Insert a new artist
INSERT INTO artists (name, genre)
VALUES ('Imagine Dragons', 'Rock');

-- Insert a new album
INSERT INTO albums (title, release_date, artist_id)
VALUES ('Night Visions', '2012-09-04', 1);

-- Insert a new song
INSERT INTO songs (title, duration, album_id, artist_id, genre)
VALUES ('Radioactive', 186, 1, 1, 'Rock');

-- Create a new playlist
INSERT INTO playlists (name, user_id, created_at)
VALUES ('Workout Vibes', 1, '2025-12-10');

-- Add song to playlist
INSERT INTO playlist_songs (playlist_id, song_id)
VALUES (1, 1);

-- Log a listening activity
INSERT INTO listening_history (user_id, song_id)
VALUES (1, 1);

-- Get all songs in a playlist
SELECT s.title, s.genre, s.duration
FROM songs s
JOIN playlist_songs ps ON s.id = ps.song_id
WHERE ps.playlist_id = 1;

-- Get the most listened songs by a user
SELECT s.title, COUNT(*) AS play_count
FROM songs s
JOIN listening_history lh ON s.id = lh.song_id
WHERE lh.user_id = 1
GROUP BY s.title
ORDER BY play_count DESC;

-- List all playlists created by a user
SELECT name, created_at
FROM playlists
WHERE user_id = 1;

-- Find all songs by an artist
SELECT s.title
FROM songs s
JOIN artists a ON s.artist_id = a.id
WHERE a.name = 'Imagine Dragons';

-- Show total listening count per user
SELECT u.username, COUNT(*) AS total_listens
FROM users u
JOIN listening_history lh ON u.id = lh.user_id
GROUP BY u.username
ORDER BY total_listens DESC;
