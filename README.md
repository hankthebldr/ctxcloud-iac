# Cortex Cloud CTF Infrastructure as Code

Welcome to the `ctxcloud-iac` repository! This project provides a comprehensive infrastructure as code (IaC) template to deploy a fully functional Capture The Flag (CTF) environment on Cortex Cloud, leveraging the popular CTFd.io platform. The setup is tailored for security enthusiasts and professionals participating in or organizing a cloud-based CTF, featuring a robust network architecture with a 2-zone Virtual Private Cloud (VPC), a Palo Alto Networks Next-Generation Firewall (PAN NGFW) for traffic control, and a single-node Kubernetes server hosting the CTFd.io application or related services.

This README is designed to be verbose, offering step-by-step guidance, detailed explanations of the architecture, and clear instructions for deployment and usage. Whether you're new to infrastructure as code or an experienced cloud architect, you'll find everything you need to get started.

## Project Overview

The purpose of this repository is to simplify the deployment of a CTF environment on Cortex Cloud. The infrastructure includes:

- **A 2-Zone VPC**: A virtual network segmented into a public zone and a private zone for enhanced security and isolation.
- **PAN NGFW**: A virtualized Palo Alto Networks Next-Generation Firewall that mediates traffic between the zones and the internet.
- **Public Zone**: The externally accessible portion of the network, designed to handle incoming traffic.
- **Private Zone**: A secure, isolated segment hosting the single-node Kubernetes server.
- **Kubernetes Server**: A single-node Kubernetes instance in the private zone, intended to run the CTFd.io application or other CTF-related services.

This IaC template assumes the use of Terraform, a widely adopted tool for defining and provisioning cloud infrastructure, although Cortex Cloud specifics might require adjustments based on its platform offerings.

## Architecture Overview

The infrastructure is meticulously designed to balance accessibility and security, making it ideal for a CTF where participants may interact with or exploit network configurations. Here’s a detailed breakdown:

### Components

- **Virtual Private Cloud (VPC)**:
  - A logically isolated network within Cortex Cloud.
  - Divided into two subnets:
    - **Public Subnet**: Connected to the internet via an internet gateway, this subnet hosts the external-facing interface of the PAN NGFW.
    - **Private Subnet**: Isolated from direct internet access, this subnet contains the internal interface of the PAN NGFW and the Kubernetes server.

- **Palo Alto Networks Next-Generation Firewall (PAN NGFW)**:
  - Deployed as a virtual appliance within the VPC.
  - Features two network interfaces:
    - **Untrust Interface**: Resides in the public subnet, exposed to incoming internet traffic.
    - **Trust Interface**: Located in the private subnet, connected to the Kubernetes server.
  - Configured with security policies to filter and control traffic, such as allowing HTTP/HTTPS access to the CTFd.io service while blocking unauthorized access.

- **Kubernetes Server**:
  - A single-node Kubernetes cluster deployed in the private subnet.
  - Designed to host the CTFd.io web application, which serves as the CTF platform, and potentially other challenge-related services.
  - Uses a lightweight Kubernetes distribution (e.g., k3s) suitable for single-node deployments, balancing simplicity and functionality.

### Architecture Diagram

To visualize the setup, here’s a textual representation of the architecture:

Internet
  |
  +--------------------------------+
  |                                |
Internet Gateway                 |
  |                                |
  +--------------------------------+
  |
Public Subnet
  |--- PAN NGFW (Untrust Interface)
  |      |
  |      | Security Policies
  |      |
  +--------------------------------+
         |
Private Subnet                   |
  |--- PAN NGFW (Trust Interface) |
  |                               |
  |--- Kubernetes Server ---------+
        (Running CTFd.io)

### Traffic Flow

The flow of traffic through the infrastructure is as follows:

1. **External Access**: Participants or users access the CTF environment from the internet.
2. **Internet Gateway**: Traffic enters the VPC through the internet gateway attached to the public subnet.
3. **PAN NGFW (Untrust Interface)**: The firewall’s public-facing interface receives the incoming traffic.
4. **Security Policies**: The NGFW evaluates the traffic against its rules (e.g., allowing HTTP on port 80 and HTTPS on port 443).
5. **PAN NGFW (Trust Interface)**: Permitted traffic is forwarded to the private subnet.
6. **Kubernetes Server**: The single-node Kubernetes cluster receives the traffic and serves the CTFd.io application or other services to the users.

This design ensures that the Kubernetes server remains shielded from direct internet exposure, with all access mediated by the firewall.

## Prerequisites

Before deploying this IaC template, ensure you have the following:

- **Cortex Cloud Account**:
  - An active account with Cortex Cloud.
  - Sufficient permissions to create VPCs, subnets, firewall instances, and compute resources.
  - Access to Cortex Cloud’s API or management interface.

- **Terraform**:
  - Installed on your local machine or deployment environment.
  - Download it from the [official Terraform website](https://www.terraform.io/downloads.html) if needed.
  - Version 1.0.0 or later is recommended for compatibility.

- **Cortex Cloud Credentials**:
  - Configured authentication credentials (e.g., API keys, access tokens) for Terraform to interact with Cortex Cloud.
  - Typically set via environment variables or a credentials file, as per Cortex Cloud’s documentation.

- **Basic Tools**:
  - Git installed to clone the repository.
  - A terminal or command-line interface to execute commands.
  - Optional: An SSH client to access the Kubernetes server post-deployment, if needed.

## Installation and Setup

Deploying the CTF environment involves cloning the repository, configuring settings, and applying the Terraform configuration. Follow these detailed steps:

1. **Clone the Repository**:
   - Open your terminal and run:
     ```bash
     git clone https://github.com/hankthebldr/ctxcloud-iac.git
     ```
   - Navigate into the project directory:
     ```bash
     cd ctxcloud-iac
     ```

2. **Configure Cortex Cloud Credentials**:
   - Ensure your Cortex Cloud credentials are available to Terraform.
   - Example (using environment variables, adjust as per Cortex Cloud’s requirements):
     ```bash
     export CORTEX_CLOUD_API_KEY="your-api-key"
     export CORTEX_CLOUD_SECRET="your-secret"
     ```
   - Alternatively, configure a credentials file if specified by Cortex Cloud documentation.

3. **Review and Customize Variables**:
   - Open the `variables.tf` file in a text editor.
   - This file contains customizable parameters, such as:
     - `region`: The Cortex Cloud region to deploy in (e.g., `us-east-1`).
     - `instance_type`: The size of the Kubernetes server instance (e.g., `t3.medium`).
     - `vpc_cidr`: The CIDR block for the VPC (e.g., `10.0.0.0/16`).
   - Edit these values to match your preferences or requirements.

4. **Initialize Terraform**:
   - Run the following command to download the necessary provider plugins and initialize the working directory:
     ```bash
     terraform init
     ```
   - You should see output confirming that Terraform has been initialized successfully.

5. **Plan the Deployment**:
   - Generate an execution plan to preview the resources Terraform will create:
     ```bash
     terraform plan
     ```
   - Review the plan carefully. It will list the VPC, subnets, PAN NGFW, Kubernetes server, and other resources to be provisioned.
   - Ensure the plan aligns with your expectations before proceeding.

6. **Apply the Configuration**:
   - Deploy the infrastructure by applying the Terraform configuration:
     ```bash
     terraform apply
     ```
   - Terraform will prompt you to confirm the action. Type `yes` and press Enter.
   - The deployment process may take several minutes, depending on Cortex Cloud’s provisioning speed.
   - Upon completion, Terraform will display outputs, such as the public URL or IP address to access the CTFd.io platform.

7. **Set Up CTFd.io**:
   - The IaC template provisions the infrastructure, but additional steps are required to deploy the CTFd.io application on the Kubernetes server.
   - Retrieve the SSH access details from the Terraform output (e.g., IP address and key pair).
   - Connect to the Kubernetes server:
     ```bash
     ssh -i <key.pem> user@<kubernetes-ip>
     ```
   - Inside the server, execute the provided setup script:
     ```bash
     ./setup_ctfd.sh
     ```
   - This script (assumed to be included in the repo) will:
     - Install a single-node Kubernetes distribution (e.g., k3s).
     - Deploy the CTFd.io application using a predefined configuration or Helm chart.
     - Configure necessary services and networking.
   - Follow any on-screen instructions to complete the setup.

After these steps, the CTF environment will be fully operational, with CTFd.io accessible via the URL provided in the Terraform output.

## Repository Structure

The repository includes the following key files:

- **`main.tf`**:
  - The primary Terraform configuration file defining the VPC, subnets, PAN NGFW, and Kubernetes server.

- **`variables.tf`**:
  - Contains variable definitions for customizing the deployment (e.g., region, instance sizes).

- **`outputs.tf`**:
  - Specifies the outputs provided after deployment, such as the CTFd.io URL and SSH access details.

- **`provider.tf`**:
  - Configures the Cortex Cloud provider for Terraform (hypothetical, adjust based on actual provider).

- **`setup_ctfd.sh`**:
  - A script to install Kubernetes and deploy CTFd.io on the server (assumed for this setup).

## Usage

Once the infrastructure is deployed and CTFd.io is set up, here’s how to use it:

- **Accessing CTFd.io**:
  - Open a web browser and navigate to the URL output by Terraform (e.g., `http://<public-ip>` or a DNS name).
  - Register or log in to the CTFd.io platform to participate in or manage the CTF.

- **Managing the Infrastructure**:
  - To update the setup (e.g., modify firewall rules or instance sizes):
    - Edit the Terraform files as needed.
    - Run `terraform plan` and `terraform apply` again.
  - To tear down the environment when finished:
    ```bash
    terraform destroy
    ```
    - Confirm with `yes` when prompted. This will remove all provisioned resources.

- **CTF Organizers**:
  - After deployment, configure CTFd.io with your challenges, categories, and user settings via its admin interface.