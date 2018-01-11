-- +goose Up
-- SQL in this section is executed when the migration is applied.

CREATE TABLE auth_permission (
    auth_permission_id SERIAL not null,
    permission text not null,
    description text,
    PRIMARY KEY (auth_permission_id),
    CONSTRAINT auth_permission_c1 UNIQUE(permission),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW()
);

COMMENT ON TABLE auth_permission IS 'Permission defines what an user can do in the system, create-user, delete-user, 
create-gene-model etc. It defined a granular level of actions for the user';

COMMENT ON COLUMN auth_permission.permission IS 'The name of the permission, the name is arbitary but unique';

COMMENT ON COLUMN auth_permission.description IS 'A human readable detail textual description of the permission';

create table auth_role (
    auth_role_id SERIAL not null,
    role text not null,
    description text,
    PRIMARY KEY(auth_role_id),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW()
);

COMMENT ON TABLE auth_role IS 'An auth role is a set of activities. It defines a set of permission an user can perform';

COMMENT ON COLUMN auth_role.role IS 'The name of the role, could be arbitrary';

create table auth_role_permission (
    auth_role_permission_id SERIAL not null,
    auth_role_id int not null, 
    auth_permission_id int not null,
    PRIMARY KEY (auth_role_permission_id),
    FOREIGN KEY (auth_role_id) references auth_role(auth_role_id) on delete cascade INITIALLY DEFERRED,
    FOREIGN KEY (auth_permission_id) references auth_permission(auth_permission_id) on delete cascade INITIALLY DEFERRED,
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW(),
    CONSTRAINT auth_role_permission_c1 unique (auth_role_id, auth_permission_id)
);

COMMENT ON TABLE auth_role_permission IS 'The linking table between auth_permission and auth_role. 
Allows to define roles with activities and the same permission spreads accross multiple roles.';

create table auth_user (
    auth_user_id SERIAL not null,
    first_name text not null,
    last_name text not null,
    email citext not null,
    is_active boolean not null DEFAULT true,
    PRIMARY KEY(auth_user_id),
    CONSTRAINT auth_user_c1 unique (email),
    created_at timestamp with time zone DEFAULT NOW(),
    updated_at timestamp with time zone DEFAULT NOW()
);

COMMENT ON TABLE auth_user IS 'The primary table for the user information, it only stores email and name only.';

COMMENT ON COLUMN auth_user.email IS 'Store emails of every user, the value has to be unique.
Email is treated case-insensitive and citext provides a case-insensitive data type';

COMMENT ON COLUMN auth_user.is_active IS 'Column for active or inactive user';

create table auth_user_info (
    auth_user_info_id SERIAL not null,
    organization varchar(255),
    group_name text,
    first_address text,
    second_address text,
    city varchar(255),
    state varchar(50),
    zipcode varchar(30),
    country varchar(20),
    phone varchar(30),
    auth_user_id int not null,
    PRIMARY KEY(auth_user_info_id),
    FOREIGN KEY(auth_user_id) references auth_user(auth_user_id)  on delete cascade INITIALLY DEFERRED
);

COMMENT ON TABLE auth_user_info IS 'A table to store optional user information.';

create table auth_user_role (
    auth_user_role_id SERIAL not null,
    auth_user_id int not null,
    auth_role_id int not null,
    PRIMARY KEY(auth_user_role_id),
    FOREIGN KEY (auth_user_id) references auth_user(auth_user_id) on delete cascade INITIALLY DEFERRED,
    FOREIGN KEY (auth_role_id) references auth_role(auth_role_id) on delete cascade INITIALLY DEFERRED
);

COMMENT ON TABLE auth_user_role IS 'Linking table between user and role';

-- +goose Down

DROP TABLE auth_permission, auth_role, auth_role_permission,
    auth_user, auth_user_info, auth_user_role; 
-- SQL in this section is executed when the migration is rolled back.
