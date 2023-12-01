# Set base image (host OS)
FROM ubuntu:latest

# By default, listen on port 5000
EXPOSE 5000/tcp

RUN apt update
RUN apt upgrade -y
RUN apt install python3 -y
RUN apt install pip -y
RUN apt install g++

# Set the working directory in the container
WORKDIR /app
RUN mkdir /data &&\
    mkdir /data/uploadedfiles &&\
    mkdir /output_csv
    
RUN apt-get install ffmpeg mediainfo sox libsox-fmt-mp3 -y

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install any dependencies
RUN pip install -r requirements.txt
RUN apt-get install ffmpeg mediainfo sox libsox-fmt-mp3 -y
ENV REACT_APP_OPENAI_API_KEY=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

# Copy the content of the local src directory to the working directory
COPY app.py .

# Specify the command to run on container start
CMD [ "python3", "./app.py" ]