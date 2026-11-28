-- Database: RecipeSharing

CREATE DATABASE "RecipeSharing"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_user_role
        CHECK (role IN ('USER', 'ADMIN'))
);


CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE recipes (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    title VARCHAR(150) NOT NULL,
    photo VARCHAR(255),
    description VARCHAR(100) NOT NULL,
    instruction TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_recipe_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT chk_recipe_description
        CHECK (char_length(description) <= 100)
);


CREATE TABLE recipe_categories (
    recipe_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,

    PRIMARY KEY (recipe_id, category_id),

    CONSTRAINT fk_recipe_category_recipe
        FOREIGN KEY (recipe_id)
        REFERENCES recipes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_recipe_category_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE CASCADE
);


INSERT INTO categories (name)
VALUES
    ('Indonesian'),
    ('Vegetarian'),
    ('Pedas'),
    ('Dessert'),
    ('Breakfast'),
    ('Dinner');


INSERT INTO recipes
(user_id, title, photo, description, instruction)
VALUES
(
    1,
    'Nasi Goreng Spesial',
    'nasi-goreng.jpg',
    'Nasi goreng dengan telur dan ayam.',
    'Panaskan minyak. Tumis bawang. Masukkan ayam dan telur. Tambahkan nasi dan bumbu. Aduk hingga matang.'
);


INSERT INTO recipe_categories
(recipe_id, category_id)
VALUES
    (1, 1),
    (1, 3),
    (1, 6);