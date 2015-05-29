<?php
$metadata['https://saml.sp.local/simplesaml/module.php/saml/sp/metadata.php/default-sp'] = array(
	'AssertionConsumerService' => 'https://saml.sp.local/simplesaml/module.php/saml/sp/saml2-acs.php/default-sp',
	'SingleLogoutService' => 'https://saml.sp.local/simplesaml/module.php/saml/sp/saml2-logout.php/default-sp'
);
$metadata['https://local.airspringsoftware.com/idp']=array(
	'AssertionConsumerService' => 'https://local.airspringsoftware.com:6001/auth/saml/callback',
	'SingleLogoutService' => 'https://saml.sp.local/simplesaml/module.php/saml/sp/saml2-logout.php/default-sp'
);
