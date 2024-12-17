Architure of the solution:
------

![architecture image](extras/architecture.png)

Assumptions:
------

1. ECS in a private subnet.

⋅⋅⋅In general, anything that deals with sensitive data should not be exposed directly to the internet. The app is assumed to be a backend app that will potentially connect to a database and will deal with sensitive data, so having it not exposed directly to the public is important. In this case, I have a ALB deployed in the public subnets that is accessible by the public and acts as a proxy to the flask application. 

2. The use of NAT Gateway instead of VPCE to connect to the ECR.

⋅⋅⋅VPCE is a lower cost alternative to NAT Gateway only if the app only requires ECR connection but this solution assumes that the desployed application needs to have access to the internet if there are runtime tasks that need internet connection.


