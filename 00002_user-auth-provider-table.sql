-- +goose Up
-- SQL in this section is executed when the migration is applied.

create table auth_provider (
    auth_provider_id SERIAL not null,
    name text not null,
    PRIMARY KEY(auth_provider_id)
);

COMMENT ON TABLE auth_provider IS 'The table to keep track of third party(like google, facebook etc.) authorization provider';

COMMENT ON COLUMN auth_provider.name IS 'Canonical name of the provider';

create table auth_user_provider (
    auth_user_provider_id SERIAL not null,
    name text not null,
    email citext not null,
    auth_provider_id int not null,
    PRIMARY KEY(auth_user_provider_id),
    FOREIGN KEY (auth_provider_id) references auth_provider(auth_provider_id) on delete cascade INITIALLY DEFERRED,
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW()
);

COMMENT ON TABLE auth_user_provider IS 'The table to link user and authentication provider. 
It allows an individual user to authenticate with multiple providers';

COMMENT ON COLUMN auth_user_provider.email IS 'Email of the user that is provided to the third party provider';

COMMENT ON COLUMN auth_user_provider.name IS 'Name of the user that is provided to the third party provider.';
-- +goose Down
DROP TABLE auth_provider, auth_user_provider;
-- SQL in this section is executed when the migration is rolled back.
