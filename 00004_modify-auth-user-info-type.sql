-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE auth_user_info
    ALTER COLUMN city TYPE text,
    ALTER COLUMN state TYPE text,
    ALTER COLUMN zipcode TYPE text,
    ALTER COLUMN country TYPE text,
    ALTER COLUMN phone TYPE text;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE auth_user_info
    ALTER COLUMN city TYPE varchar(255),
    ALTER COLUMN state TYPE varchar(50),
    ALTER COLUMN zipcode TYPE varchar(30),
    ALTER COLUMN country TYPE varchar(20),
    ALTER COLUMN phone TYPE varchar(30);
