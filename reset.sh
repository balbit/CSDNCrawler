#!/bin/bash

# This script deletes everything! Be very careful

echo "Warning: This clears everything you've crawled!!"

read -p "Are you sure? (y/n)" -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo "Clearing..."

rm {urlsqueue,urlsdone,got}/*

touch urlsdone/1
cp seed_urls urlsqueue/1
touch got/dump
