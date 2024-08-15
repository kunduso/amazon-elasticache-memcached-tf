#!/bin/bash
yum update -y
yum install python-pip -y
yum install python3 -y
pip3 install redis-py-cluster
pip3 install boto3
pip3 install botocore
pip3 install pylibmc
echo "The region value is ${Region}"
AWS_REGION=${Region}
local_elasticache_ep=${elasticache_ep}
cat <<EOF >> /var/write_cache.py
import logging
import boto3
import sys
import pylibmc

def main():
    cityname = input("Enter a City Name: ")
    session = boto3.Session(region_name='$AWS_REGION')
    elasticache_endpoint = get_elasticache_endpoint(session)
    write_into_redis_cluster(
        elasticache_endpoint, 
        cityname)

def get_elasticache_endpoint(session):
    ssm_client = session.client('ssm')
    return ssm_client.get_parameter(
        Name='$local_elasticache_ep', WithDecryption=True)

def write_into_redis_cluster(endpoint, cityname):
    logging.basicConfig(level=logging.INFO)
    client = pylibmc.Client([MEMCACHED_ENDPOINT], binary=True, behaviors={"tcp_nodelay": True, "ketama": True})
    key = 'City'
    client.set(key, cityname)
main()
EOF