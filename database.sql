-- Création de la base de données
CREATE DATABASE IF NOT EXISTS reservation_salle CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE reservation_salle;

-- ==========================================
-- Table Users
-- ==========================================
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- Table Rooms
-- ==========================================
CREATE TABLE rooms (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    price_per_hour DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'AVAILABLE'
);

-- ==========================================
-- Table Reservations
-- ==========================================
CREATE TABLE reservations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    room_id BIGINT NOT NULL,
    start_datetime TIMESTAMP NOT NULL,
    end_datetime TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
);

-- ==========================================
-- Données de test (Seed Data)
-- ==========================================

-- 1. Utilisateurs
INSERT INTO users (id, username, password, email, phone, role) VALUES 
(1, 'admin', 'adminadmin', 'admin@coworking.com', '+212612345678', 'ADMIN'),
(2, 'marie', 'mariemarie', 'marie@example.com', '+212623456789', 'USER'),
(3, 'jean', 'jeanjean', 'jean@example.com', '+212634567890', 'USER'),
(4, 'sophie', 'sophiesophie', 'sophie@example.com', '+212645678901', 'USER'),
(5, 'lucas', 'lucaslucas', 'lucas@example.com', '+212656789012', 'USER'),
(6, 'testing', '123Testing/*-', 'testing@testing.com', '12345678', 'ADMIN'),
(7, 'eya safer', '123456', 'eya.safer@gmail.com', '12345678', 'USER');

-- 2. Salles
INSERT INTO rooms (id, name, capacity, description, image_url, price_per_hour, status) VALUES 
(1, 'Salle Innovation', 10, 'Salle de réunion moderne avec vue panoramique, idéale pour les brainstormings.', 'images/rooms/innovation.jpg', 150.00, 'AVAILABLE'),
(2, 'Salle Collaboration', 6, 'Espace intime pour les réunions d''équipe et discussions privées.', 'images/rooms/collaboration.jpg', 100.00, 'AVAILABLE'),
(3, 'Salle Créative', 8, 'Ambiance décontractée avec mobilier modulable pour libérer la créativité.', 'images/rooms/creative.jpg', 120.00, 'AVAILABLE'),
(4, 'Auditorium', 50, 'Grande salle de conférence pour événements, formations et présentations.', 'images/rooms/auditorium.jfif', 100.00, 'AVAILABLE'),
(5, 'Salle Executive', 15, 'Salle de conférence haut de gamme pour réunions importantes avec écran 4K.', 'images/rooms/executive.jpg', 250.00, 'AVAILABLE'),
(6, 'Salle Formation A', 20, 'Espace de formation équipé pour les workshops et sessions interactives.', 'images/rooms/training-a.jpg', 200.00, 'AVAILABLE'),
(7, 'Salle Formation B', 16, 'Salle de formation avec configuration flexible en U ou en classe.', 'images/rooms/training-b.jpg', 180.00, 'AVAILABLE'),
(8, 'Studio Podcast', 4, 'Studio insonorisé pour enregistrements audio et vidéo de qualité pro.', 'images/rooms/podcast.jpg', 180.00, 'AVAILABLE'),
(9, 'Think Tank', 12, 'Espace de réflexion stratégique avec ambiance feutrée et confortable.', 'images/rooms/thinktank.jpg', 160.00, 'AVAILABLE'),
(10, 'PhoneBox', 2, 'Cabine isolée pour appels confidentiels et concentration maximale.', 'images/rooms/phonebox.jpg', 50.00, 'UNAVAILABLE'),
(11, 'Salle Rénovation', 8, 'Salle actuellement en cours de rénovation et de modernisation.', 'images/rooms/under-construction.jpg', 0.00, 'MAINTENANCE');

-- 3. Réservations
INSERT INTO reservations (id, user_id, room_id, start_datetime, end_datetime, status, notes) VALUES 
(1, 2, 1, '2025-12-11 03:43:43', '2025-12-11 05:43:43', 'CANCELLED', 'Réunion stratégie marketing'),
(2, 3, 2, '2025-12-12 01:43:43', '2025-12-12 03:43:43', 'CONFIRMED', 'Point hebdomadaire équipe Dev'),
(3, 4, 6, '2025-12-13 01:43:43', '2025-12-13 05:43:43', 'CONFIRMED', 'Formation React Advanced'),
(4, 2, 2, '2025-12-18 01:43:43', '2025-12-18 04:43:43', 'CONFIRMED', 'Lancement produit - Présentation clients'),
(5, 5, 5, '2025-12-16 01:43:43', '2025-12-16 03:43:43', 'CONFIRMED', 'Comité de direction mensuel'),
(6, 3, 3, '2025-12-15 01:43:43', '2025-12-15 04:43:43', 'CONFIRMED', 'Enregistrement podcast Tech'),
(7, 4, 3, '2025-12-17 01:43:43', '2025-12-17 04:43:43', 'CONFIRMED', 'Brainstorming UX/UI'),
(8, 2, 2, '2025-12-25 01:43:43', '2025-12-25 07:43:43', 'CONFIRMED', 'Workshop Agile & Scrum'),
(9, 5, 5, '2025-12-23 01:43:43', '2025-12-23 05:43:43', 'CONFIRMED', 'Séminaire stratégique'),
(10, 3, 1, '2025-12-31 01:43:43', '2025-12-31 03:43:43', 'PENDING', 'En attente validation budget'),
(11, 2, 2, '2025-12-09 01:43:43', '2025-12-09 03:43:43', 'COMPLETED', 'Réunion client - Projet Alpha'),
(12, 3, 1, '2025-12-06 01:43:43', '2025-12-06 04:43:43', 'COMPLETED', 'Formation interne sécurité'),
(13, 4, 4, '2025-12-04 01:43:43', '2025-12-04 05:43:43', 'COMPLETED', 'Workshop Design Thinking'),
(14, 5, 3, '2025-12-14 01:43:43', '2025-12-14 03:43:43', 'CANCELLED', 'Réunion annulée par utilisateur'),
(15, 6, 2, '2025-12-27 14:00:00', '2025-12-27 15:00:00', 'CANCELLED', NULL);
