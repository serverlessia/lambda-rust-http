# Lambda Rust HTTP

A minimal AWS Lambda example in Rust that responds with **"Hello, world!"** via API Gateway, with developer-friendly Devcontainer setup.

## 🚀 Quick Start

### Prerequisites

- Docker Desktop
- VS Code with Dev Containers extension
- AWS CLI configured with appropriate credentials

### 1. Open in Dev Container

1. Clone this repository
2. Open in VS Code
3. When prompted, click "Reopen in Container"
4. Wait for the container to build and install dependencies

### 2. Local Development

```bash
# Watch for changes and run locally
cargo lambda watch

# In another terminal, test locally
curl http://localhost:9000/
# Response: {"message":"Hello, world!"}
```

### 3. Build for Production

```bash
# Build ARM64 binary for AWS Lambda
cargo lambda build --release --arm64

# The binary will be created at:
# target/lambda/lambda-rust-http/bootstrap
```

### 4. Deploy to AWS

```bash
# Navigate to infrastructure directory
cd infra

# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Deploy infrastructure
terraform apply

# Get the API Gateway URL
terraform output api_gateway_url
```

### 5. Test the Deployed Function

```bash
# Test with the URL from terraform output
curl https://<api-id>.execute-api.<region>.amazonaws.com/prod/
# Response: {"message":"Hello, world!"}
```

## 🏗️ Project Structure

```plaintext
lambda-rust-http/
├── .devcontainer/          # VS Code Dev Container config
│   ├── devcontainer.json   # Container settings
│   └── Dockerfile         # Container image
├── src/
│   └── main.rs            # Lambda function code
├── infra/                  # Terraform infrastructure
│   ├── main.tf            # Main infrastructure config
│   ├── variables.tf       # Variable definitions
│   └── outputs.tf         # Output values
├── Cargo.toml             # Rust dependencies
└── README.md              # This file
```

## 🔧 Development Workflow

1. **Local Development**: Use `cargo lambda watch` for hot reloading
2. **Testing**: Test locally before deploying
3. **Build**: Use `cargo lambda build --release --arm64` for production
4. **Deploy**: Use Terraform to deploy infrastructure
5. **Test**: Verify the deployed function works

## 📦 Build Artifacts

The build process creates:

- **Binary**: `target/lambda/lambda-rust-http/bootstrap` (ARM64)
- **Package**: `target/lambda/lambda-rust-http.zip` (for Terraform)

## 🌐 API Endpoints

- **Root**: `GET /` → Returns `{"message":"Hello, world!"}`
- **Any Path**: `ANY /{proxy+}` → Same response (handles all routes)

## 🛠️ Technologies Used

- **Rust**: Programming language
- **lambda_http**: AWS Lambda HTTP runtime
- **cargo-lambda**: Build tool for Rust Lambda functions
- **Terraform**: Infrastructure as Code
- **Dev Containers**: Consistent development environment

## 📚 Reference

This implementation is based on the official AWS sample template:
👉 [**basic-http-function** example in aws-lambda-rust-runtime](https://github.com/awslabs/aws-lambda-rust-runtime/tree/main/examples/basic-http-function)

## 🔍 Troubleshooting

### Common Issues

1. **Build fails**: Ensure you're using the Dev Container with Rust 1.70+
2. **Terraform errors**: Check AWS credentials and region configuration
3. **Lambda cold start**: First invocation may be slower

### Useful Commands

```bash
# Check Rust version
rustc --version

# Check cargo-lambda installation
cargo lambda --version

# Check AWS CLI
aws --version

# Check Terraform
terraform --version
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
