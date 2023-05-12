-- Create Sequences
-- ================================================================
create sequence category_sequence start with 1 increment by 1;

-- Create Tables
-- ================================================================
-- Document
create table category
(
    category_id        bigint primary key default nextVal('category_sequence'),
    parent_category_id bigint references category (category_id),
    name               varchar not null unique
);