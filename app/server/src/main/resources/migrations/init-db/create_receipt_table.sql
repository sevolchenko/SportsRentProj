-- Create Tables
-- ================================================================
-- Document
create table receipt
(
    receipt_id  uuid primary key                  default gen_random_uuid(),
    user_id     bigint                   not null references app_user (user_id),
    employee_id bigint                   not null references app_user (user_id),
    created_at  timestamp with time zone not null,
    status      varchar                  not null default ('CREATED')
);