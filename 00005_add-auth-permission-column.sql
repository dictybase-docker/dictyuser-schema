-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE auth_permission
    ADD COLUMN resource text;

