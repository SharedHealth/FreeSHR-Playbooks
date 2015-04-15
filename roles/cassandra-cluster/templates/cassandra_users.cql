ALTER KEYSPACE system_auth WITH REPLICATION =
  { 'class' : '{{ cassandra_replication_strategy }}', 'replication_factor' : {{ groups['cassandra_node'] | length }}  };

ALTER USER cassandra WITH PASSWORD '{{ cassandra_admin_pass }}';
