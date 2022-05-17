## Virtual Cloud Network'da kullandığımız Security listesinde Kubernetes Cluster için kullandığımız portlar.
---
| Stateless | Source      | IP Protocol | Source Port Range | Type and Code | Description | Actions                                             |
|-----------|-------------|-------------|-------------------|---------------|-------------|-----------------------------------------------------|
| No        | 0.0.0.0/0   | TCP         | All               | 30000-32767   |             | TCP traffic for ports: 30000-32767       |
| No        | 0.0.0.0/0 | TCP         | All               | 80            |             | TCP traffic for ports: 80                           |
| No        | 0.0.0.0/0   | TCP         | All               | 443           |             | TCP traffic for ports: 443
| No        | 10.0.3.0/24 | TCP         | All               | ALL           |             | TCP traffic for ports: All
| No        | 10.0.3.0/24 | TCP         | All              | 6443          |             | TCP traffic for ports: 6443                         |
| No        | 10.0.3.0/24 | TCP         | All               | 7946          |             | TCP traffic for ports: 7946                         |
| No        | 10.0.3.0/24 | TCP         | All               | 8443          |             | TCP traffic for ports: 8443                         |
| No        | 10.0.3.0/24 | UDP         | All               | 7946          |             | UDP traffic for ports: 7946                         |
| No        | 10.0.3.0/24 | TCP         | All               | 80            |             | TCP traffic for ports: 80                           |
| No        | 10.0.3.0/24 | TCP         | All               | 443           |             | TCP traffic for ports: 443
| No        | 10.0.3.0/24 | ICMP        |                   | ALL           |             | ICMP traffic for: All
