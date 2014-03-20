-- PG extension for creating UUIDs
CREATE EXTENSION "uuid-ossp";

CREATE TABLE polls (
  id bigserial primary key,
  uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
  description text NOT NULL,
  created_at timestamp NOT NULL DEFAULT (now() at time zone 'utc')
);

CREATE INDEX polls_uuid ON polls(uuid);

CREATE TABLE votes (
  id bigserial primary key,
  poll_id integer NOT NULL references polls(id),
  value text NOT NULL,
  created_at timestamp NOT NULL DEFAULT (now() at time zone 'utc')
);

CREATE INDEX votes_poll_id ON votes(poll_id);