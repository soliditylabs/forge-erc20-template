#!/usr/bin/env bash

if [ -f .env ]
then
  export $(cat .env | xargs) 
else
    echo "Please set your .env file"
    exit 1
fi

forge create ./src/MyERC20.sol:MyERC20 -i --rpc-url 'https://rinkeby.infura.io/v3/'${INFURA_API_KEY} --private-key ${PRIVATE_KEY}