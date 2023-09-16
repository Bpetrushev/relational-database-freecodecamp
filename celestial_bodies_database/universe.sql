CREATE DATABASE universe;

\c universe;

CREATE TABLE galaxy (
    galaxy_id serial PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    distance_kly DOUBLE PRECISION,
    constellation TEXT,
    first_observation_year NUMERIC(4, 0),
    has_black_hole BOOLEAN NOT NULL,
    number_of_stars INT NOT NULL,
    description TEXT
);

CREATE TABLE star (
    star_id serial PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    type VARCHAR(100),
    mass NUMERIC(10, 2),
    luminosity NUMERIC(10, 2),
    galaxy_id INT REFERENCES galaxy(galaxy_id),
    is_binary_star BOOLEAN NOT NULL,
    age_in_millions INT NOT NULL,
);

CREATE TABLE planet (
    planet_id serial PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    star_id INT REFERENCES star(star_id),
    has_atmosphere BOOLEAN NOT NULL,
    orbital_period_days NUMERIC(8, 2),
    description TEXT
);

CREATE TABLE moon (
    moon_id serial PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    planet_id INT REFERENCES planet(planet_id),
    is_in_habitable_zone BOOLEAN NOT NULL,
    diameter_km NUMERIC(8, 2),
    description TEXT
);

CREATE TABLE comet (
    comet_id serial PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,  -- Added UNIQUE constraint
    discovered_by VARCHAR(150),
    discovery_year NUMERIC(4, 0),
    is_periodic BOOLEAN NOT NULL,  -- Added NOT NULL constraint
    description TEXT
);

INSERT INTO galaxy (name, distance_kly, constellation, first_observation_year, has_black_hole, number_of_stars, description)
VALUES
    ('Milky Way', 100, 'Orion', 1700, TRUE, 200, 'Our home galaxy'),
    ('Andromeda', 150, 'Andromeda', 1764, FALSE, 250, 'Nearest spiral galaxy to Milky Way'),
    ('Triangulum', 120, 'Triangulum', 1805, FALSE, 150, 'Spiral galaxy in the Local Group'),
    ('Sombrero Galaxy', 28, 'Virgo', 1935, TRUE, 800, 'Spiral galaxy with a prominent dust lane'),
    ('Whirlpool Galaxy', 31, 'Canes Venatici', 1773, FALSE, 300, 'Interacting spiral galaxy pair'),
    ('Centaurus A', 13, 'Centaurus', 1826, TRUE, 200, 'Active galaxy with a prominent dark band');

INSERT INTO star (name, type, mass, luminosity, galaxy_id, is_binary_star, age_in_millions, description)
VALUES
    ('Sun', 'G-type main-sequence', 1.989e30, 3.827e26, 1, FALSE, 4600, 'Our star'),
    ('Alpha Centauri A', 'G-type main-sequence', 2.18e30, 4.84e26, 1, TRUE, 6600, 'Closest star system to Sun'),
    ('Proxima Centauri', 'M-type red dwarf', 2.83e29, 8.5e22, 1, FALSE, 500, 'Nearest known star to the Sun'),
    ('Sirius', 'A-type main-sequence', 2.02e30, 6.12e28, 1, FALSE, 200, 'Brightest star in the night sky'),
    ('Betelgeuse', 'M-type supergiant', 1.47e32, 1.21e31, 1, FALSE, 800, 'Red supergiant in Orion'),
    ('Vega', 'A-type main-sequence', 2.12e30, 5.42e28, 1, FALSE, 450, 'Bright star in the summer sky');

INSERT INTO planet (name, star_id, has_atmosphere, orbital_period_days, description)
VALUES
    ('Earth', 1, TRUE, 365.25, 'Our home planet'),
    ('Mars', 1, TRUE, 687, 'Fourth planet from the Sun'),
    ('Venus', 1, TRUE, 225, 'Second planet from the Sun'),
    ('Jupiter', 2, TRUE, 4331, 'Largest planet in the solar system'),
    ('Saturn', 2, TRUE, 10747, 'Known for its prominent ring system'),
    ('Uranus', 3, TRUE, 30660, 'Ice giant planet with a unique rotation'),
    ('Neptune', 3, TRUE, 60148, 'Distant ice giant planet'),
    ('Mercury', 4, TRUE, 88, 'Closest planet to the Sun'),
    ('Pluto', 4, FALSE, 90560, 'Dwarf planet in the Kuiper belt'),
    ('Kepler-186f', 5, TRUE, 129.9, 'Exoplanet in the habitable zone'),
    ('HD 209458b', 6, FALSE, 3.5, 'Exoplanet with an evaporating atmosphere'),
    ('Gliese 581c', 6, TRUE, 12.9, 'Exoplanet in the Gliese 581 system');

INSERT INTO moon (name, planet_id, is_in_habitable_zone, diameter_km, description)
VALUES
    ('Moon', 1, TRUE, 3474.8, 'Earth\'s natural satellite'),
    ('Phobos', 2, FALSE, 22.4, 'Larger moon of Mars'),
    ('Deimos', 2, FALSE, 12.4, 'Smaller moon of Mars'),
    ('Ganymede', 3, FALSE, 5262, 'Largest moon in the solar system'),
    ('Callisto', 3, FALSE, 4821, 'Second-largest moon of Jupiter'),
    ('Titan', 4, TRUE, 5150, 'Largest moon of Saturn'),
    ('Europa', 4, TRUE, 3121.6, 'Icy moon of Jupiter'),
    ('Miranda', 5, FALSE, 235.8, 'Moon of Uranus'),
    ('Triton', 5, FALSE, 2706.8, 'Moon of Neptune'),
    ('Enceladus', 6, TRUE, 252.1, 'Moon of Saturn'),
    ('Charon', 7, FALSE, 1207, 'Largest moon of Pluto'),
    ('Luna', 1, TRUE, 1737.4, 'Moon of Earth'),
    -- Add more rows to meet the requirement of at least 20 rows
    ('Phoebe', 8, FALSE, 213, 'Irregular moon of Saturn'),
    ('Iapetus', 8, FALSE, 1436, 'Moon of Saturn with a two-tone coloration'),
    ('Oberon', 9, FALSE, 1523.2, 'Moon of Uranus'),
    ('Proteus', 9, FALSE, 420, 'Moon of Neptune with an irregular shape'),
    ('Dysnomia', 10, FALSE, 700, 'Moon of Eris'),
    ('Eris', 10, FALSE, 2326, 'Dwarf planet in the Kuiper belt'),
    ('Dactyl', 11, FALSE, 1.4, 'Moon of Ida'),
    ('Ida', 11, FALSE, 32.1, 'Asteroid in the asteroid belt'),
    ('Pandora', 12, FALSE, 81.2, 'Moon of Saturn with a chaotic orbit');

INSERT INTO comet (name, discovered_by, discovery_year, is_periodic, description)
VALUES
    ('Halley''s Comet', 'Edmund Halley', 1705, TRUE, 'Famous periodic comet'),
    ('Comet Hale-Bopp', 'Alan Hale and Thomas Bopp', 1995, TRUE, 'Bright comet with a long tail'),
    ('Comet NEOWISE', 'NASA''s NEOWISE mission', 2020, TRUE, 'Bright comet visible to the naked eye'),
    ('Comet Hyakutake', 'Yuji Hyakutake', 1996, TRUE, 'Great comet of 1996'),
    ('Comet ISON', 'International Scientific Optical Network', 2012, TRUE, 'Sungrazing comet'),
    ('Comet Lovejoy', 'Terry Lovejoy', 2011, TRUE, 'Bright comet discovered by an amateur astronomer'),
    ('Comet West', 'Richard West', 1976, TRUE, 'Bright comet visible from the Southern Hemisphere'),
    ('Comet C/2020 F3 (NEOWISE)', 'NASA''s NEOWISE mission', 2020, TRUE, 'Recent bright comet'),
    ('Comet 67P/Churyumov-Gerasimenko', 'Klim Ivanovych Churyumov and Svetlana Ivanovna Gerasimenko', 1969, TRUE, 'Comet studied by the Rosetta spacecraft'),
    ('Comet 1P/Halley', 'Edmund Halley', 1682, TRUE, 'Historical comet with a well-known orbit'),
    ('Comet Tempel-Tuttle', 'Ernst Wilhelm Tempel and Horace Parnell Tuttle', 1865, TRUE, 'Parent comet of the Leonid meteor shower'),
    ('Comet 81P/Wild', 'Paul Wild', 1978, TRUE, 'Comet visited by the Stardust spacecraft');

-- SUBTASKS
-- Your database should have at least five tables
-- Each table should have at least three rows
-- The galaxy and star tables should each have at least six rows
-- At least one column from each table should be required to be UNIQUE
-- All columns named name should be of type VARCHAR
-- Each primary key column should follow the naming convention table_name_id. For example, the moon table should have a primary key column named moon_id
-- Each foreign key column should have the same name as the column it is referencing