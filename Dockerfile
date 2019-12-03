FROM mcr.microsoft.com/dotnet/core/sdk:3.0-nanoserver-1809 AS build
WORKDIR /src
COPY mydotnetapp.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-nanoserver-1809
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "mydotnetapp.dll"]