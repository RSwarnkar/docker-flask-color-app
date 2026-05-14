FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Python + venv support
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Create virtual environment
RUN python3 -m venv /opt/venv

# Copy requirements first
COPY requirements.txt .

# Install inside venv
RUN /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# Copy app
COPY app.py .
COPY templates/ ./templates/

# Use venv automatically
ENV PATH="/opt/venv/bin:$PATH"

EXPOSE 8083

CMD ["python", "app.py"]