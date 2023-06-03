insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (2, timestamptz '2020-09-27 20:00', timestamptz '2020-09-27 23:00', timestamptz '2020-09-27 23:00', timestamptz '2020-09-27 19:00', 4, 'Взрослый', 2, 500, '9c383b44-022d-11ee-be56-0242ac120002', 'FINISHED');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (1, timestamptz '2023-06-03 16:00', timestamptz '2023-06-03 19:00', timestamptz '2023-06-03 20:00', timestamptz '2023-03-06 15:00', 5, '5', 1, 500, '17622af8-0230-11ee-be56-0242ac120002', 'AWAITING_PAYMENT');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (1, timestamptz '2023-06-03 16:00', timestamptz '2023-06-03 19:00', timestamptz '2023-06-03 20:00', timestamptz '2023-03-06 15:00', 5, '4', 1, 500, '17622af8-0230-11ee-be56-0242ac120002', 'AWAITING_PAYMENT');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (3, timestamptz '2021-06-05 11:00', timestamptz '2021-06-05 13:00', timestamptz '2021-06-05 15:00', timestamptz '2021-06-05 10:00', 6, '7', 3, 500, 'f9d946a0-0230-11ee-be56-0242ac120002', 'FINISHED');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (3, timestamptz '2021-06-05 11:00', timestamptz '2021-06-05 13:00', timestamptz '2021-06-05 15:00', timestamptz '2021-06-05 10:00', 8, '185', 2, 3000, 'f9d946a0-0230-11ee-be56-0242ac120002', 'FINISHED');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (2, timestamptz '2023-06-04 19:00', timestamptz '2023-06-06 19:00', null, timestamptz '2023-06-04 18:00', 4, 'Детский', 3, 500, null, 'CREATED');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (2, timestamptz '2023-06-04 19:00', timestamptz '2023-06-06 19:00', null, timestamptz '2023-06-04 18:00', 1, 'Детский', 2, 1000, null, 'CREATED');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (2, timestamptz '2023-06-03 19:00', timestamptz '2023-06-06 19:00', null, timestamptz '2023-06-03 18:00', 2, 'Взрослый', 1, 700, null, 'CREATED');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (3, timestamptz '2023-06-03 19:00', timestamptz '2023-04-06 19:00', null, timestamptz '2023-06-03 18:00', 7, '43', 5, 1000, null, 'CREATED');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (3, timestamptz '2023-06-03 12:00', timestamptz '2023-06-03 15:00', null, timestamptz '2023-06-03 11:00', 3, 'Один размер', 3, 500, null, 'EXPIRED');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, receipt_id, status)
values (3, timestamptz '2023-06-03 12:00', timestamptz '2023-06-03 15:00', null, timestamptz '2023-06-03 11:00', 4, 'Детский', 3, 700, null, 'EXPIRED');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, status)
values (2, timestamptz '2023-06-03 12:00', timestamptz '2023-06-10 12:00', null, timestamptz '2023-06-03 11:00', 2, 'Детский', 1, 700, 'ONGOING');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, status)
values (1, timestamptz '2023-06-03 12:00', timestamptz '2023-06-10 12:00', null, timestamptz '2023-06-03 11:00', 2, 'Детский', 1, 700, 'ONGOING');

insert into rent_event (user_id, start_time, end_time, finished_at, created_at, product_id, size_name, count, price, status)
values (3, timestamptz '2023-06-03 12:00', timestamptz '2023-06-10 12:00', null, timestamptz '2023-06-03 11:00', 2, 'Детский', 1, 700, 'ONGOING');
