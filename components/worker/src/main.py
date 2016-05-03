import logging

from worker import start_worker

logging.basicConfig(level=logging.DEBUG)

if __name__ == '__main__':
    start_worker()
