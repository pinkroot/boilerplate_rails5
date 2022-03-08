.PHONY: build
build:
	docker-compose -f ./docker-compose_dev.yml build

.PHONY: clean
clean:
	rm -f tmp/pids/server.pid

.PHONY: up
up: clean
	docker-compose -f ./docker-compose_dev.yml up

.PHONY: upd
upd: clean
	docker-compose -f ./docker-compose_dev.yml up -d

.PHONY: down
down:
	docker-compose -f ./docker-compose_dev.yml down

.PHONY: downv
downv:
	docker-compose -f ./docker-compose_dev.yml down -v

.PHONY: bundle
bundle:
	docker-compose -f ./docker-compose_dev.yml run --rm app bundle

.PHONY: c
c:
	docker-compose -f ./docker-compose_dev.yml run --rm app rails c RAILS_ENV=development

.PHONY: db
db:
	psql -h 127.0.0.1 -p 5438 -U postgres database_development

.PHONY: logs
logs:
	docker-compose -f ./docker-compose_dev.yml logs -f

.PHONY: sh
sh:
	docker-compose -f ./docker-compose_dev.yml run --rm app sh

.PHONY: bash
bash:
	docker-compose -f ./docker-compose_dev.yml run --rm app bash

.PHONY: dbreset
dbreset:
	docker-compose -f ./docker-compose_dev.yml run --rm app rails db:drop RAILS_ENV=development
	docker-compose -f ./docker-compose_dev.yml run --rm app rails db:create RAILS_ENV=development

.PHONY: dbinit
dbinit: dbreset migrate
	docker-compose -f ./docker-compose_dev.yml run --rm app rails db:seed RAILS_ENV=development
	docker-compose -f ./docker-compose_dev.yml run --rm app rails db:seed_fu RAILS_ENV=development

.PHONY: seedfu
seedfu: 
	docker-compose -f ./docker-compose_dev.yml run --rm app rails db:seed_fu RAILS_ENV=development

.PHONY: restore
restore: dbreset
	pg_restore --no-owner -h 127.0.0.1 -p 5439 -U postgres -d database_development latest.dump
	rails db:environment:set RAILS_ENV=development

.PHONY: migrate
migrate:
	docker-compose -f ./docker-compose_dev.yml run --rm app rails db:migrate RAILS_ENV=development

.PHONY: init
init: downv build bundle dbinit
