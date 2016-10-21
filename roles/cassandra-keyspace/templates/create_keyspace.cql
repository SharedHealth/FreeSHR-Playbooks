CREATE KEYSPACE IF NOT EXISTS {{ cassandra_keyspace }} WITH REPLICATION =
  { 'class' : '{{ cassandra_keyspace_replication_strategy }}', 'replication_factor' : {{ cassandra_keyspace_replication_factor }}  };

CREATE USER IF NOT EXISTS {{ cassandra_keyspace_user }} WITH PASSWORD '{{ cassandra_keyspace_pass }}' NOSUPERUSER;
ALTER USER {{ cassandra_keyspace_user }} WITH PASSWORD '{{ cassandra_keyspace_pass }}' NOSUPERUSER;
GRANT ALL ON KEYSPACE {{ cassandra_keyspace }} TO {{ cassandra_keyspace_user }} ;
