CREATE OR REPLACE FUNCTION fhir.generate_random_patient_payload()
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
	DECLARE
		payload jsonb;
		randomDate varchar;
	    randomCpf varchar;
	begin
		select now()::date::varchar into randomDate;
		select floor(random() * 89999999999 + 10000000000)::int8::varchar into randomCpf;
		payload = '{
			"resourceType" : "Patient",
			"meta" : {
				"lastUpdated" : "' || randomDate || '",
				"profile" : [
					"https://ecossistemalab.gointerop.com/fhir/StructureDefinition/patient"
				]
			},
			"identifier" : [
				{
					"use" : "official",
					"system" : "https://interoperabilidade.dasa.com.br/fhir/NamingSystem-govbr-receitafederal-pessoafisica-id",
					"value" : "' || randomCpf || '"
				}
			],
			"name" : [
				{
					"use" : "official",
					"text" : "Paciente"
				}
			],
			"telecom" : [
				{
					"system" : "phone",
					"value" : "+5561998611032",
					"use" : "home"
				}
			],
			"gender" : "male",
			"birthDate" : "1974-12-25",
			"address" : [
				{
					"use" : "home",
					"type" : "both",
					"line" : [
						"QUADRA P CHACARA 05 LOTE 18",
						"18",
						"72000000"
					],
					"district" : "AGUAS LINDAS",
					"postalCode" : "72000000"
				}
			],
			"generalPractitioner" : [
				{
					"reference" : "Practitioner/example",
					"type" : "Practitioner"
				}
			],
			"managingOrganization" : {
				"reference" : "Organization/example",
				"type" : "Organization"
			}
		}';
	return payload;
	END;
$function$;

CREATE OR REPLACE FUNCTION fhir.generate_random_coverage_payload()
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
	DECLARE
		payload jsonb;
		randomDate varchar;
	    randomCpf varchar;
	begin
		select now()::date::varchar into randomDate;
		select floor(random() * 89999999999 + 10000000000)::int8::varchar into randomCpf;
		payload = '{
			"resourceType" : "Coverage",
			"meta" : {
				"lastUpdated" : "' || randomDate || '",
				"profile" : [
					"https://ecossistemalab.gointerop.com/fhir/StructureDefinition/coverage"
				]
			},
			"identifier" : [
				{
					"use" : "official",
					"system" : "https://ecossistemalab.gointerop.com/fhir/NamingSystem-govbr-receitafederal-pessoafisica-id",
					"value" : "' || randomCpf || '"
				}
			],
			"status" : "active",
			"subscriber" : {
				"reference" : "Patient/example",
				"type" : "Patient"
			},
			"subscriberId" : "0963-XX-8524",
			"beneficiary" : {
				"reference" : "Patient/example",
				"type" : "Patient"
			},
			"payor" : [
				{
					"reference" : "Patient/example",
					"type" : "Patient"
				}
			],
			"class" : [
				{
					"type" : {
						"coding" : [
							{
								"system" : "http:terminology.hl7.org/CodeSystem/coverage-class",
								"code" : "plan"
							}
						]
					},
					"value" : "minemonicoTokyoNarine",
					"name" : "TokyoNarine"
				}
			]
		}';
	return payload;
	END;
$function$;

CREATE OR REPLACE FUNCTION fhir.generate_random_service_request_payload()
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
	DECLARE
		payload jsonb;
		randomDate varchar;
	    randomCpf varchar;
	    randomCode varchar;
	begin
		select now()::date::varchar into randomDate;
		select floor(random() * 89999999999 + 10000000000)::int8::varchar into randomCpf;
		select floor(random() * 8999 + 1000)::int8::varchar into randomCode;
		payload = '{
				"resourceType" : "ServiceRequest",
				"meta" : {
					"lastUpdated" : "' || randomDate || '",
					"profile" : [
						"https://ecossistemalab.gointerop.com/fhir/StructureDefinition/servicerequest"
					]
				},
				"identifier" : [
					{
						"use" : "usual",
						"system" : "https://ecossistemalab.gointerop.com/fhir/NamingSystem-dasa-deepwater-requisicao-codigoorigem",
						"value" : "' || randomCpf || '"
					}
				],
				"status" : "completed",
				"intent" : "order",
				"code" : {
					"coding" : [
						{
							"system" : "http://ecossistemalab.com.br/fhir/CodeSystem-dasa-deepwater-servicerequestcode",
							"code" : "' || randomCode || '"
						}
					]
				},
				"authoredOn" : "' || randomDate || '",
				"subject" : {
					"reference" : "Patient/example",
					"type" : "Patient"
				},
				"requester" : {
					"reference" : "Practitioner/Example",
					"type" : "Practitioner"
				},
				"insurance": [{
				    "reference": "Coverage/Example",
				    "type": "Coverage"
				}]
			}';
	return payload;
	END;
$function$;

CREATE OR REPLACE FUNCTION fhir.generate_random_diagnostic_report_payload()
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
	DECLARE
		payload jsonb;
		randomDate varchar;
	    randomCpf varchar;
	    randomCode varchar;
	    randomCodeNine varchar;
	begin
		select now()::date::varchar into randomDate;
		select floor(random() * 89999999999 + 10000000000)::int8::varchar into randomCpf;
		select floor(random() * 8999 + 1000)::int8::varchar into randomCode;
		select floor(random() * 899999999 + 1000000000)::int8::varchar into randomCodeNine;
	
		payload = '{
			"resourceType" : "DiagnosticReport",
			"status" : "final",
			"meta": {
			    "lastUpdated" : "' || randomDate || '",
				"profile" : [
					"https://ecossistemalab.gointerop.com/fhir/StructureDefinition/diagonosticreport"
				]
			},
			"category" : [
				{
					"coding" : [
						{
							"system" : "http://snomed.info/sct",
							"code" : "' || randomCodeNine || '",
							"display" : "Radiology"
						},
						{
							"system" : "http://terminology.hl7.org/CodeSystem/v2-0074",
							"code" : "RAD"
						}
					]
				}
			],
			"code" : {
				"coding" : [
					{
						"system" : "http://snomed.info/sct",
						"code" : "' || randomCodeNine || '",
						"display" : "Lorem Ipsum Dolor Sit Amet"
					}
				],
				"text" : "Lorem Ipsum"
			},
			"subject" : {
				"reference" : "Patient/Example"
			},
			"effectiveDateTime" : "' || randomDate || '",
			"issued" : "' || randomDate || '",
			"performer" : [
				{
					"reference" : "Practitioner/Example"
				}
			],
			"basedOn": [
			    {
			        "reference": "ServiceRequest/Example",
			        "type": "ServiceRequest"
			    }
			],
			"imagingStudy" : [
				{
					"display" : "Lorem Ipsum Dolor Sit Amet"
				}
			],
			"conclusion" : "Lorem Ipsum Dolor Sit Amet.",
			"conclusionCode" : [
				{
					"coding" : [
						{
							"system" : "http://snomed.info/sct",
							"code" : "' || randomCodeNine || '",
							"display" : "Lorem Ipsum Dolor Sit Amet"
						}
					]
				}
			]
		}';
	return payload;
	END;
$function$;

CREATE OR REPLACE FUNCTION fhir.generate_random_data(max integer)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
	declare 
		i int4;
		patient_id int8;
		coverage_id int8;
		service_request_id int8;
		diagnostic_report_id int8;
	begin
		i = 0;
		
		while i < max loop
			patient_id = nextval('fhir.patient_id_seq');
			coverage_id = nextval('fhir.coverage_id_seq');
			service_request_id = nextval('fhir.service_request_id_seq');
			diagnostic_report_id = nextval('fhir.diagnostic_report_id_seq');
	
			INSERT INTO fhir.patient
			(id, payload)
			VALUES(patient_id, fhir.generate_random_patient_payload());
		
			INSERT INTO fhir.coverage
			(id, subscriber_id, beneficiary_id, payload)
			VALUES(coverage_id, patient_id, patient_id, fhir.generate_random_coverage_payload());
		
			INSERT INTO fhir.service_request
			(id, subject_id, insurance_id, payload)
			VALUES(service_request_id, patient_id, coverage_id, fhir.generate_random_service_request_payload());
		
			INSERT INTO fhir.diagnostic_report
			(id, subject_id, service_request_id, payload)
			VALUES(diagnostic_report_id, patient_id, service_request_id, fhir.generate_random_diagnostic_report_payload());
		
			i = i + 1;
			raise notice '[%/%] Patient % | Coverage % | ServiceRequest % | DiagnosticReport % criados com sucesso', i, max, patient_id, coverage_id, service_request_id, diagnostic_report_id;
		end loop;
		
		return true;
	END;
$function$;
