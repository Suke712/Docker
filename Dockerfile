# Use official Python image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Install uv (packaging and dependency manager)
RUN pip install --no-cache-dir uv

# Copy only dependency files first for build cache optimization
COPY requirements.txt ./

# Install dependencies directly into system Python in the container
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your source code
COPY app.py ./

# (Optional) Set environment variable for Flask CLI (not needed if running app.py directly)
ENV FLASK_APP=app.py

# Expose default Flask port
EXPOSE 5000

# Run your app with system Python in the container
CMD ["python", "app.py"]
