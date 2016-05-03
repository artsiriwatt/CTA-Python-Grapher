dropdb --if-exists cta
createdb cta
psql -d cta < schema.sql