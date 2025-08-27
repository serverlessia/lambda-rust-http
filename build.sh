#!/bin/bash

set -e

echo "🚀 Building Lambda Rust HTTP function..."

# Check if cargo-lambda is installed
if ! command -v cargo-lambda &> /dev/null; then
    echo "❌ cargo-lambda not found. Installing..."
    cargo install cargo-lambda
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
cargo clean

# Build the release binary
echo "🔨 Building ARM64 binary..."
cargo lambda build --release --arm64

# Check if binary was created
if [ ! -f "target/lambda/lambda-rust-http/bootstrap" ]; then
    echo "❌ Binary not found at target/lambda/lambda-rust-http/bootstrap"
    exit 1
fi

echo "✅ Build successful!"
echo "📦 Binary location: target/lambda/lambda-rust-http/bootstrap"
echo "📏 Binary size: $(du -h target/lambda/lambda-rust-http/bootstrap | cut -f1)"

# Create deployment package
echo "📦 Creating deployment package..."
cd target/lambda/lambda-rust-http
zip -r lambda-rust-http.zip bootstrap
cd ../../..

echo "🎉 Deployment package ready at: target/lambda/lambda-rust-http/lambda-rust-http.zip"
echo "📏 Package size: $(du -h target/lambda/lambda-rust-http/lambda-rust-http.zip | cut -f1)"
echo ""
echo "🚀 Ready to deploy with Terraform!"
echo "   cd infra && terraform apply"
