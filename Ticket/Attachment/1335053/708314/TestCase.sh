set -e
DB_NAME="test_case"
createdb $DB_NAME

psql -c "CREATE TABLE person (     \
    id SERIAL PRIMARY KEY,         \
    name TEXT NOT NULL);" $DB_NAME

psql -c "CREATE TABLE person_address (id SERIAL PRIMARY KEY, \
    person_id INTEGER NOT NULL REFERENCES person,            \
    street TEXT CHECK (street <> 'zzz___zzz'),               \
    town   TEXT CHECK (town   <> 'zzz___zzz')                \
    );" $DB_NAME

psql -c "CREATE UNIQUE INDEX uniq_person_address ON person_address \
            (                                                      \
                person_id,                                         \
                COALESCE(street, 'zzz___zzz'),                     \
                COALESCE(town,   'zzz___zzz')                      \
            );" $DB_NAME

dbicdump -o dump_directory=./lib              \
         -o debug=1                           \
         TestCase::Schema                     \
         "dbi:Pg:dbname=${DB_NAME};port=5433" \
         $USER                                \
         ''
