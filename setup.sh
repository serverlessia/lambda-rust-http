#!/bin/bash

# Setup script for Rust Lambda ARM64 builds
set -e

echo "🚀 Setting up Rust Lambda development environment..."

# Check if Zig is already installed
if ! command -v zig &> /dev/null; then
    echo "📦 Installing Zig 0.13.0..."
    
    # Download and install Zig
    ZIG_VERSION="0.13.0"
    ZIG_DIR="zig-linux-x86_64-${ZIG_VERSION}"
    
    if [ ! -d "$ZIG_DIR" ]; then
        curl -L "https://ziglang.org/download/${ZIG_VERSION}/zig-linux-x86_64-${ZIG_VERSION}.tar.xz" -o zig.tar.xz
        tar -xf zig.tar.xz
        rm zig.tar.xz
    fi
    
    # Add Zig to PATH for this session
    export PATH="$PWD/$ZIG_DIR:$PATH"
    echo "export PATH=\"$PWD/$ZIG_DIR:\$PATH\"" >> ~/.bashrc
    
    echo "✅ Zig installed successfully"
else
    echo "✅ Zig already installed: $(zig version)"
fi

# Check if ARM64 target is installed
if ! rustup target list --installed | grep -q "aarch64-unknown-linux-gnu"; then
    echo "🎯 Installing ARM64 Rust target..."
    rustup target add aarch64-unknown-linux-gnu
    echo "✅ ARM64 target installed"
else
    echo "✅ ARM64 target already installed"
fi

# Verify cargo-lambda setup
echo "🔍 Verifying cargo-lambda setup..."
cargo lambda system

echo ""
echo "🎉 Setup complete! You can now run:"
echo "   cargo lambda build --release --arm64"
echo ""
echo "💡 To make Zig available in new terminals, run:"
echo "   source ~/.bashrc"
