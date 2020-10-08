# breedbase_dockerfile
The Dockerfile for [breeDBase](https://github.com/solgenomics/sgn) with configs specific
for the LSU rice breeding program. Below are the commands needed to get the LSU breedbase instance
up and running.


## Start breedbase with docker-compose
```bash
docker-compose up -d
```

## Enter breedbase_web
```bash
docker exec -it breedbase_web bash
```

## Make a new database 'breedbase_fresh' in the the breedbase_db container
```bash
psql -U postgres -h breedbase_db -c "create database breedbase_fresh"
```

## Delete old database 'breedbase' in the the breedbase_db container
```bash
psql -U postgres -h breedbase_db -c "drop database breedbase"
```

## Add user "web_usr" and make password "postgres"
```bash
psql -U postgres -h breedbase_db -c "create user web_usr"
psql -U postgres -h breedbase_db -c "alter user web_usr password 'postgres'"
```

## Fill 'breedbase_fresh' using fixture file
```bash
psql -U postgres -h breedbase_db -d breedbase_fresh -f t/data/fixture/empty_fixture.sql
```

## Run patches on 'breedbase_fresh'
```bash
cd db
./run_all_patches.pl -u web_usr -p postgres  -h breedbase_db -d breedbase_fresh -e janedoe
```

## Load ontologies
```bash
perl ~/cxgn/Chado/chado/bin/gmod_load_cvterms.pl -H breedbase_db -D breedbase_fresh -d Pg -s LSU_01 -v -u -r postgres -n lsuRice -p postgres ~/cxgn/famosolabbase/ontology/lsu_rice.obo 
```

## Delete defualt ontologies
```bash
psql -U postgres -h breedbase_db -d breedbase_fresh -c "delete from cvterm where cv_id = 16 or cv_id = 54 or cv_id = 58 or cv_id = 59 or cv_id = 4 or cv_id = 7 or cv_id =8 or cv_id = 9 or cv_id=10 or cv_id=13 or cv_id=14 or cv_id=19"
psql -U postgres -h breedbase_db -d breedbase_fresh -c "delete from cvprop where cv_id = 16 or cv_id=58 or cv_id=59 or cv_id=64"
```

## Tag ontology as trait ontology
```bash
perl ~/cxgn/sgn/bin/load_composed_cvprops.pl -H breedbase_db -D breedbase_fresh -T lsuRice
```
