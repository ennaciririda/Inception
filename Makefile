SRC_DIR = srcs/docker-compose.yml

all:
	docker-compose -f $(SRC_DIR) up --build

clean-imgs:
	@images=$$(docker image ls -q); \
	if [ -n "$$images" ]; then \
		docker rmi -f $$images; \
	fi

clean-containers-volumes:
	@containers=$$(docker ps -aq); \
	if [ -n "$$containers" ]; then \
		docker rm -vf $$containers; \
	fi

fclean: clean-containers-volumes clean-imgs


