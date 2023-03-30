#Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build
WORKDIR /src
COPY . .
RUN dotnet restore "./FilmesApi/FilmesApi.csproj" --disable-parallel
RUN dotnet publish "./FilmesApi/FilmesApi.csproj" -c Release -o /app --no-restore

EXPOSE 3001

#Serve stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine AS production
WORKDIR /app
COPY --from=build /app ./

EXPOSE 5000
EXPOSE 5001

ENTRYPOINT ["dotnet", "FilmesApi.dll"]