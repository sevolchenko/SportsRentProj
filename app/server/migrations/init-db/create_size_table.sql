-- Create Tables
-- ================================================================
-- Document
create table size
(
    product_id bigint  not null references product (product_id),
    name       varchar not null,
    total      integer not null default 0,

    primary key (product_id, name)
);