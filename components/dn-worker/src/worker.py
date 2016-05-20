import logging
import signal
import sys

from config import ETCD_URL
from config import SWARM_URL
from docker import errors as docker_errors
from libwatcher import get_death_watcher

_log = logging.getLogger(__name__)


def signal_handler(signal_, frame):
    _log.critical("KeyboardInterrupt: Stopped.")
    sys.exit(0)


def parse_container_id(key):
    return key.split('/')[-1]


def start_worker():
    signal.signal(signal.SIGINT, signal_handler)

    _log.debug("Create Death Watcher...")
    death_watcher = get_death_watcher(SWARM_URL, ETCD_URL)
    for o in death_watcher.watch_containers(timeout=0):
        _log.debug("Watching All Containers...")
        try:
            container_id = parse_container_id(o.key)
        except Exception, e:
            logging.error("parse ContainerId failed: %s, got key: %s.", e.message, o.key)
            continue

        try:
            action_dict = {
                'delete': 'pause',
                'set': 'unpause',
                'expire': 'pause'
            }
            action = action_dict.get(o.action, 'UNKNOW')
            _log.debug("Etcd object action is %s, docker action is: %s, container is: %s.",
                       o.action, action, container_id)
            if action == 'pause':
                death_watcher.pause_container(container_id)
            elif action == 'unpause':
                death_watcher.unpause_container(container_id)
        except docker_errors.APIError, e:
            logging.error("Docker APIError, Refresh Container failed: %s.", e.explanation)
        except Exception, e:
            logging.error("Refresh Container failed: %s.", e.message)
