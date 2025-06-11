FROM jenkins/jenkins

ENV JENKINS_USER=sasha
ENV JENKINS_PASS=Sasha_09092003
# Skip initial setup
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

# Create Jenkins directories for jobs and configs
RUN mkdir -p /usr/share/jenkins/ref/jobs/react-app-deployment/
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d/

# Copy Jenkins plugin list and install them
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --verbose --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy job configuration
COPY config.xml /usr/share/jenkins/ref/jobs/react-app-deployment/config.xml

# Add script to create credentials for GitHub and DockerHub
COPY jenkins-init.groovy /usr/share/jenkins/ref/init.groovy.d/

USER root
# Install Docker
RUN apt-get update -qq && \
    apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release && \
    mkdir -m 0755 -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update -qq && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
    apt-get clean

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Add jenkins user to the docker group

RUN groupmod -o -g 998 docker || true && \
    usermod -aG docker jenkins && \
    chmod 666 /var/run/docker.sock || true

# Install Node.js for React application builds
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

USER jenkins