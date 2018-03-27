import os

CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 300,
    'CACHE_KEY_PREFIX': 'superset_',
    'CACHE_REDIS_HOST': 'redis',
    'CACHE_REDIS_PORT': 6379,
    'CACHE_REDIS_DB': 1,
    'CACHE_REDIS_URL': 'redis://redis:6379/1'}
SQLALCHEMY_DATABASE_URI = \
    'postgresql+psycopg2://superset:superset@postgres:5432/superset'
SQLALCHEMY_TRACK_MODIFICATIONS = True
SECRET_KEY = 'thisISaSECRET_1234'

BASE_DIR = os.path.abspath(os.path.dirname(__file__))

if 'SUPERSET_HOME' in os.environ:
    print("USE SUPERSET_HOME: " + os.environ['SUPERSET_HOME'])
    superset_home = os.environ['SUPERSET_HOME']
    UPLOAD_FOLDER = os.path.join(superset_home, 'uploads/')
    IMG_UPLOAD_FOLDER = os.path.join(superset_home, 'uploads/')
else:
    print("NO SUPERSET_HOME specified")