select net_transport, auth_scheme, encrypt_option,local_tcp_port, local_net_address
from sys.dm_exec_connections
where session_id = @@SPID