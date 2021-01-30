#!/bin/bash

# ----------------------------------
# Colors
# ----------------------------------
RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

echo -e "${CYAN}Assuming that this is running from the examples directory, we'll run the maven build before starting the cluster and submitting the job.${RESET}\n"


echo -e "${LIGHTBLUE}Running maven build...${RESET}\n"
cd SimpleApp
mvn clean package
cp ./target/SimpleApp-1.0.0.jar ../jars/
cd ..
echo -e "\n"

echo -e "${CYAN}Running ${GREEN}docker-compose up --detach${CYAN}...${RESET}\n"
docker-compose up --detach
echo -e "${CYAN}Sleeping for ${GREEN}10 seconds${CYAN} to give the containers time to start.${RESET}\n"
sleep 10
docker ps -a

echo -e "\n\n${CYAN}Submitting sample app...${RESET}\n"
docker-compose exec --index=1 spark-worker /spark/bin/spark-submit --master spark://spark-master:7077  --class app.SimpleApp ./jars/SimpleApp-1.0.0.jar ./data/test.txt

echo -e "${CYAN}Don't forget to run ${GREEN}docker-compose down${CYAN}! :)${RESET}\n\n"
