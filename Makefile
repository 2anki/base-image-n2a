project=alemayhu/base-image-n2a

docker:
	docker build -t ${project} .
docker_deploy: docker docker_push
	echo "Pushed to docker"
docker_run: docker
	docker run -t -i ${project} /bin/bash
docker_push:
	docker push ${project}
.PHONY: create_deck
create_deck:
	curl -o requirements.txt https://raw.githubusercontent.com/2anki/create_deck/main/requirements.txt
