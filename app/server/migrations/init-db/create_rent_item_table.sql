-- Create Tables
-- ================================================================
-- Document
create table rent_item
(
    rent_id    bigint  not null references rent_event (rent_id),
    product_id bigint  not null,
    size_name  varchar not null,
    count      integer not null,
    price      integer not null,
    receipt_id uuid references receipt (receipt_id),

    primary key (rent_id, product_id, size_name),

    foreign key (product_id, size_name) references size (product_id, name)
);