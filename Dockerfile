# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY src/HelloWorld/*.csproj ./HelloWorld/
RUN dotnet restore ./HelloWorld/HelloWorld.csproj

# Copy the remaining source code and build the application
COPY src/HelloWorld/. ./HelloWorld/
WORKDIR /app/HelloWorld
RUN dotnet publish -c Release -o /app/out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
