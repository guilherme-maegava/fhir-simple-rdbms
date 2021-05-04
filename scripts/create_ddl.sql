CREATE SCHEMA fhir AUTHORIZATION "admin";

SET search_path = fhir;

CREATE TABLE fhir.patient (
	id int8 NULL,
	payload jsonb NULL,
	CONSTRAINT patient_pk PRIMARY KEY (id)
);

CREATE SEQUENCE fhir.patient_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;

ALTER TABLE fhir.patient ALTER COLUMN id SET DEFAULT nextval('fhir.patient_id_seq');

CREATE TABLE fhir.coverage (
	id int8 NOT NULL,
	subscriber_id int8 NULL,
	beneficiary_id int8 NULL,
	payload jsonb NOT NULL,
	CONSTRAINT coverage_pk PRIMARY KEY (id),
	CONSTRAINT coverage_subscriber_id_fk FOREIGN KEY (subscriber_id) REFERENCES fhir.patient(id),
	CONSTRAINT coverage_beneficiary_id_fk FOREIGN KEY (beneficiary_id) REFERENCES fhir.patient(id)
);

CREATE SEQUENCE fhir.coverage_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;

ALTER TABLE fhir.coverage ALTER COLUMN id SET DEFAULT nextval('fhir.coverage_id_seq');

CREATE TABLE fhir.service_request (
	id int8 NOT NULL,
	subject_id int8 NULL,
	insurance_id int8 NULL,
	payload jsonb NOT NULL,
	CONSTRAINT service_request_pk PRIMARY KEY (id),
	CONSTRAINT service_request_subject_id_fk FOREIGN KEY (subject_id) REFERENCES fhir.patient(id),
	CONSTRAINT service_request_insurance_id_fk FOREIGN KEY (insurance_id) REFERENCES fhir.coverage(id)
);

CREATE SEQUENCE fhir.service_request_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;

ALTER TABLE fhir.service_request ALTER COLUMN id SET DEFAULT nextval('fhir.service_request_id_seq');

CREATE TABLE fhir.diagnostic_report (
	id int8 NOT NULL,
	subject_id int8 NULL,
	service_request_id int8 NULL,
	payload jsonb NOT NULL,
	CONSTRAINT diagnostic_report_pk PRIMARY KEY (id),
	CONSTRAINT diagnostic_report_subject_id_fk FOREIGN KEY (subject_id) REFERENCES fhir.patient(id),
	CONSTRAINT diagnostic_report_service_request_id_fk FOREIGN KEY (service_request_id) REFERENCES fhir.service_request(id)
);

CREATE SEQUENCE fhir.diagnostic_report_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;

ALTER TABLE fhir.diagnostic_report ALTER COLUMN id SET DEFAULT nextval('fhir.diagnostic_report_id_seq');
