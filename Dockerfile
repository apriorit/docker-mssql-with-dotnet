FROM microsoft/mssql-server-linux:latest

RUN wget https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb


RUN apt-get update &&\
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-2.1

# Configure web servers to bind to port 80 when present
ENV ASPNETCORE_URLS=http://+:80 \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true \
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps performance
    NUGET_XMLDOC_MODE=skip

# sqlserver environments
ENV ACCEPT_EULA=Y \
	SA_PASSWORD=passForuUittests

# Trigger first run experience by running arbitrary cmd to populate local package cache
RUN dotnet help