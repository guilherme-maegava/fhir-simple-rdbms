CREATE TABLE observation.patient (
	id int8 NULL,
	payload jsonb NULL,
	CONSTRAINT patient_pk PRIMARY KEY (id)
);

CREATE SEQUENCE observation.patient_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;

ALTER TABLE observation.patient ALTER COLUMN id SET DEFAULT nextval('observation.patient_id_seq');

CREATE TABLE observation.coverage (
	id int8 NOT NULL,
	subscriber_id int8 NULL,
	beneficiary_id int8 NULL,
	payload jsonb NOT NULL,
	CONSTRAINT coverage_pk PRIMARY KEY (id),
	CONSTRAINT coverage_subscriber_id_fk FOREIGN KEY (subscriber_id) REFERENCES observation.patient(id),
	CONSTRAINT coverage_beneficiary_id_fk FOREIGN KEY (beneficiary_id) REFERENCES observation.patient(id)
);

CREATE SEQUENCE observation.coverage_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;

ALTER TABLE observation.coverage ALTER COLUMN id SET DEFAULT nextval('observation.coverage_id_seq');

CREATE TABLE observation.service_request (
	id int8 NOT NULL,
	subject_id int8 NULL,
	insurance_id int8 NULL,
	payload jsonb NOT NULL,
	CONSTRAINT service_request_pk PRIMARY KEY (id),
	CONSTRAINT service_request_subject_id_fk FOREIGN KEY (subject_id) REFERENCES observation.patient(id),
	CONSTRAINT service_request_insurance_id_fk FOREIGN KEY (insurance_id) REFERENCES observation.coverage(id)
);

CREATE SEQUENCE observation.service_request_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;

ALTER TABLE observation.service_request ALTER COLUMN id SET DEFAULT nextval('observation.service_request_id_seq');

CREATE TABLE observation.diagnostic_report (
	id int8 NOT NULL,
	subject_id int8 NULL,
	service_request_id int8 NULL,
	payload jsonb NOT NULL,
	CONSTRAINT diagnostic_report_pk PRIMARY KEY (id),
	CONSTRAINT diagnostic_report_subject_id_fk FOREIGN KEY (subject_id) REFERENCES observation.patient(id),
	CONSTRAINT diagnostic_report_service_request_id_fk FOREIGN KEY (service_request_id) REFERENCES observation.service_request(id)
);

CREATE SEQUENCE observation.diagnostic_report_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;

ALTER TABLE observation.diagnostic_report ALTER COLUMN id SET DEFAULT nextval('observation.diagnostic_report_id_seq');






