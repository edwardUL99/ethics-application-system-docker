FROM openjdk:11.0.1-slim

RUN mkdir -p /home/ethics
	
COPY app.jar /home/ethics/
COPY ethics-envs.sh /home/ethics/
COPY run-docker.sh /home/ethics/

WORKDIR /home/ethics/

CMD [ "./run-docker.sh" ]
