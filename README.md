
CI/CD Pipeline for Node.js Web Application with AWS ECS and ECR
================================================================

This repository contains a GitHub Actions workflow designed to automate the deployment of a Node.js web application to AWS ECS (Elastic Container Service), utilizing Amazon ECR (Elastic Container Registry) for storing Docker images. The pipeline includes steps for building and optimizing the Docker image, pushing it to ECR, deploying it to ECS, performing integration tests, and rolling back if the deployment fails.

Prerequisites
-------------

Before setting up the CI/CD pipeline, ensure the following:

- AWS Account: An active AWS account with the necessary IAM permissions to create and manage ECS, ECR, EC2, and other related resources.
- GitHub Secrets: Configure the following secrets in your GitHub repository:
  - AWS_ACCESS_KEY_ID: Your AWS access key ID.
  - AWS_SECRET_ACCESS_KEY: Your AWS secret access key.
  - AWS_REGION: The AWS region where your resources are deployed.
  - AWS_ACCOUNT_ID: Your AWS account ID.
  - ECR_REPOSITORY: The name of your ECR repository.
  - ECS_CLUSTER: The name of your ECS cluster.
  - ECS_SERVICE: The name of your ECS service.

Steps to Set Up
---------------

1. Create ECR Repository
   ----------------------

   Ensure that the ECR repository where the Docker image will be stored is created. You can create the ECR repository using the following AWS CLI command:

   ```sh
   aws ecr create-repository --repository-name <your-repo-name> --region <your-region>
   ```

2. Create a Launch Template
   ------------------------

   Create a launch template with an AMI that has the ECS agent configured. Include user data that references the ECS cluster name. Using the launch template, create an auto-scaling group.

3. Create an ECS Cluster
   ---------------------

   Create an ECS cluster by referencing the auto-scaling group and EC2 instances. Provision necessary network configurations, such as VPC, subnets, and security groups.

4. Create a Task Definition and Service
   ------------------------------------

   Define a task definition for your Node.js application. Create a service inside the ECS cluster using the task definition.

5. Configure GitHub Actions
   -------------------------

   The CI/CD pipeline is defined in the `.github/workflows/ci-cd-pipeline.yml` file. The pipeline automates the following steps:

   1. Check out the code from the GitHub repository.
   2. Build an optimized Docker image with a multi-stage build.
   3. Push the Docker image to Amazon ECR.
   4. Deploy the image to AWS ECS.
   5. Perform rollback on failure using ECS's built-in circuit breaker.

Running the CI/CD Pipeline
--------------------------

- Automatic Trigger: Push changes to the `master` branch to trigger the pipeline automatically.
- Manual Trigger: Alternatively, you can manually trigger the workflow from the GitHub Actions tab using `workflow_dispatch`.

Rollback Mechanism
------------------

The pipeline ensures that if any step in the deployment fails, the service will automatically roll back to the previous stable version using ECS's circuit breaker feature.

Conclusion
----------

This CI/CD pipeline offers a robust and automated approach to deploying Node.js applications on AWS ECS, leveraging Amazon ECR for Docker image storage. It guarantees that your application is always running a stable version, with the capability to roll back in case of any issues.
