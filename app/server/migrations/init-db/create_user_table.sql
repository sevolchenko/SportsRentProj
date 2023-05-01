-- Create Sequences
-- ================================================================
create sequence user_sequence start with 1 increment by 1;

-- Create Tables
-- ================================================================
-- Document
create table app_user
(
    user_id  bigint primary key default nextVal('user_sequence'),
    email    varchar not null unique,
    name     varchar not null,
    password varchar not null
);