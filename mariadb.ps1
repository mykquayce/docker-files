docker pull mariadb:latest | findstr "Status: Image is up to date"

if ($?)
{
	return
}

openssl x509 -in .\certificates\ca.crt -out .\mariadb\ca.pem -outform PEM
openssl x509 -in .\certificates\mariadb.crt -out .\mariadb\mariadb.pem -outform PEM
openssl rsa -in .\certificates\mariadb.key -text > .\mariadb\mariadb_key.pem

docker build --file .\mariadb\mariadb-dockerfile --tag eassbhhtgu/mariadb:latest .\mariadb
docker push eassbhhtgu/mariadb:latest

rm .\mariadb\*.pem
