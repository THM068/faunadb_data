final String APP_KEY = 'app.key';
final String CURRENT_USER_KEY = 'current.user.key';
final String AUTHENTICATED_USER_KEY = 'authenticated.user.key';

Map FAUNADB_DATA_KEY_MAP = {
  APP_KEY: '',
  CURRENT_USER_KEY: '',
  AUTHENTICATED_USER_KEY: ''
};

Map getFaunaDbConfig() => FAUNADB_DATA_KEY_MAP;

void setApplicationDbKey(String appKey) {
  FAUNADB_DATA_KEY_MAP[APP_KEY] = appKey;
}

String getApplicationDBKey() => getFaunaDbConfig()[APP_KEY];

void setCurrentUserDbKey(String key) {
  FAUNADB_DATA_KEY_MAP[CURRENT_USER_KEY] = key;
}

String getCurrentUserDbKey() => getFaunaDbConfig()[CURRENT_USER_KEY];

String getAuthenticatedDbKey() => getFaunaDbConfig()[AUTHENTICATED_USER_KEY];

void setAuthenticatedDbKey(String key) {
  FAUNADB_DATA_KEY_MAP[AUTHENTICATED_USER_KEY] = key;
}