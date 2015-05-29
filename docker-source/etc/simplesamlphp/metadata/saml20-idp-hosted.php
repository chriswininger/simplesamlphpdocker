<?php
$metadata['__DYNAMIC:1__'] = array(
	'host' => '__DEFAULT__',
	'privatekey' => 'simplesamlphp.pem',
	'certificate' => 'simplesamlphp.crt',
	'auth' => 'example-userpass',
	'attributes.NameFormat' => 'urn:oasis:names:tc:SAML:2.0:attrname-format:url',
	'authproc' => array(
		100 => array('class' => 'core:AttributeMap', 'name2oidAirspring')
	)
);
