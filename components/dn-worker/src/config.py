import os

ETCD_URL = os.getenv('ETCD_URL', 'http://192.168.2.125:12379')
SWARM_URL = os.getenv('SWARM_URL', 'tcp://192.168.2.125:2375') 

BASE_DIR = '/death-note/v1'
CONTAINERS_DIR = '/'.join((BASE_DIR, 'containers')) + '/'
