-- Create Tables
-- ================================================================
-- Document
create table image
(
    product_id bigint  not null references product (product_id),
    position   integer not null,
    img_bytes  bytea   not null,

    primary key (product_id, position)
);