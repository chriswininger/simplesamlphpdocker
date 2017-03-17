echo '==== copy to cert field ===='
/stripCert.sh /etc/ssl/certs/simplesamlphp.crt
echo "\n==== copy these lines into the Decryption certs field of the user source ===="
echo "$(cat /etc/ssl/certs/simplesamlphp.crt)"
echo '==== copy these lines into the Private Cert and Decryption Pvk fields of the user source ===='
echo "$(cat /etc/ssl/certs/simplesamlphp.pem)"

