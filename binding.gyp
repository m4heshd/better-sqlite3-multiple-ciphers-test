# ===
# This is the main GYP file, which builds better-sqlite3 with SQLite3 itself.
# ===

{
  'includes': ['deps/common.gypi'],
  'targets': [
    {
      'target_name': 'better_sqlite3',
      'dependencies': ['deps/sqlite3.gyp:sqlite3'],
      'sources': ['src/better_sqlite3.cpp'],
      'cflags': ['-std=c++14', '-msse4.2', '-maes'],
      'cflags_cc': ['-std=c++14', '-msse4.2', '-maes'],
      'xcode_settings': {
        'OTHER_CPLUSPLUSFLAGS': ['-std=c++14', '-stdlib=libc++', '-msse4.2', '-maes'],
      },
    },
    {
      'target_name': 'test_extension',
      'dependencies': ['deps/sqlite3.gyp:sqlite3'],
      'conditions': [['sqlite3 == ""', { 'sources': ['deps/test_extension.c'] }]],
    },
  ],
}
