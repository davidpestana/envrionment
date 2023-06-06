developfile = deploys/develop/docker-compose.yaml
toolsfile = deploys/develop/tools.yaml

user = 1000

start:  ## starup all services
	docker compose -f ${developfile} up -d
	docker compose -f ${developfile} logs -f
cleanup:   ## clean data and temp files
	docker compose -f ${developfile} down --remove-orphans


install:   ## install dependencies
	docker compose -f ${developfile} run --user ${user} --rm auth-service npm i
	docker compose -f ${developfile} run --user ${user} --rm user-pannel npm i


clone: ## clone main repositories
	cd src && \
	git clone git@github.com:Cerveza-Tropical/proyecto-xxxx.git auth-service

angular: ## create angular container for ops
	docker compose -f ${toolsfile} run --user  ${user} -it --rm angular


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

