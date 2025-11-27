FROM ubuntu:22.04

# Avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    software-properties-common \
    openjdk-17-jdk \
    git \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Add Jenkins repository & key
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | apt-key add - \
    && echo "deb https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list

# Install Jenkins
RUN apt-get update && apt-get install -y jenkins

# Expose Jenkins port
EXPOSE 8080
EXPOSE 50000

# Jenkins data directory (persistent)
VOLUME /var/jenkins_home

# Start Jenkins
CMD ["bash", "-c", "service jenkins start && tail -f /var/log/jenkins/jenkins.log"]
