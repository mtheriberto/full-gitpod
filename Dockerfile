FROM gitpod/workspace-full:latest

USER root

# Install custom tools, runtime, etc.
RUN apt-get update && apt-get install -y \
    fonts-powerline \
    zsh \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

RUN npm install -g @angular/cli

USER gitpod

# Apply user-specific settings
ENV ZSH_THEME agnoster
 RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Give back control
USER root

# Install .Net Core 3
RUN wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && rm -rf packages-microsoft-prod.deb && \
    add-apt-repository universe && \
    apt-get update && apt-get -y -o APT::Install-Suggests="true" install dotnet-sdk-3.1 && \
    rm -rf /var/lib/apt/lists/*;
