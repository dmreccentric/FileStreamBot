# FROM python:3.11

# WORKDIR /app
# COPY . /app

# RUN pip install -r requirements.txt

# CMD ["python", "-m", "bot"]


# Use Python 3.11 slim (lighter image)
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies for tgcrypto, uvloop, etc.
RUN apt-get update && apt-get install -y \
    gcc \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project
COPY . .

# Expose the port (must match your PORT env)
EXPOSE 3500

# Start the bot
CMD ["python", "-m", "bot"]
