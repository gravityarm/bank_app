postgres:
	sudo docker run --name psg -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -p 5432:5432 -d postgres
createdb:
	sudo docker exec -it psg createdb --username=root --owner=root simple_bank
dropdb:
	sudo docker exec -it psg dropdb simple_bank
migrateup:
	migrate -path db/migration -database postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable -verbose up
migratedown:
	migrate -path db/migration -database postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY: postgres createdb dropdb migrateup migratedown