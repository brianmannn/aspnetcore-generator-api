# Build Stage
FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env

WORKDIR /generator

# restore
COPY /api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY /tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

RUN ls -laR

#COPY src
COPY . .

RUN dotnet test tests/tests.csproj

# publish
RUN dotnet publish api/api.csproj -o /publish

# Runtime Image Stage
FROM mcr.microsoft.com/dotnet/core/aspnet:3.0
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "api.dll"]