.PHONY: help build clean watch deploy destroy test

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Build the Lambda function for production
	@echo "🔨 Building Lambda function..."
	cargo lambda build --release --arm64
	@echo "✅ Build complete!"

clean: ## Clean build artifacts
	@echo "🧹 Cleaning build artifacts..."
	cargo clean
	@echo "✅ Clean complete!"

watch: ## Watch for changes and run locally
	@echo "👀 Starting cargo lambda watch..."
	cargo lambda watch

deploy: build ## Build and deploy to AWS
	@echo "🚀 Deploying to AWS..."
	cd infra && terraform init && terraform apply -auto-approve
	@echo "✅ Deployment complete!"

destroy: ## Destroy AWS infrastructure
	@echo "🗑️  Destroying AWS infrastructure..."
	cd infra && terraform destroy -auto-approve
	@echo "✅ Destruction complete!"

test: ## Test the deployed function
	@echo "🧪 Testing deployed function..."
	@cd infra && terraform output -raw api_gateway_url | xargs -I {} curl -s {} | jq .

plan: ## Plan Terraform changes
	@echo "📋 Planning Terraform changes..."
	cd infra && terraform plan

fmt: ## Format Rust code
	@echo "🎨 Formatting Rust code..."
	cargo fmt

check: ## Check Rust code
	@echo "🔍 Checking Rust code..."
	cargo check

clippy: ## Run Clippy linter
	@echo "🔍 Running Clippy..."
	cargo clippy

install-deps: ## Install development dependencies
	@echo "📦 Installing development dependencies..."
	cargo install cargo-lambda
	@echo "✅ Dependencies installed!"
