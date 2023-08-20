-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE auth_user_info
    ALTER COLUMN city TYPE text,
    ALTER COLUMN state TYPE text,
    ALTER COLUMN zipcode TYPE text,
    ALTER COLUMN country TYPE text,
    ALTER COLUMN phone TYPE text;

