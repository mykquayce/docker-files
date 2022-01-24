cp -Force .\certificates\ca.crt .\dotnet

$images = @( "aspnet", "runtime", "sdk" )

foreach ($image in $images)
{
	docker pull mcr.microsoft.com/dotnet/${image}:latest | findstr "Status: Image is up to date"

	if ($?)
	{
		continue
	}

	docker build --file .\dotnet\${image}-dockerfile --tag eassbhhtgu/dotnet-${image}-base:latest .\dotnet
	docker push eassbhhtgu/dotnet-${image}-base:latest
}

rm .\dotnet\*.crt
