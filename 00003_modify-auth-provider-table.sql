-- +goose Up
ALTER TABLE auth_user_provider
    DROP COLUMN name,
    ADD COLUMN identifier text,
    ADD COLUMN auth_user_id int not null,
    ADD CONSTRAINT fk_auth_user
        FOREIGN KEY(auth_user_id) references auth_user(auth_user_id) on delete cascade INITIALLY DEFERRED,
    ALTER COLUMN email DROP NOT NULL;
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION updated_at_column()	
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;	
END;
$$ language 'plpgsql';

CREATE TRIGGER updated_at_auth_user_provider 
    BEFORE UPDATE ON auth_user_provider 
    FOR EACH ROW EXECUTE PROCEDURE  updated_at_column();

CREATE TRIGGER updated_at_auth_user 
    BEFORE UPDATE ON auth_user 
    FOR EACH ROW EXECUTE PROCEDURE  updated_at_column();

CREATE TRIGGER updated_at_auth_role 
    BEFORE UPDATE ON auth_role 
    FOR EACH ROW EXECUTE PROCEDURE  updated_at_column();
-- +goose StatementEnd

-- +goose Down
ALTER TABLE auth_user_provider
    ALTER COLUMN email TYPE citext not null,
    DROP CONSTRAINT fk_auth_user,
    DROP COLUMN auth_user_id,
    DROP COLUMN identifier,
    ADD COLUMN name txt not null;

DROP FUNCTION IF EXISTS updated_at_column();

