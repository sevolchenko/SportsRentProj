-- Create Sequences
-- ================================================================
create sequence product_sequence start with 1 increment by 1;

-- Create Tables
-- ================================================================
-- Document
create table product
(
    product_id  bigint primary key default nextVal('product_sequence'),
    name        varchar not null,
    description varchar,
    price       integer,
    category_id bigint  not null references category (category_id)
);