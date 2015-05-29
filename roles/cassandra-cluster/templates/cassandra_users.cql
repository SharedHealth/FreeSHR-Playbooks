ALTER KEYSPACE system_auth WITH REPLICATION =
  { 'class' : '{{ cassandra_sys_auth_replication_strategy }}', 'replication_factor' : '{{ cassandra_sys_auth_replication_factor }}'  };

ALTER USER cassandra WITH PASSWORD '{{ cassandra_admin_pass }}';
