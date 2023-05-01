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
    product_id bigint                   not null,
    size_name  varchar                  not null,
    count      integer                  not null,
    price      integer                  not null,
    created_at timestamp with time zone not null,
    start_time timestamp with time zone not null,
    end_time   timestamp with time zone not null,
    receipt_id uuid references receipt (receipt_id),
    status     varchar            default 'CREATED',

    foreign key (product_id, size_name) references size (product_id, name)
);