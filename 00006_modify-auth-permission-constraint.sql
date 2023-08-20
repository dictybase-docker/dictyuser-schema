-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE auth_permission
    DROP constraint auth_permission_c1,
    ADD CONSTRAINT auth_permission_c1 UNIQUE(permission,resource);

