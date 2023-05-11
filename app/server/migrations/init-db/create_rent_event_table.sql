-- Create Sequences
-- ================================================================
create sequence rent_sequence start with 1 increment by 1;

-- Create Tables
-- ================================================================
-- Document
create table rent_event
(
    rent_id    bigint primary key default nextVal('rent_sequence'),
    user_id    bigint                   not null references app_user (user_id),
    start_time timestamp with time zone not null,
    end_time   timestamp with time zone not null,
    status     varchar            default 'CREATED'
);