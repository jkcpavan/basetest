FROM  mcr.microsoft.com/dotnet/core/sdk:3.1.201-bionic

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tzdata \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update; apt-get clean

# Add a user for running applications.
RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps

# Install x11vnc.
RUN apt-get install -y x11vnc

# Install xvfb.
RUN apt-get install -y xvfb

# Install fluxbox.
RUN apt-get install -y fluxbox

# Install wget.
RUN apt-get install -y wget

# Install wmctrl.
RUN apt-get install -y wmctrl

# Set the Chrome repo.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Install Chrome.
RUN apt-get update && apt-get -y install google-chrome-stable

RUN set -x \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
ca-certificates \
curl \
unzip \
&& mkdir \opt\selenium \
&& curl -sSL "https://chromedriver.storage.googleapis.com/81.0.4044.69/chromedriver_linux64.zip" -o /tmp/chromedriver.zip \
&& unzip -o /tmp/chromedriver -d /usr/bin \
&& rm -rf /tmp/*.deb \
&& apt-get purge -y --auto-remove curl unzip

#COPY bootstrap.sh /

#RUN chmod a+x /bootstrap.sh
CMD ["chmod", "+x", "/bootstrap.sh"]
RUN chmod a+x /usr/bin/chromedriver
CMD ["chmod", "+x", "/usr/bin/chromedriver"]

#CMD '/bootstrap.sh'

WORKDIR /src
COPY . .
RUN dotnet build
WORKDIR /src/bin/Debug/netcoreapp3.1
CMD ["dotnet", "test", "basetest.dll"]